if {![package vsatisfies [package provide Tcl] 8.5 9]} {return}
package ifneeded pop3 1.10 [list source [file join $dir pop3.tcl]]
