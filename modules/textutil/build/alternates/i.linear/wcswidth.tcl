###
# This file is automatically generated by the build/build.tcl file
# based on information in the following database:
# http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt
#
# (This is the 35th edition, thus version 35 for our package)
#
# Author: Sean Woods <yoda@etoyoc.com>
###
package require Tcl 8.5
package provide textutil::wcswidth 35.2
namespace eval ::textutil {}
proc ::textutil::wcswidth_type char {
  if {$char == 161} { return A }
  if {$char == 164} { return A }
  if {$char == 167} { return A }
  if {$char == 168} { return A }
  if {$char == 170} { return A }
  if {$char == 173} { return A }
  if {$char == 174} { return A }
  if {$char == 176} { return A }
  if {$char == 177} { return A }
  if {$char >= 178 && $char <= 179 } { return A }
  if {$char == 180} { return A }
  if {$char >= 182 && $char <= 183 } { return A }
  if {$char == 184} { return A }
  if {$char == 185} { return A }
  if {$char == 186} { return A }
  if {$char >= 188 && $char <= 190 } { return A }
  if {$char == 191} { return A }
  if {$char == 198} { return A }
  if {$char == 208} { return A }
  if {$char == 215} { return A }
  if {$char == 216} { return A }
  if {$char >= 222 && $char <= 225 } { return A }
  if {$char == 230} { return A }
  if {$char >= 232 && $char <= 234 } { return A }
  if {$char >= 236 && $char <= 237 } { return A }
  if {$char == 240} { return A }
  if {$char >= 242 && $char <= 243 } { return A }
  if {$char == 247} { return A }
  if {$char >= 248 && $char <= 250 } { return A }
  if {$char == 252} { return A }
  if {$char == 254} { return A }
  if {$char == 257} { return A }
  if {$char == 273} { return A }
  if {$char == 275} { return A }
  if {$char == 283} { return A }
  if {$char >= 294 && $char <= 295 } { return A }
  if {$char == 299} { return A }
  if {$char >= 305 && $char <= 307 } { return A }
  if {$char == 312} { return A }
  if {$char >= 319 && $char <= 322 } { return A }
  if {$char == 324} { return A }
  if {$char >= 328 && $char <= 331 } { return A }
  if {$char == 333} { return A }
  if {$char >= 338 && $char <= 339 } { return A }
  if {$char >= 358 && $char <= 359 } { return A }
  if {$char == 363} { return A }
  if {$char == 462} { return A }
  if {$char == 464} { return A }
  if {$char == 466} { return A }
  if {$char == 468} { return A }
  if {$char == 470} { return A }
  if {$char == 472} { return A }
  if {$char == 474} { return A }
  if {$char == 476} { return A }
  if {$char == 593} { return A }
  if {$char == 609} { return A }
  if {$char == 708} { return A }
  if {$char == 711} { return A }
  if {$char >= 713 && $char <= 715 } { return A }
  if {$char == 717} { return A }
  if {$char == 720} { return A }
  if {$char >= 728 && $char <= 731 } { return A }
  if {$char == 733} { return A }
  if {$char == 735} { return A }
  if {$char >= 768 && $char <= 879 } { return A }
  if {$char >= 913 && $char <= 929 } { return A }
  if {$char >= 931 && $char <= 937 } { return A }
  if {$char >= 945 && $char <= 961 } { return A }
  if {$char >= 963 && $char <= 969 } { return A }
  if {$char == 1025} { return A }
  if {$char >= 1040 && $char <= 1103 } { return A }
  if {$char == 1105} { return A }
  if {$char >= 4352 && $char <= 4447 } { return W }
  if {$char == 8208} { return A }
  if {$char >= 8211 && $char <= 8213 } { return A }
  if {$char == 8214} { return A }
  if {$char == 8216} { return A }
  if {$char == 8217} { return A }
  if {$char == 8220} { return A }
  if {$char == 8221} { return A }
  if {$char >= 8224 && $char <= 8226 } { return A }
  if {$char >= 8228 && $char <= 8231 } { return A }
  if {$char == 8240} { return A }
  if {$char >= 8242 && $char <= 8243 } { return A }
  if {$char == 8245} { return A }
  if {$char == 8251} { return A }
  if {$char == 8254} { return A }
  if {$char == 8308} { return A }
  if {$char == 8319} { return A }
  if {$char >= 8321 && $char <= 8324 } { return A }
  if {$char == 8361} { return H }
  if {$char == 8364} { return A }
  if {$char == 8451} { return A }
  if {$char == 8453} { return A }
  if {$char == 8457} { return A }
  if {$char == 8467} { return A }
  if {$char == 8470} { return A }
  if {$char >= 8481 && $char <= 8482 } { return A }
  if {$char == 8486} { return A }
  if {$char == 8491} { return A }
  if {$char >= 8531 && $char <= 8532 } { return A }
  if {$char >= 8539 && $char <= 8542 } { return A }
  if {$char >= 8544 && $char <= 8555 } { return A }
  if {$char >= 8560 && $char <= 8569 } { return A }
  if {$char == 8585} { return A }
  if {$char >= 8592 && $char <= 8596 } { return A }
  if {$char >= 8597 && $char <= 8601 } { return A }
  if {$char >= 8632 && $char <= 8633 } { return A }
  if {$char == 8658} { return A }
  if {$char == 8660} { return A }
  if {$char == 8679} { return A }
  if {$char == 8704} { return A }
  if {$char >= 8706 && $char <= 8707 } { return A }
  if {$char >= 8711 && $char <= 8712 } { return A }
  if {$char == 8715} { return A }
  if {$char == 8719} { return A }
  if {$char == 8721} { return A }
  if {$char == 8725} { return A }
  if {$char == 8730} { return A }
  if {$char >= 8733 && $char <= 8736 } { return A }
  if {$char == 8739} { return A }
  if {$char == 8741} { return A }
  if {$char >= 8743 && $char <= 8748 } { return A }
  if {$char == 8750} { return A }
  if {$char >= 8756 && $char <= 8759 } { return A }
  if {$char >= 8764 && $char <= 8765 } { return A }
  if {$char == 8776} { return A }
  if {$char == 8780} { return A }
  if {$char == 8786} { return A }
  if {$char >= 8800 && $char <= 8801 } { return A }
  if {$char >= 8804 && $char <= 8807 } { return A }
  if {$char >= 8810 && $char <= 8811 } { return A }
  if {$char >= 8814 && $char <= 8815 } { return A }
  if {$char >= 8834 && $char <= 8835 } { return A }
  if {$char >= 8838 && $char <= 8839 } { return A }
  if {$char == 8853} { return A }
  if {$char == 8857} { return A }
  if {$char == 8869} { return A }
  if {$char == 8895} { return A }
  if {$char == 8978} { return A }
  if {$char >= 8986 && $char <= 8987 } { return W }
  if {$char == 9001} { return W }
  if {$char == 9002} { return W }
  if {$char >= 9193 && $char <= 9196 } { return W }
  if {$char == 9200} { return W }
  if {$char == 9203} { return W }
  if {$char >= 9312 && $char <= 9371 } { return A }
  if {$char >= 9372 && $char <= 9449 } { return A }
  if {$char >= 9451 && $char <= 9471 } { return A }
  if {$char >= 9472 && $char <= 9547 } { return A }
  if {$char >= 9552 && $char <= 9587 } { return A }
  if {$char >= 9600 && $char <= 9615 } { return A }
  if {$char >= 9618 && $char <= 9621 } { return A }
  if {$char >= 9632 && $char <= 9633 } { return A }
  if {$char >= 9635 && $char <= 9641 } { return A }
  if {$char >= 9650 && $char <= 9651 } { return A }
  if {$char == 9654} { return A }
  if {$char == 9655} { return A }
  if {$char >= 9660 && $char <= 9661 } { return A }
  if {$char == 9664} { return A }
  if {$char == 9665} { return A }
  if {$char >= 9670 && $char <= 9672 } { return A }
  if {$char == 9675} { return A }
  if {$char >= 9678 && $char <= 9681 } { return A }
  if {$char >= 9698 && $char <= 9701 } { return A }
  if {$char == 9711} { return A }
  if {$char >= 9725 && $char <= 9726 } { return W }
  if {$char >= 9733 && $char <= 9734 } { return A }
  if {$char == 9737} { return A }
  if {$char >= 9742 && $char <= 9743 } { return A }
  if {$char >= 9748 && $char <= 9749 } { return W }
  if {$char == 9756} { return A }
  if {$char == 9758} { return A }
  if {$char == 9792} { return A }
  if {$char == 9794} { return A }
  if {$char >= 9800 && $char <= 9811 } { return W }
  if {$char >= 9824 && $char <= 9825 } { return A }
  if {$char >= 9827 && $char <= 9829 } { return A }
  if {$char >= 9831 && $char <= 9834 } { return A }
  if {$char >= 9836 && $char <= 9837 } { return A }
  if {$char == 9839} { return A }
  if {$char == 9855} { return W }
  if {$char == 9875} { return W }
  if {$char >= 9886 && $char <= 9887 } { return A }
  if {$char == 9889} { return W }
  if {$char >= 9898 && $char <= 9899 } { return W }
  if {$char >= 9917 && $char <= 9918 } { return W }
  if {$char == 9919} { return A }
  if {$char >= 9924 && $char <= 9925 } { return W }
  if {$char >= 9926 && $char <= 9933 } { return A }
  if {$char == 9934} { return W }
  if {$char >= 9935 && $char <= 9939 } { return A }
  if {$char == 9940} { return W }
  if {$char >= 9941 && $char <= 9953 } { return A }
  if {$char == 9955} { return A }
  if {$char >= 9960 && $char <= 9961 } { return A }
  if {$char == 9962} { return W }
  if {$char >= 9963 && $char <= 9969 } { return A }
  if {$char >= 9970 && $char <= 9971 } { return W }
  if {$char == 9972} { return A }
  if {$char == 9973} { return W }
  if {$char >= 9974 && $char <= 9977 } { return A }
  if {$char == 9978} { return W }
  if {$char >= 9979 && $char <= 9980 } { return A }
  if {$char == 9981} { return W }
  if {$char >= 9982 && $char <= 9983 } { return A }
  if {$char == 9989} { return W }
  if {$char >= 9994 && $char <= 9995 } { return W }
  if {$char == 10024} { return W }
  if {$char == 10045} { return A }
  if {$char == 10060} { return W }
  if {$char == 10062} { return W }
  if {$char >= 10067 && $char <= 10069 } { return W }
  if {$char == 10071} { return W }
  if {$char >= 10102 && $char <= 10111 } { return A }
  if {$char >= 10133 && $char <= 10135 } { return W }
  if {$char == 10160} { return W }
  if {$char == 10175} { return W }
  if {$char >= 11035 && $char <= 11036 } { return W }
  if {$char == 11088} { return W }
  if {$char == 11093} { return W }
  if {$char >= 11094 && $char <= 11097 } { return A }
  if {$char >= 11904 && $char <= 11929 } { return W }
  if {$char >= 11931 && $char <= 12019 } { return W }
  if {$char >= 12032 && $char <= 12245 } { return W }
  if {$char >= 12272 && $char <= 12283 } { return W }
  if {$char == 12288} { return F }
  if {$char >= 12289 && $char <= 12291 } { return W }
  if {$char == 12292} { return W }
  if {$char == 12293} { return W }
  if {$char == 12294} { return W }
  if {$char == 12295} { return W }
  if {$char == 12296} { return W }
  if {$char == 12297} { return W }
  if {$char == 12298} { return W }
  if {$char == 12299} { return W }
  if {$char == 12300} { return W }
  if {$char == 12301} { return W }
  if {$char == 12302} { return W }
  if {$char == 12303} { return W }
  if {$char == 12304} { return W }
  if {$char == 12305} { return W }
  if {$char >= 12306 && $char <= 12307 } { return W }
  if {$char == 12308} { return W }
  if {$char == 12309} { return W }
  if {$char == 12310} { return W }
  if {$char == 12311} { return W }
  if {$char == 12312} { return W }
  if {$char == 12313} { return W }
  if {$char == 12314} { return W }
  if {$char == 12315} { return W }
  if {$char == 12316} { return W }
  if {$char == 12317} { return W }
  if {$char >= 12318 && $char <= 12319 } { return W }
  if {$char == 12320} { return W }
  if {$char >= 12321 && $char <= 12329 } { return W }
  if {$char >= 12330 && $char <= 12333 } { return W }
  if {$char >= 12334 && $char <= 12335 } { return W }
  if {$char == 12336} { return W }
  if {$char >= 12337 && $char <= 12341 } { return W }
  if {$char >= 12342 && $char <= 12343 } { return W }
  if {$char >= 12344 && $char <= 12346 } { return W }
  if {$char == 12347} { return W }
  if {$char == 12348} { return W }
  if {$char == 12349} { return W }
  if {$char == 12350} { return W }
  if {$char >= 12353 && $char <= 12438 } { return W }
  if {$char >= 12441 && $char <= 12442 } { return W }
  if {$char >= 12443 && $char <= 12444 } { return W }
  if {$char >= 12445 && $char <= 12446 } { return W }
  if {$char == 12447} { return W }
  if {$char == 12448} { return W }
  if {$char >= 12449 && $char <= 12538 } { return W }
  if {$char == 12539} { return W }
  if {$char >= 12540 && $char <= 12542 } { return W }
  if {$char == 12543} { return W }
  if {$char >= 12549 && $char <= 12591 } { return W }
  if {$char >= 12593 && $char <= 12686 } { return W }
  if {$char >= 12688 && $char <= 12689 } { return W }
  if {$char >= 12690 && $char <= 12693 } { return W }
  if {$char >= 12694 && $char <= 12703 } { return W }
  if {$char >= 12704 && $char <= 12735 } { return W }
  if {$char >= 12736 && $char <= 12771 } { return W }
  if {$char >= 12784 && $char <= 12799 } { return W }
  if {$char >= 12800 && $char <= 12830 } { return W }
  if {$char >= 12832 && $char <= 12841 } { return W }
  if {$char >= 12842 && $char <= 12871 } { return W }
  if {$char >= 12872 && $char <= 12879 } { return A }
  if {$char == 12880} { return W }
  if {$char >= 12881 && $char <= 12895 } { return W }
  if {$char >= 12896 && $char <= 12927 } { return W }
  if {$char >= 12928 && $char <= 12937 } { return W }
  if {$char >= 12938 && $char <= 12976 } { return W }
  if {$char >= 12977 && $char <= 12991 } { return W }
  if {$char >= 12992 && $char <= 13055 } { return W }
  if {$char >= 13056 && $char <= 13311 } { return W }
  if {$char >= 13312 && $char <= 19903 } { return W }
  if {$char >= 19968 && $char <= 40959 } { return W }
  if {$char >= 40960 && $char <= 40980 } { return W }
  if {$char == 40981} { return W }
  if {$char >= 40982 && $char <= 42124 } { return W }
  if {$char >= 42128 && $char <= 42182 } { return W }
  if {$char >= 43360 && $char <= 43388 } { return W }
  if {$char >= 44032 && $char <= 55203 } { return W }
  if {$char >= 57344 && $char <= 63743 } { return A }
  if {$char >= 63744 && $char <= 64109 } { return W }
  if {$char >= 64110 && $char <= 64111 } { return W }
  if {$char >= 64112 && $char <= 64217 } { return W }
  if {$char >= 64218 && $char <= 64255 } { return W }
  if {$char >= 65024 && $char <= 65039 } { return A }
  if {$char >= 65040 && $char <= 65046 } { return W }
  if {$char == 65047} { return W }
  if {$char == 65048} { return W }
  if {$char == 65049} { return W }
  if {$char == 65072} { return W }
  if {$char >= 65073 && $char <= 65074 } { return W }
  if {$char >= 65075 && $char <= 65076 } { return W }
  if {$char == 65077} { return W }
  if {$char == 65078} { return W }
  if {$char == 65079} { return W }
  if {$char == 65080} { return W }
  if {$char == 65081} { return W }
  if {$char == 65082} { return W }
  if {$char == 65083} { return W }
  if {$char == 65084} { return W }
  if {$char == 65085} { return W }
  if {$char == 65086} { return W }
  if {$char == 65087} { return W }
  if {$char == 65088} { return W }
  if {$char == 65089} { return W }
  if {$char == 65090} { return W }
  if {$char == 65091} { return W }
  if {$char == 65092} { return W }
  if {$char >= 65093 && $char <= 65094 } { return W }
  if {$char == 65095} { return W }
  if {$char == 65096} { return W }
  if {$char >= 65097 && $char <= 65100 } { return W }
  if {$char >= 65101 && $char <= 65103 } { return W }
  if {$char >= 65104 && $char <= 65106 } { return W }
  if {$char >= 65108 && $char <= 65111 } { return W }
  if {$char == 65112} { return W }
  if {$char == 65113} { return W }
  if {$char == 65114} { return W }
  if {$char == 65115} { return W }
  if {$char == 65116} { return W }
  if {$char == 65117} { return W }
  if {$char == 65118} { return W }
  if {$char >= 65119 && $char <= 65121 } { return W }
  if {$char == 65122} { return W }
  if {$char == 65123} { return W }
  if {$char >= 65124 && $char <= 65126 } { return W }
  if {$char == 65128} { return W }
  if {$char == 65129} { return W }
  if {$char >= 65130 && $char <= 65131 } { return W }
  if {$char >= 65281 && $char <= 65283 } { return F }
  if {$char == 65284} { return F }
  if {$char >= 65285 && $char <= 65287 } { return F }
  if {$char == 65288} { return F }
  if {$char == 65289} { return F }
  if {$char == 65290} { return F }
  if {$char == 65291} { return F }
  if {$char == 65292} { return F }
  if {$char == 65293} { return F }
  if {$char >= 65294 && $char <= 65295 } { return F }
  if {$char >= 65296 && $char <= 65305 } { return F }
  if {$char >= 65306 && $char <= 65307 } { return F }
  if {$char >= 65308 && $char <= 65310 } { return F }
  if {$char >= 65311 && $char <= 65312 } { return F }
  if {$char >= 65313 && $char <= 65338 } { return F }
  if {$char == 65339} { return F }
  if {$char == 65340} { return F }
  if {$char == 65341} { return F }
  if {$char == 65342} { return F }
  if {$char == 65343} { return F }
  if {$char == 65344} { return F }
  if {$char >= 65345 && $char <= 65370 } { return F }
  if {$char == 65371} { return F }
  if {$char == 65372} { return F }
  if {$char == 65373} { return F }
  if {$char == 65374} { return F }
  if {$char == 65375} { return F }
  if {$char == 65376} { return F }
  if {$char == 65377} { return H }
  if {$char == 65378} { return H }
  if {$char == 65379} { return H }
  if {$char >= 65380 && $char <= 65381 } { return H }
  if {$char >= 65382 && $char <= 65391 } { return H }
  if {$char == 65392} { return H }
  if {$char >= 65393 && $char <= 65437 } { return H }
  if {$char >= 65438 && $char <= 65439 } { return H }
  if {$char >= 65440 && $char <= 65470 } { return H }
  if {$char >= 65474 && $char <= 65479 } { return H }
  if {$char >= 65482 && $char <= 65487 } { return H }
  if {$char >= 65490 && $char <= 65495 } { return H }
  if {$char >= 65498 && $char <= 65500 } { return H }
  if {$char >= 65504 && $char <= 65505 } { return F }
  if {$char == 65506} { return F }
  if {$char == 65507} { return F }
  if {$char == 65508} { return F }
  if {$char >= 65509 && $char <= 65510 } { return F }
  if {$char == 65512} { return H }
  if {$char >= 65513 && $char <= 65516 } { return H }
  if {$char >= 65517 && $char <= 65518 } { return H }
  if {$char == 65533} { return A }
  if {$char >= 94176 && $char <= 94177 } { return W }
  if {$char == 94178} { return W }
  if {$char == 94179} { return W }
  if {$char == 94180} { return W }
  if {$char >= 94192 && $char <= 94193 } { return W }
  if {$char >= 94208 && $char <= 100343 } { return W }
  if {$char >= 100352 && $char <= 101119 } { return W }
  if {$char >= 101120 && $char <= 101589 } { return W }
  if {$char >= 101632 && $char <= 101640 } { return W }
  if {$char >= 110576 && $char <= 110579 } { return W }
  if {$char >= 110581 && $char <= 110587 } { return W }
  if {$char >= 110589 && $char <= 110590 } { return W }
  if {$char >= 110592 && $char <= 110847 } { return W }
  if {$char >= 110848 && $char <= 110882 } { return W }
  if {$char >= 110928 && $char <= 110930 } { return W }
  if {$char >= 110948 && $char <= 110951 } { return W }
  if {$char >= 110960 && $char <= 111355 } { return W }
  if {$char == 126980} { return W }
  if {$char == 127183} { return W }
  if {$char >= 127232 && $char <= 127242 } { return A }
  if {$char >= 127248 && $char <= 127277 } { return A }
  if {$char >= 127280 && $char <= 127337 } { return A }
  if {$char >= 127344 && $char <= 127373 } { return A }
  if {$char == 127374} { return W }
  if {$char >= 127375 && $char <= 127376 } { return A }
  if {$char >= 127377 && $char <= 127386 } { return W }
  if {$char >= 127387 && $char <= 127404 } { return A }
  if {$char >= 127488 && $char <= 127490 } { return W }
  if {$char >= 127504 && $char <= 127547 } { return W }
  if {$char >= 127552 && $char <= 127560 } { return W }
  if {$char >= 127568 && $char <= 127569 } { return W }
  if {$char >= 127584 && $char <= 127589 } { return W }
  if {$char >= 127744 && $char <= 127776 } { return W }
  if {$char >= 127789 && $char <= 127797 } { return W }
  if {$char >= 127799 && $char <= 127868 } { return W }
  if {$char >= 127870 && $char <= 127891 } { return W }
  if {$char >= 127904 && $char <= 127946 } { return W }
  if {$char >= 127951 && $char <= 127955 } { return W }
  if {$char >= 127968 && $char <= 127984 } { return W }
  if {$char == 127988} { return W }
  if {$char >= 127992 && $char <= 127994 } { return W }
  if {$char >= 127995 && $char <= 127999 } { return W }
  if {$char >= 128000 && $char <= 128062 } { return W }
  if {$char == 128064} { return W }
  if {$char >= 128066 && $char <= 128252 } { return W }
  if {$char >= 128255 && $char <= 128317 } { return W }
  if {$char >= 128331 && $char <= 128334 } { return W }
  if {$char >= 128336 && $char <= 128359 } { return W }
  if {$char == 128378} { return W }
  if {$char >= 128405 && $char <= 128406 } { return W }
  if {$char == 128420} { return W }
  if {$char >= 128507 && $char <= 128511 } { return W }
  if {$char >= 128512 && $char <= 128591 } { return W }
  if {$char >= 128640 && $char <= 128709 } { return W }
  if {$char == 128716} { return W }
  if {$char >= 128720 && $char <= 128722 } { return W }
  if {$char >= 128725 && $char <= 128727 } { return W }
  if {$char >= 128733 && $char <= 128735 } { return W }
  if {$char >= 128747 && $char <= 128748 } { return W }
  if {$char >= 128756 && $char <= 128764 } { return W }
  if {$char >= 128992 && $char <= 129003 } { return W }
  if {$char == 129008} { return W }
  if {$char >= 129292 && $char <= 129338 } { return W }
  if {$char >= 129340 && $char <= 129349 } { return W }
  if {$char >= 129351 && $char <= 129535 } { return W }
  if {$char >= 129648 && $char <= 129652 } { return W }
  if {$char >= 129656 && $char <= 129660 } { return W }
  if {$char >= 129664 && $char <= 129670 } { return W }
  if {$char >= 129680 && $char <= 129708 } { return W }
  if {$char >= 129712 && $char <= 129722 } { return W }
  if {$char >= 129728 && $char <= 129733 } { return W }
  if {$char >= 129744 && $char <= 129753 } { return W }
  if {$char >= 129760 && $char <= 129767 } { return W }
  if {$char >= 129776 && $char <= 129782 } { return W }
  if {$char >= 131072 && $char <= 173791 } { return W }
  if {$char >= 173792 && $char <= 173823 } { return W }
  if {$char >= 173824 && $char <= 177976 } { return W }
  if {$char >= 177977 && $char <= 177983 } { return W }
  if {$char >= 177984 && $char <= 178205 } { return W }
  if {$char >= 178206 && $char <= 178207 } { return W }
  if {$char >= 178208 && $char <= 183969 } { return W }
  if {$char >= 183970 && $char <= 183983 } { return W }
  if {$char >= 183984 && $char <= 191456 } { return W }
  if {$char >= 191457 && $char <= 194559 } { return W }
  if {$char >= 194560 && $char <= 195101 } { return W }
  if {$char >= 195102 && $char <= 195103 } { return W }
  if {$char >= 195104 && $char <= 196605 } { return W }
  if {$char >= 196608 && $char <= 201546 } { return W }
  if {$char >= 201547 && $char <= 262141 } { return W }
  if {$char >= 917760 && $char <= 917999 } { return A }
  if {$char >= 983040 && $char <= 1048573 } { return A }
  if {$char >= 1048576 && $char <= 1114109 } { return A }
  return N
}
proc ::textutil::wcswidth_char char {
  if {$char >= 4352 && $char <= 4447 } { return 2 }
  if {$char >= 8986 && $char <= 8987 } { return 2 }
  if {$char == 9001} { return 2 }
  if {$char == 9002} { return 2 }
  if {$char >= 9193 && $char <= 9196 } { return 2 }
  if {$char == 9200} { return 2 }
  if {$char == 9203} { return 2 }
  if {$char >= 9725 && $char <= 9726 } { return 2 }
  if {$char >= 9748 && $char <= 9749 } { return 2 }
  if {$char >= 9800 && $char <= 9811 } { return 2 }
  if {$char == 9855} { return 2 }
  if {$char == 9875} { return 2 }
  if {$char == 9889} { return 2 }
  if {$char >= 9898 && $char <= 9899 } { return 2 }
  if {$char >= 9917 && $char <= 9918 } { return 2 }
  if {$char >= 9924 && $char <= 9925 } { return 2 }
  if {$char == 9934} { return 2 }
  if {$char == 9940} { return 2 }
  if {$char == 9962} { return 2 }
  if {$char >= 9970 && $char <= 9971 } { return 2 }
  if {$char == 9973} { return 2 }
  if {$char == 9978} { return 2 }
  if {$char == 9981} { return 2 }
  if {$char == 9989} { return 2 }
  if {$char >= 9994 && $char <= 9995 } { return 2 }
  if {$char == 10024} { return 2 }
  if {$char == 10060} { return 2 }
  if {$char == 10062} { return 2 }
  if {$char >= 10067 && $char <= 10069 } { return 2 }
  if {$char == 10071} { return 2 }
  if {$char >= 10133 && $char <= 10135 } { return 2 }
  if {$char == 10160} { return 2 }
  if {$char == 10175} { return 2 }
  if {$char >= 11035 && $char <= 11036 } { return 2 }
  if {$char == 11088} { return 2 }
  if {$char == 11093} { return 2 }
  if {$char >= 11904 && $char <= 11929 } { return 2 }
  if {$char >= 11931 && $char <= 12019 } { return 2 }
  if {$char >= 12032 && $char <= 12245 } { return 2 }
  if {$char >= 12272 && $char <= 12283 } { return 2 }
  if {$char == 12288} { return 2 }
  if {$char >= 12289 && $char <= 12291 } { return 2 }
  if {$char == 12292} { return 2 }
  if {$char == 12293} { return 2 }
  if {$char == 12294} { return 2 }
  if {$char == 12295} { return 2 }
  if {$char == 12296} { return 2 }
  if {$char == 12297} { return 2 }
  if {$char == 12298} { return 2 }
  if {$char == 12299} { return 2 }
  if {$char == 12300} { return 2 }
  if {$char == 12301} { return 2 }
  if {$char == 12302} { return 2 }
  if {$char == 12303} { return 2 }
  if {$char == 12304} { return 2 }
  if {$char == 12305} { return 2 }
  if {$char >= 12306 && $char <= 12307 } { return 2 }
  if {$char == 12308} { return 2 }
  if {$char == 12309} { return 2 }
  if {$char == 12310} { return 2 }
  if {$char == 12311} { return 2 }
  if {$char == 12312} { return 2 }
  if {$char == 12313} { return 2 }
  if {$char == 12314} { return 2 }
  if {$char == 12315} { return 2 }
  if {$char == 12316} { return 2 }
  if {$char == 12317} { return 2 }
  if {$char >= 12318 && $char <= 12319 } { return 2 }
  if {$char == 12320} { return 2 }
  if {$char >= 12321 && $char <= 12329 } { return 2 }
  if {$char >= 12330 && $char <= 12333 } { return 2 }
  if {$char >= 12334 && $char <= 12335 } { return 2 }
  if {$char == 12336} { return 2 }
  if {$char >= 12337 && $char <= 12341 } { return 2 }
  if {$char >= 12342 && $char <= 12343 } { return 2 }
  if {$char >= 12344 && $char <= 12346 } { return 2 }
  if {$char == 12347} { return 2 }
  if {$char == 12348} { return 2 }
  if {$char == 12349} { return 2 }
  if {$char == 12350} { return 2 }
  if {$char >= 12353 && $char <= 12438 } { return 2 }
  if {$char >= 12441 && $char <= 12442 } { return 2 }
  if {$char >= 12443 && $char <= 12444 } { return 2 }
  if {$char >= 12445 && $char <= 12446 } { return 2 }
  if {$char == 12447} { return 2 }
  if {$char == 12448} { return 2 }
  if {$char >= 12449 && $char <= 12538 } { return 2 }
  if {$char == 12539} { return 2 }
  if {$char >= 12540 && $char <= 12542 } { return 2 }
  if {$char == 12543} { return 2 }
  if {$char >= 12549 && $char <= 12591 } { return 2 }
  if {$char >= 12593 && $char <= 12686 } { return 2 }
  if {$char >= 12688 && $char <= 12689 } { return 2 }
  if {$char >= 12690 && $char <= 12693 } { return 2 }
  if {$char >= 12694 && $char <= 12703 } { return 2 }
  if {$char >= 12704 && $char <= 12735 } { return 2 }
  if {$char >= 12736 && $char <= 12771 } { return 2 }
  if {$char >= 12784 && $char <= 12799 } { return 2 }
  if {$char >= 12800 && $char <= 12830 } { return 2 }
  if {$char >= 12832 && $char <= 12841 } { return 2 }
  if {$char >= 12842 && $char <= 12871 } { return 2 }
  if {$char == 12880} { return 2 }
  if {$char >= 12881 && $char <= 12895 } { return 2 }
  if {$char >= 12896 && $char <= 12927 } { return 2 }
  if {$char >= 12928 && $char <= 12937 } { return 2 }
  if {$char >= 12938 && $char <= 12976 } { return 2 }
  if {$char >= 12977 && $char <= 12991 } { return 2 }
  if {$char >= 12992 && $char <= 13055 } { return 2 }
  if {$char >= 13056 && $char <= 13311 } { return 2 }
  if {$char >= 13312 && $char <= 19903 } { return 2 }
  if {$char >= 19968 && $char <= 40959 } { return 2 }
  if {$char >= 40960 && $char <= 40980 } { return 2 }
  if {$char == 40981} { return 2 }
  if {$char >= 40982 && $char <= 42124 } { return 2 }
  if {$char >= 42128 && $char <= 42182 } { return 2 }
  if {$char >= 43360 && $char <= 43388 } { return 2 }
  if {$char >= 44032 && $char <= 55203 } { return 2 }
  if {$char >= 63744 && $char <= 64109 } { return 2 }
  if {$char >= 64110 && $char <= 64111 } { return 2 }
  if {$char >= 64112 && $char <= 64217 } { return 2 }
  if {$char >= 64218 && $char <= 64255 } { return 2 }
  if {$char >= 65040 && $char <= 65046 } { return 2 }
  if {$char == 65047} { return 2 }
  if {$char == 65048} { return 2 }
  if {$char == 65049} { return 2 }
  if {$char == 65072} { return 2 }
  if {$char >= 65073 && $char <= 65074 } { return 2 }
  if {$char >= 65075 && $char <= 65076 } { return 2 }
  if {$char == 65077} { return 2 }
  if {$char == 65078} { return 2 }
  if {$char == 65079} { return 2 }
  if {$char == 65080} { return 2 }
  if {$char == 65081} { return 2 }
  if {$char == 65082} { return 2 }
  if {$char == 65083} { return 2 }
  if {$char == 65084} { return 2 }
  if {$char == 65085} { return 2 }
  if {$char == 65086} { return 2 }
  if {$char == 65087} { return 2 }
  if {$char == 65088} { return 2 }
  if {$char == 65089} { return 2 }
  if {$char == 65090} { return 2 }
  if {$char == 65091} { return 2 }
  if {$char == 65092} { return 2 }
  if {$char >= 65093 && $char <= 65094 } { return 2 }
  if {$char == 65095} { return 2 }
  if {$char == 65096} { return 2 }
  if {$char >= 65097 && $char <= 65100 } { return 2 }
  if {$char >= 65101 && $char <= 65103 } { return 2 }
  if {$char >= 65104 && $char <= 65106 } { return 2 }
  if {$char >= 65108 && $char <= 65111 } { return 2 }
  if {$char == 65112} { return 2 }
  if {$char == 65113} { return 2 }
  if {$char == 65114} { return 2 }
  if {$char == 65115} { return 2 }
  if {$char == 65116} { return 2 }
  if {$char == 65117} { return 2 }
  if {$char == 65118} { return 2 }
  if {$char >= 65119 && $char <= 65121 } { return 2 }
  if {$char == 65122} { return 2 }
  if {$char == 65123} { return 2 }
  if {$char >= 65124 && $char <= 65126 } { return 2 }
  if {$char == 65128} { return 2 }
  if {$char == 65129} { return 2 }
  if {$char >= 65130 && $char <= 65131 } { return 2 }
  if {$char >= 65281 && $char <= 65283 } { return 2 }
  if {$char == 65284} { return 2 }
  if {$char >= 65285 && $char <= 65287 } { return 2 }
  if {$char == 65288} { return 2 }
  if {$char == 65289} { return 2 }
  if {$char == 65290} { return 2 }
  if {$char == 65291} { return 2 }
  if {$char == 65292} { return 2 }
  if {$char == 65293} { return 2 }
  if {$char >= 65294 && $char <= 65295 } { return 2 }
  if {$char >= 65296 && $char <= 65305 } { return 2 }
  if {$char >= 65306 && $char <= 65307 } { return 2 }
  if {$char >= 65308 && $char <= 65310 } { return 2 }
  if {$char >= 65311 && $char <= 65312 } { return 2 }
  if {$char >= 65313 && $char <= 65338 } { return 2 }
  if {$char == 65339} { return 2 }
  if {$char == 65340} { return 2 }
  if {$char == 65341} { return 2 }
  if {$char == 65342} { return 2 }
  if {$char == 65343} { return 2 }
  if {$char == 65344} { return 2 }
  if {$char >= 65345 && $char <= 65370 } { return 2 }
  if {$char == 65371} { return 2 }
  if {$char == 65372} { return 2 }
  if {$char == 65373} { return 2 }
  if {$char == 65374} { return 2 }
  if {$char == 65375} { return 2 }
  if {$char == 65376} { return 2 }
  if {$char >= 65504 && $char <= 65505 } { return 2 }
  if {$char == 65506} { return 2 }
  if {$char == 65507} { return 2 }
  if {$char == 65508} { return 2 }
  if {$char >= 65509 && $char <= 65510 } { return 2 }
  if {$char >= 94176 && $char <= 94177 } { return 2 }
  if {$char == 94178} { return 2 }
  if {$char == 94179} { return 2 }
  if {$char == 94180} { return 2 }
  if {$char >= 94192 && $char <= 94193 } { return 2 }
  if {$char >= 94208 && $char <= 100343 } { return 2 }
  if {$char >= 100352 && $char <= 101119 } { return 2 }
  if {$char >= 101120 && $char <= 101589 } { return 2 }
  if {$char >= 101632 && $char <= 101640 } { return 2 }
  if {$char >= 110576 && $char <= 110579 } { return 2 }
  if {$char >= 110581 && $char <= 110587 } { return 2 }
  if {$char >= 110589 && $char <= 110590 } { return 2 }
  if {$char >= 110592 && $char <= 110847 } { return 2 }
  if {$char >= 110848 && $char <= 110882 } { return 2 }
  if {$char >= 110928 && $char <= 110930 } { return 2 }
  if {$char >= 110948 && $char <= 110951 } { return 2 }
  if {$char >= 110960 && $char <= 111355 } { return 2 }
  if {$char == 126980} { return 2 }
  if {$char == 127183} { return 2 }
  if {$char == 127374} { return 2 }
  if {$char >= 127377 && $char <= 127386 } { return 2 }
  if {$char >= 127488 && $char <= 127490 } { return 2 }
  if {$char >= 127504 && $char <= 127547 } { return 2 }
  if {$char >= 127552 && $char <= 127560 } { return 2 }
  if {$char >= 127568 && $char <= 127569 } { return 2 }
  if {$char >= 127584 && $char <= 127589 } { return 2 }
  if {$char >= 127744 && $char <= 127776 } { return 2 }
  if {$char >= 127789 && $char <= 127797 } { return 2 }
  if {$char >= 127799 && $char <= 127868 } { return 2 }
  if {$char >= 127870 && $char <= 127891 } { return 2 }
  if {$char >= 127904 && $char <= 127946 } { return 2 }
  if {$char >= 127951 && $char <= 127955 } { return 2 }
  if {$char >= 127968 && $char <= 127984 } { return 2 }
  if {$char == 127988} { return 2 }
  if {$char >= 127992 && $char <= 127994 } { return 2 }
  if {$char >= 127995 && $char <= 127999 } { return 2 }
  if {$char >= 128000 && $char <= 128062 } { return 2 }
  if {$char == 128064} { return 2 }
  if {$char >= 128066 && $char <= 128252 } { return 2 }
  if {$char >= 128255 && $char <= 128317 } { return 2 }
  if {$char >= 128331 && $char <= 128334 } { return 2 }
  if {$char >= 128336 && $char <= 128359 } { return 2 }
  if {$char == 128378} { return 2 }
  if {$char >= 128405 && $char <= 128406 } { return 2 }
  if {$char == 128420} { return 2 }
  if {$char >= 128507 && $char <= 128511 } { return 2 }
  if {$char >= 128512 && $char <= 128591 } { return 2 }
  if {$char >= 128640 && $char <= 128709 } { return 2 }
  if {$char == 128716} { return 2 }
  if {$char >= 128720 && $char <= 128722 } { return 2 }
  if {$char >= 128725 && $char <= 128727 } { return 2 }
  if {$char >= 128733 && $char <= 128735 } { return 2 }
  if {$char >= 128747 && $char <= 128748 } { return 2 }
  if {$char >= 128756 && $char <= 128764 } { return 2 }
  if {$char >= 128992 && $char <= 129003 } { return 2 }
  if {$char == 129008} { return 2 }
  if {$char >= 129292 && $char <= 129338 } { return 2 }
  if {$char >= 129340 && $char <= 129349 } { return 2 }
  if {$char >= 129351 && $char <= 129535 } { return 2 }
  if {$char >= 129648 && $char <= 129652 } { return 2 }
  if {$char >= 129656 && $char <= 129660 } { return 2 }
  if {$char >= 129664 && $char <= 129670 } { return 2 }
  if {$char >= 129680 && $char <= 129708 } { return 2 }
  if {$char >= 129712 && $char <= 129722 } { return 2 }
  if {$char >= 129728 && $char <= 129733 } { return 2 }
  if {$char >= 129744 && $char <= 129753 } { return 2 }
  if {$char >= 129760 && $char <= 129767 } { return 2 }
  if {$char >= 129776 && $char <= 129782 } { return 2 }
  if {$char >= 131072 && $char <= 173791 } { return 2 }
  if {$char >= 173792 && $char <= 173823 } { return 2 }
  if {$char >= 173824 && $char <= 177976 } { return 2 }
  if {$char >= 177977 && $char <= 177983 } { return 2 }
  if {$char >= 177984 && $char <= 178205 } { return 2 }
  if {$char >= 178206 && $char <= 178207 } { return 2 }
  if {$char >= 178208 && $char <= 183969 } { return 2 }
  if {$char >= 183970 && $char <= 183983 } { return 2 }
  if {$char >= 183984 && $char <= 191456 } { return 2 }
  if {$char >= 191457 && $char <= 194559 } { return 2 }
  if {$char >= 194560 && $char <= 195101 } { return 2 }
  if {$char >= 195102 && $char <= 195103 } { return 2 }
  if {$char >= 195104 && $char <= 196605 } { return 2 }
  if {$char >= 196608 && $char <= 201546 } { return 2 }
  if {$char >= 201547 && $char <= 262141 } { return 2 }
  return 1
}

proc ::textutil::wcswidth {string} {
  set width 0
  set len [string length $string]
  foreach c [split $string {}] {
    scan $c %c char
    set n [::textutil::wcswidth_char $char]
    if {$n < 0} {
      return -1
    }
    incr width $n
  }
  return $width
}

