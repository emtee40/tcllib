::tool::define ::httpd::content.redirect {

  method reset {} {
    ###
    # Inject the location into the HTTP headers
    ###
    my variable reply_body
    set reply_body {}
    my reply replace    [my HttpHeaders_Default]
    my reply set Server [my <server> cget server_string]
    set msg [my http_info get LOCATION]
    my reply set Location [my http_info get LOCATION]
    set code  [my http_info getnull REDIRECT_CODE]
    if {$code eq {}} {
      set code 301
    }
    my reply set Status [list $code [my http_code_string $code]]
  }

  method content {} {
    set template [my <server> template redirect]
    set msg [my http_info get LOCATION]
    set HTTP_STATUS [my reply get Status]
    my puts [subst $msg]
  }
}

::tool::define ::httpd::content.cache {

  method dispatch {newsock datastate} {
    my http_info replace $datastate
    my request replace  [dict get $datastate http]
    my variable chan
    set chan $newsock
    chan event $chan readable {}
    try {
      my log Dispatched [dict create ip: [my http_info get REMOTE_ADDR] host: [my http_info get REMOTE_HOST] cookie: [my request get COOKIE] referrer: [my request get REFERER] user-agent: [my request get USER_AGENT] uri: [my http_info get REQUEST_URI] host: [my http_info getnull HTTP_HOST]]
      my wait writable $chan
      chan configure $chan  -translation {binary binary}
      chan puts -nonewline $chan [my http_info get CACHE_DATA]
    } on error {err info} {
      my <server> debug [dict get $info -errorinfo]
    } finally {
      my TransferComplete $chan
    }
  }
}
