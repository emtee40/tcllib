if {![package vsatisfies [package provide Tcl] 8.5 9]} {return}
package ifneeded jpeg 0.5 [list source [file join $dir jpeg.tcl]]
