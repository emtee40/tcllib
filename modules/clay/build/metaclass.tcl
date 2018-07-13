#-------------------------------------------------------------------------
# TITLE:
#    clay.tcl
#
# PROJECT:
#    clay: TclOO Helper Library
#
# DESCRIPTION:
#    clay(n): Implementation File
#
#-------------------------------------------------------------------------

namespace eval ::clay {}
namespace eval ::clay::define {}

::oo::dialect::create ::clay


proc ::clay::dynamic_methods class {
  foreach command [info commands [namespace current]::dynamic_methods_*] {
    $command $class
  }
}

proc ::clay::dynamic_methods_class {thisclass} {
  set methods {}
  foreach aclass [::clay::ancestors $thisclass] {
    set mdata  [$aclass clay get class_typemethod/]
    foreach {method info} $mdata {
      set method [string trimright $method :/-]
      if {$method in $methods} continue
      lappend methods $method
      set arglist [dict getnull $info arglist]
      set body    [dict getnull $info body]
      ::oo::objdefine $thisclass method $method $arglist $body
    }
  }
}

###
# New OO Keywords for clay
###
proc ::clay::define::Array {name {values {}}} {
  set class [current_class]
  set name [string trim $name :/]/
  if {![$class clay exists array/ $name]} {
    $class clay set public/ array/ $name {}
  }
  foreach {var val} $values {
    $class clay set public/ array/ $name $var $val
  }
}

###
# topic: 710a93168e4ba7a971d3dbb8a3e7bcbc
###
proc ::clay::define::component {name info} {
  set class [current_class]
  foreach {field value} $info {
    $class clay set component/ [string trim $name :/]/ $field $value
  }
}

###
# topic: 2cfc44a49f067124fda228458f77f177
# title: Specify the constructor for a class
###
proc ::clay::define::constructor {arglist rawbody} {
  set body {
my variable DestroyEvent
set DestroyEvent 0
::clay::object_create [self] [info object class [self]]
# Initialize public variables and options
my Ensembles_Rebuild
  }
  append body $rawbody
  set class [current_class]
  ::oo::define $class constructor $arglist $body
}

###
# topic: 7a5c7e04989704eef117ff3c9dd88823
# title: Specify the a method for the class object itself, instead of for objects of the class
###
proc ::clay::define::class_method {name arglist body} {
  set class [current_class]
  $class clay set class_typemethod/ [string trim $name :/] [dict create arglist $arglist body $body]
}

proc ::clay::define::clay {args} {
  set class [current_class]
  if {[lindex $args 0] in "cget set branchset"} {
    $class clay {*}$args
  } else {
    $class clay set {*}$args
  }
}

###
# topic: 4cb3696bf06d1e372107795de7fe1545
# title: Specify the destructor for a class
###
proc ::clay::define::destructor rawbody {
  set body {
# Run the destructor once and only once
set self [self]
my variable DestroyEvent
if {$DestroyEvent} return
set DestroyEvent 1
::clay::object_destroy $self
}
  append body $rawbody
  ::oo::define [current_class] destructor $body
}

proc ::clay::define::Dict {name {values {}}} {
  set class [current_class]
  set name [string trim $name :/]/
  if {![$class clay exists dict/ $name]} {
    $class clay set public/ dict/ $name {}
  }
  foreach {var val} $values {
    $class clay set public/ dict/ $name $var $val
  }
}

###
# topic: 615b7c43b863b0d8d1f9107a8d126b21
# title: Specify a variable which should be initialized in the constructor
# description:
#    This keyword can also be expressed:
#    [example {property variable NAME {default DEFAULT}}]
#    [para]
#    Variables registered in the variable property are also initialized
#    (if missing) when the object changes class via the [emph morph] method.
###
proc ::clay::define::Variable {name {default {}}} {
  set class [current_class]
  set name [string trimright $name :/]
  $class clay set public/ variable/ $name $default
  #::oo::define $class variable $name
}

proc ::clay::object_create {objname {class {}}} {
  if {$::clay::trace>0} {
    puts [list $objname CREATE]
  }
}

proc ::clay::object_rename {object newname} {
  if {$::clay::trace>0} {
    puts [list $object RENAME -> $newname]
  }
}

proc ::clay::object_destroy objname {
  if {$::clay::trace>0} {
    puts [list $objname DESTROY]
  }
  ::cron::object_destroy $objname
}


# clay::object
#
# This class is inherited by all classes that have options.
#
::clay::define ::clay::object {
  Variable organs {}
  Variable clay {}
  Variable mixinmap {}
  Variable claycache {}
  Variable DestroyEvent 0

  method Evolve {} {
    my Ensembles_Rebuild
  }

  method Ensembles_Rebuild {} {
    my variable clayorder clay claycache
    set claycache {}
    set clayorder [::clay::ancestors [info object class [self]] {*}[info object mixins [self]]]
    if {[info exists clay]} {
      set emap [dict getnull $clay method_ensemble/]
    } else {
      set emap {}
    }
    if {$::clay::trace>2} {
      puts "Rebuilding Ensembles"
    }
    foreach class $clayorder {
      foreach {var value} [$class clay get public/ variable/] {
        set var [string trim $var :/]
        if { $var in {clay} } continue
        my variable $var
        if {![info exists $var]} {
          if {$::clay::trace>2} {puts [list initialize variable $var $value]}
          set $var $value
        }
      }
      foreach {var value} [$class clay get public/ dict/] {
        set var [string trim $var :/]
        my variable $var
        if {![info exists $var]} { set $var {} }
        foreach {f v} $value {
          if {![dict exists ${var} $f]} {
            if {$::clay::trace>2} {puts [list initialize dict $var $f $v]}
            dict set ${var} $f $v
          }
        }
      }
      foreach {var value} [$class clay get public/ array/] {
        set var [string trim $var :/]
        if { $var eq {clay} } continue
        my variable $var
        if {![info exists $var]} { array set $var {} }
        foreach {f v} $value {
          if {![array exists ${var}($f)]} {
            if {$::clay::trace>2} {puts [list initialize array $var\($f\) $v]}
            set ${var}($f) $v
          }
        }
      }
      ###
      # Build a compsite map of all ensembles defined by the object's current
      # class as well as all of the classes being mixed in
      ###
      foreach {mensemble einfo} [$class clay get method_ensemble/] {
        set ensemble [string trim $mensemble :/]
        if {$::clay::trace>2} {puts [list Defining $ensemble from $class]}

        foreach {method info} $einfo {
          dict set info source $class
          if {$::clay::trace>2} {puts [list Defining $ensemble -> $method from $class - $info]}
          dict set emap $ensemble $method $info
        }
      }
    }
    foreach {ensemble einfo} $emap {
      #if {[dict exists $einfo _body]} continue
      set body [::clay::ensemble_methodbody $ensemble $einfo]
      if {$::clay::trace>2} {
        set rawbody $body
        set body {puts [list [self] <object> [self method]]}
        append body \n $rawbody
      }
      oo::objdefine [self] method $ensemble {{method default} args} $body
    }
  }
}

