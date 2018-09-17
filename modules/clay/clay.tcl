
###
# clay.tcl
#
# Copyright (c) 2018 Sean Woods
#
# BSD License
###
# @@ Meta Begin
# Package clay 0.3
# Meta platform     tcl
# Meta summary      A minimalist framework for complex TclOO development
# Meta description  This package introduces the method "clay" to both oo::object
# Meta description  and oo::class which facilitate complex interactions between objects
# Meta description  and their ancestor and mixed in classes.
# Meta category     TclOO
# Meta subject      framework
# Meta require      {Tcl 8.6}
# Meta author       Sean Woods
# Meta license      BSD
# @@ Meta End

###
# Amalgamated package for clay
# Do not edit directly, tweak the source in src/ and rerun
# build.tcl
###
package provide clay 0.3
namespace eval ::clay {}

###
# START: core.tcl
###
###
# END: core.tcl
###
###
# START: procs.tcl
###
###
# END: procs.tcl
###
###
# START: class.tcl
###
###
# END: class.tcl
###
###
# START: object.tcl
###
###
# END: object.tcl
###
###
# START: metaclass.tcl
###
###
# END: metaclass.tcl
###
###
# START: ensemble.tcl
###
###
# END: ensemble.tcl
###
###
# START: doctool.tcl
###
namespace eval ::clay {}

###
# Concatenate a file
###
proc ::clay::cat fname {
    if {![file exists $fname]} {
       return
    }
    set fin [open $fname r]
    set data [read $fin]
    close $fin
    return $data
}

###
# Append a line of text to a variable. Optionally apply a string mapping.
# arglist:
#   map {mandatory 0 positional 1}
#   text {mandatory 1 positional 1}
###
proc ::putb {buffername args} {
  upvar 1 $buffername buffer
  switch [llength $args] {
    1 {
      append buffer [lindex $args 0] \n
    }
    2 {
      append buffer [string map {*}$args] \n
    }
    default {
      error "usage: putb buffername ?map? string"
    }
  }
}

