if {![package vsatisfies [package provide Tcl] 8.5 9]} {return}
# Backward compatible alias
package ifneeded nameserv::cluster 0.2.6  {package require udpcluster ; package provide nameserv::cluster 0.2.6}
package ifneeded udpcluster        0.3.4  [list source [file join $dir udpcluster.tcl]]
