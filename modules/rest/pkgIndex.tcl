if {![package vsatisfies [package provide Tcl] 8.5 9]} {return}
package ifneeded rest 1.6 [list source [file join $dir rest.tcl]]
