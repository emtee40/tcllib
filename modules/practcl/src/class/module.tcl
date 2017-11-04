
###
# In the end, all C code must be loaded into a module
# This will either be a dynamically loaded library implementing
# a tcl extension, or a compiled in segment of a custom shell/app
###
::oo::class create ::practcl::module {
  superclass ::practcl::object ::practcl::product.dynamic

  method _MorphPatterns {} {
    return {{@name@} {::practcl::module.@name@} ::practcl::module}
  }
  
  method add args {
    my variable links
    set object [::practcl::object new [self] {*}$args]
    foreach linktype [$object linktype] {
      lappend links($linktype) $object
    }
    return $object
  }

  method child which {
    switch $which {
      organs {
        return [list project [my define get project] module [self]]
      }
    }
  }

 ###
  # This methods generates the contents of an amalgamated .c file
  # which implements the loader for a batch of tools
  ###
  method generate-c {} {
    ::practcl::debug [list [self] [self method] [self class] -- [my define get filename] [info object class [self]]]
    set result {
/* This file was generated by practcl */
    }
    set includes {}

    foreach mod [my link list product] {
      # Signal modules to formulate final implementation
      $mod go
    }
    set headers {}

    my IncludeAdd headers <tcl.h> <tclOO.h>
    if {[my define get tk 0]} {
      my IncludeAdd headers <tk.h>
    }
    if {[my define get output_h] ne {}} {
      my IncludeAdd headers [my define get output_h]
    }
    my IncludeAdd headers {*}[my define get include]

    foreach mod [my link list dynamic] {
      my IncludeAdd headers {*}[$mod define get include]
    }
    foreach inc $headers {
      ::practcl::cputs result "#include $inc"
    }
    foreach {method} {
      generate-cfile-header
      generate-cfile-private-typedef
      generate-cfile-private-structure
      generate-cfile-public-structure
      generate-cfile-constant
      generate-cfile-global
      generate-cfile-functions
      generate-cfile-tclapi
    } {
      set dat [my $method]
      if {[string length [string trim $dat]]} {
        ::practcl::cputs result "/* BEGIN $method [my define get filename] */"
        ::practcl::cputs result $dat
        ::practcl::cputs result "/* END $method [my define get filename] */"
      }
    }
    ::practcl::debug [list /[self] [self method] [self class] -- [my define get filename] [info object class [self]]]
    return $result
  }


  ###
  # This methods generates the contents of an amalgamated .h file
  # which describes the public API of this module
  ###
  method generate-h {} {
    ::practcl::debug [list [self] [self method] [self class] -- [my define get filename] [info object class [self]]]
    set result {}
    set includes [my generate-hfile-public-includes]
    foreach inc $includes {
      if {[string index $inc 0] ni {< \"}} {
        ::practcl::cputs result "#include \"$inc\""
      } else {
        ::practcl::cputs result "#include $inc"
      }
    }

    foreach method {
      generate-hfile-public-define
      generate-hfile-public-macro
      generate-hfile-public-typedef
      generate-hfile-public-structure
    } {
      ::practcl::cputs result "/* BEGIN SECTION $method */"
      ::practcl::cputs result [my $method]
      ::practcl::cputs result "/* END SECTION $method */"
    }

    foreach file [my generate-hfile-public-verbatim] {
      ::practcl::cputs result "/* BEGIN $file */"
      ::practcl::cputs result [::practcl::cat $file]
      ::practcl::cputs result "/* END $file */"
    }

    foreach method {
      generate-hfile-public-headers
      generate-hfile-public-function
    } {
      ::practcl::cputs result "/* BEGIN SECTION $method */"
      ::practcl::cputs result [my $method]
      ::practcl::cputs result "/* END SECTION $method */"
    }
    return $result
  }

  method generate-loader {} {
    ::practcl::debug [list [self] [self method] [self class] -- [my define get filename] [info object class [self]]]
    set result {}
    if {[my define get initfunc] eq {}} return
    ::practcl::cputs result  "
extern int DLLEXPORT [my define get initfunc]( Tcl_Interp *interp ) \{"
    ::practcl::cputs result  {
  /* Initialise the stubs tables. */
  #ifdef USE_TCL_STUBS
    if (Tcl_InitStubs(interp, "8.6", 0)==NULL) return TCL_ERROR;
    if (TclOOInitializeStubs(interp, "1.0") == NULL) return TCL_ERROR;
}
    if {[my define get tk 0]} {
      ::practcl::cputs result  {    if (Tk_InitStubs(interp, "8.6", 0)==NULL) return TCL_ERROR;}
    }
    ::practcl::cputs result {  #endif}
    set TCLINIT [my generate-tcl-pre]
    if {[string length [string trim $TCLINIT]]} {
      ::practcl::cputs result "  if(interp) {\nif(Tcl_Eval(interp,[::practcl::tcl_to_c $TCLINIT])) return TCL_ERROR;\n  }"
    }
    ::practcl::cputs result [my generate-loader-module]

    set TCLINIT [my generate-tcl-post]
    if {[string length [string trim $TCLINIT]]} {
      ::practcl::cputs result "  if(interp) {\nif(Tcl_Eval(interp,[::practcl::tcl_to_c $TCLINIT])) return TCL_ERROR;\n }"
    }
    if {[my define exists pkg_name]} {
      ::practcl::cputs result  "    if (Tcl_PkgProvide(interp, \"[my define get pkg_name [my define get name]]\" , \"[my define get pkg_vers [my define get version]]\" )) return TCL_ERROR\;"
    }
    ::practcl::cputs result  "  return TCL_OK\;\n\}\n"
    return $result
  }
  method initialize {} {
    set filename [my define get filename]
    if {$filename eq {}} {
      return
    }
    if {[my define get name] eq {}} {
      my define set name [file tail [file dirname $filename]]
    }
    if {[my define get localpath] eq {}} {
      my define set localpath [my <project> define get name]_[my define get name]
    }
    my graft module [self]
    ::practcl::debug [self] SOURCE $filename
    my source $filename
  }

  method implement path {
    my go
    my Collate_Source $path
    set errs {}
    foreach item [my link list dynamic] {
      if {[catch {$item implement $path} err errdat]} {
        lappend errs "Skipped $item: [$item define get filename] $err"
        if {[dict exists $errdat -errorinfo]} {
          lappend errs [dict get $errdat -errorinfo]
        } else {
          lappend errs $errdat
        }
      }
    }
    foreach item [my link list module] {
      if {[catch {$item implement $path} err errdat]} {
        lappend errs "Skipped $item: [$item define get filename] $err"
        if {[dict exists $errdat -errorinfo]} {
          lappend errs [dict get $errdat -errorinfo]
        } else {
          lappend errs $errdat
        }
      }
    }
    if {[llength $errs]} {
      set fout [open [file join $::CWD practcl-err.log] w]
      puts $fout "*** ERRORS ***"
      puts $fout
      foreach {item trace} $errs {
        puts $fout "###\n# ERROR\n###\n$item"
        puts $fout "###\n# TRACE\n###\n$trace"
      }
      puts $fout "*** DEBUG INFO ***"
      puts $fout $::DEBUG_INFO
      close $fout
      exit 1
    }
    ::practcl::debug [list [self] [self method] [self class] -- [my define get filename] [info object class [self]]]
    set filename [my define get output_c]
    if {$filename eq {}} {
      ::practcl::debug [list /[self] [self method] [self class]]
      return
    }
    set cout [open [file join $path [file rootname $filename].c] w]
    puts $cout [subst {/*
** This file is generated by the [info script] script
** any changes will be overwritten the next time it is run
*/}]
    puts $cout [my generate-c]
    puts $cout [my generate-loader]
    close $cout
    ::practcl::debug [list /[self] [self method] [self class]]
  }

  method linktype {} {
    return {subordinate product dynamic module}
  }
}