###
# Tool for build scripts to dynamically generate manual files from comments
# in source code files
###
oo::class create ::clay::doctool {
  constructor {} {
    my variable coro
    set coro [info object namespace [self]]::coro
    oo::objdefine [self] forward coro $coro
    coroutine $coro {*}[namespace code {my reset}]
  }

  ###
  # Process an argument list into an informational dict.
  # This method also understands non-positional
  # arguments expressed in the notation of Tip 471
  # [uri https://core.tcl-lang.org/tips/doc/trunk/tip/479.md].
  # [para]
  # The output will be a dictionary of all of the fields and whether the fields
  # are [const positional], [const mandatory], and whether they have a
  # [const default] value.
  # [para]
  # [example {
  #   my arglist {a b {c 10}}
  #
  #   > a {positional 1 mandatory 1} b {positional 1 mandatory 1} c {positional 1 mandatory 0 default 10}
  # }]
  ###
  method arglist {arglist} {
    set result [dict create]
    foreach arg $arglist {
      set name [lindex $arg 0]
      dict set result $name positional 1
      dict set result $name mandatory  1
      if {$name in {args dictargs}} {
        switch [llength $arg] {
          1 {
            dict set result $name mandatory 0
          }
          2 {
            dict for {optname optinfo} [lindex $arg 1] {
              set optname [string trim $optname -:]
              dict set result $optname {positional 1 mandatory 0}
              dict for {f v} $optinfo {
                dict set result $optname [string trim $f -:] $v
              }
            }
          }
          default {
            error "Bad argument"
          }
        }
      } else {
        switch [llength $arg] {
          1 {
            dict set result $name mandatory 1
          }
          2 {
            dict set result $name mandatory 0
            dict set result $name default   [lindex $arg 1]
          }
          default {
            error "Bad argument"
          }
        }
      }
    }
    return $result
  }

  ###
  # Convert a block of comments into an informational dictionary.
  # If lines in the comment start with a single word ending in a colon,
  # all subsequent lines are appended to a dictionary field of that name.
  # If no fields are given, all of the text is appended to the [const description]
  # field.
  # Example:
  # my comment {Does something cool}
  # > description {Does something cool}
  #
  # my comment {
  # title : Something really cool
  # author : Sean Woods
  # author : John Doe
  # description :
  # This does something really cool!
  # }
  # > description {This does something really cool!}
  #   title {Something really cool}
  #   author {Sean Woods
  #   John Doe}
  ###
  method comment block {
    set count 0
    set field description
    set result [dict create description {}]
    foreach line [split $block \n] {
      set line [string trim $line]
      set fwidx [string first " " $line]
      if {$fwidx < 0} {
        set firstword [string range $line 0 end]
        set restline {}
      } else {
        set firstword [string range $line 0 [expr {$fwidx-1}]]
        set restline [string range $line [expr {$fwidx+1}] end]
      }
      if {[string index $firstword end] eq ":"} {
        set field [string tolower [string trim $firstword -:]]
        switch $field {
          desc {
            set field description
          }
        }
        if {[string length $restline]} {
          dict append result $field "$restline\n"
        }
      } else {
        dict append result $field "$line\n"
      }
    }
    return $result
  }

  ###
  # Process an oo::objdefine call that modifies the class object
  # itself
  ####
  method keyword.Class {resultvar commentblock name body} {
    upvar 1 $resultvar result
    set name [string trim $name :]
    if {[dict exists $result class $name]} {
      set info [dict get $result class $name]
    } else {
      set info [my comment $commentblock]
    }
    set commentblock {}
    foreach line [split $body \n] {
      append thisline $line \n
      if {![info complete $thisline]} continue
      set thisline [string trim $thisline]
      if {[string index $thisline 0] eq "#"} {
        append commentblock [string trimleft $thisline #] \n
        set thisline {}
        continue
      }
      set cmd [string trim [lindex $thisline 0] ":"]
      switch $cmd {
        method -
        Ensemble {
          my keyword.class_method info $commentblock  {*}[lrange $thisline 1 end-1]
          set commentblock {}
        }
      }
      set thisline {}
    }
    dict set result class $name $info
  }

  method keyword.class {resultvar commentblock name body} {
    upvar 1 $resultvar result
    set name [string trim $name :]
    if {[dict exists $result class $name]} {
      set info [dict get $result class $name]
    } else {
      set info [my comment $commentblock]
    }
    set commentblock {}
    foreach line [split $body \n] {
      append thisline $line \n
      if {![info complete $thisline]} continue
      set thisline [string trim $thisline]
      if {[string index $thisline 0] eq "#"} {
        append commentblock [string trimleft $thisline #] \n
        set thisline {}
        continue
      }
      set cmd [string trim [lindex $thisline 0] ":"]
      switch $cmd {
        superclass {
          dict set info ancestors [lrange $thisline 1 end]
          set commentblock {}
        }
        class_method {
          my keyword.class_method info $commentblock  {*}[lrange $thisline 1 end-1]
          set commentblock {}
        }
        destructor -
        constructor {
          my keyword.method info $commentblock {*}[lrange $thisline 0 end-1]
          set commentblock {}
        }
        method -
        Ensemble {
          my keyword.method info $commentblock  {*}[lrange $thisline 1 end-1]
          set commentblock {}
        }
      }
      set thisline {}
    }
    dict set result class $name $info
  }

  method keyword.class_method {resultvar commentblock name args} {
    upvar 1 $resultvar result
    set info [my comment $commentblock]
    switch [llength $args] {
      1 {
        set arglist [lindex $args 0]
      }
      0 {
        set arglist dictargs
        #set body [lindex $args 0]
      }
      default {error "could not interpret method $name {*}$args"}
    }
    if {![dict exists $info arglist]} {
      dict set info arglist [my arglist $arglist]
    }
    dict set result class_method [string trim $name :] $info
  }

  method keyword.method {resultvar commentblock name args} {
    upvar 1 $resultvar result
    set info [my comment $commentblock]
    switch [llength $args] {
      1 {
        set arglist [lindex $args 0]
      }
      0 {
        set arglist dictargs
        #set body [lindex $args 0]
      }
      default {error "could not interpret method $name {*}$args"}
    }
    if {![dict exists $info arglist]} {
      dict set info arglist [my arglist $arglist]
    }
    dict set result method [string trim $name :] $info
  }

  method keyword.proc {commentblock name arglist body} {
    set info [my comment $commentblock]
    if {![dict exists $info arglist]} {
      dict set info arglist [my arglist $arglist]
    }
    return $info
  }

  method reset {} {
    my variable info
    set info [dict create]
    yield [info coroutine]
    set thisline {}
    set commentblock {}
    set linec 0
    while 1 {
      set line [yield]
      append thisline $line \n
      if {![info complete $thisline]} continue
      set thisline [string trim $thisline]
      if {[string index $thisline 0] eq "#"} {
        append commentblock [string trimleft $thisline #] \n
        set thisline {}
        continue
      }
      set cmd [string trim [lindex $thisline 0] ":"]
      switch $cmd {
        Proc -
        proc {
          set procinfo [my keyword.proc $commentblock {*}[lrange $thisline 1 end]]
          dict set info proc [string trim [lindex $thisline 1] :] $procinfo
          set commentblock {}
        }
        oo::objdefine {
          if {[llength $thisline]==3} {
            lassign $thisline tcmd name body
            my keyword.Class info $commentblock $name $body
          } else {
            puts "Warning: bare oo::define in library"
          }
        }
        oo::define {
          if {[llength $thisline]==3} {
            lassign $thisline tcmd name body
            my keyword.class info $commentblock $name $body
          } else {
            puts "Warning: bare oo::define in library"
          }
        }
        tao::define -
        clay::define -
        tool::define {
          lassign $thisline tcmd name body
          my keyword.class info $commentblock $name $body
          set commentblock {}
        }
        oo::class {
          lassign $thisline tcmd mthd name body
          my keyword.class info $commentblock $name $body
          set commentblock {}
        }
        default {
          if {[lindex [split $cmd ::] end] eq "define"} {
            lassign $thisline tcmd name body
            my keyword.class info $commentblock $name $body
            set commentblock {}
          }
          set commentblock {}
        }
      }
      set thisline {}
    }
  }

  method section.method {keyword method minfo} {
    set result {}
    set line "\[call $keyword \[cmd $method\]"
    if {[dict exists $minfo arglist]} {
      dict for {argname arginfo} [dict get $minfo arglist] {
        set positional 1
        set mandatory  1
        dict with arginfo {}
        if {$mandatory==0} {
          append line " \[opt \""
        } else {
          append line " "
        }
        if {$positional} {
          append line "\[arg $argname"
        } else {
          append line "\[option $argname"
          if {[dict exists $arginfo type]} {
            append line " \[method [dict get $arginfo type]\]"
          } else {
            append line " \[method $argname\]"
          }
        }
        append line "\]"
        if {$mandatory==0} {
          if {[dict exists $arginfo default]} {
            append line " \[const \"[dict get $arginfo default]\"\]"
          }
          append line "\"\]"
        }
      }
    }
    append line \]
    putb result $line
    if {[dict exists $minfo description]} {
      putb result [dict get $minfo description]
    }
    if {[dict exists $minfo example]} {
      putb result "\[example [list [dict get $minfo example]]\]"
    }
    return $result
  }

  method section.class {class_name class_info} {
    set result {}
    putb result "\[subsection \{Class  $class_name\}\]"
    if {[dict exists $class_info ancestors]} {
      set line "\[emph \"ancestors\"\]:"
      foreach {c} [dict get $class_info ancestors] {
        append line " \[class [string trim $c :]\]"
      }
      putb result $line
      putb result {[para]}
    }
    dict for {f v} $class_info {
      if {$f in {class_method method description ancestors example}} continue
      putb result "\[emph \"$f\"\]: $v"
      putb result {[para]}
    }
    if {[dict exists $class_info example]} {
      putb result "\[example \{[list [dict get $class_info example]]\}\]"
      putb result {[para]}
    }
    if {[dict exists $class_info description]} {
      putb result [dict get $class_info description]
      putb result {[para]}
    }
    if {[dict exists $class_info class_method]} {
      putb result "\[class \{Class Methods\}\]"
      #putb result "Methods on the class object itself."
      putb result {[list_begin definitions]}
      dict for {method minfo} [dict get $class_info class_method] {
        putb result [my section.method classmethod $method $minfo]
      }
      putb result {[list_end]}
      putb result {[para]}
    }
    if {[dict exists $class_info method]} {
      putb result "\[class {Methods}\]"
      putb result {[list_begin definitions]}
      dict for {method minfo} [dict get $class_info method] {
        putb result [my section.method method $method $minfo]
      }
      putb result {[list_end]}
      putb result {[para]}
    }
    return $result
  }

  method section.command {procinfo} {
    set result {}
    putb result "\[section \{Commands\}\]"
    putb result {[list_begin definitions]}
    dict for {method minfo} $procinfo {
      putb result [my section.method proc $method $minfo]
    }
    putb result {[list_end]}
    return $result
  }

  method manpage args {
    my variable info map
    set result {}
    set header {}
    set footer {}
    dict with args {}
    putb result $header
    dict for {sec_type sec_info} $info {
      switch $sec_type {
        proc {
          putb result [my section.command $sec_info]
        }
        class {
          putb result "\[section Classes\]"
          dict for {class_name class_info} $sec_info {
            putb result [my section.class $class_name $class_info]
          }
        }
        default {
          putb result "\[section [list $sec_type $sec_name]\]"
          if {[dict exists $sec_info description]} {
            putb result [dict get $sec_info description]
          }
        }
      }
    }
    putb result $footer
    putb result {[manpage_end]}
    return $result
  }

  method scan_text {text} {
    my variable linecount coro
    set linecount 0
    foreach line [split $text \n] {
      incr linecount
      $coro $line
    }
  }

  method scan_file {filename} {
    my variable linecount coro
    set fin [open $filename r]
    set linecount 0
    while {[gets $fin line]>=0} {
      incr linecount
      $coro $line
    }
    close $fin
  }
}


###
# END: doctool.tcl
###

namespace eval ::clay {
  namespace export *
}

