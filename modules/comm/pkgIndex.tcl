if {![package vsatisfies [package provide Tcl] 8.5 9]} {return}
package ifneeded comm 4.7.2 [list source [file join $dir comm.tcl]]
