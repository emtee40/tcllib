if { ! [package vsatisfies [package provide Tcl] 8.5 9] } {return}
package ifneeded calendar 0.2 [list source [file join $dir calendar.tcl]]
