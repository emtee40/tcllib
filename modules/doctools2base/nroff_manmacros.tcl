# -*- tcl -*-
# Copyright (c) 2009 Andreas Kupries <andreas_kupries@sourceforge.net>

# Support package. Container for the man.macros needed by the nroff
# export plugins when instructed to inline the commands the
# documentation is using.

# # ## ### ##### ######## ############# #####################
## Requirements

package require Tcl 8.5 9 ; # Required Core

namespace eval ::doctools::nroff::man_macros {
    # Contents of the file we carry
    variable c {}
}

proc ::doctools::nroff::man_macros::contents {} {
    variable c
    return  $c
}

set ::doctools::nroff::man_macros::c {'\" The definitions below are for supplemental macros used in Tcl/Tk
'\" manual entries.
'\"
'\" .AP type name in/out ?indent?
'\"	Start paragraph describing an argument to a library procedure.
'\"	type is type of argument (int, etc.), in/out is either "in", "out",
'\"	or "in/out" to describe whether procedure reads or modifies arg,
'\"	and indent is equivalent to second arg of .IP (shouldn't ever be
'\"	needed;  use .AS below instead)
'\"
'\" .AS ?type? ?name?
'\"	Give maximum sizes of arguments for setting tab stops.  Type and
'\"	name are examples of largest possible arguments that will be passed
'\"	to .AP later.  If args are omitted, default tab stops are used.
'\"
'\" .BS
'\"	Start box enclosure.  From here until next .BE, everything will be
'\"	enclosed in one large box.
'\"
'\" .BE
'\"	End of box enclosure.
'\"
'\" .CS
'\"	Begin code excerpt.
'\"
'\" .CE
'\"	End code excerpt.
'\"
'\" .VS ?version? ?br?
'\"	Begin vertical sidebar, for use in marking newly-changed parts
'\"	of man pages.  The first argument is ignored and used for recording
'\"	the version when the .VS was added, so that the sidebars can be
'\"	found and removed when they reach a certain age.  If another argument
'\"	is present, then a line break is forced before starting the sidebar.
'\"
'\" .VE
'\"	End of vertical sidebar.
'\"
'\" .DS
'\"	Begin an indented unfilled display.
'\"
'\" .DE
'\"	End of indented unfilled display.
'\"
'\" .SO
'\"	Start of list of standard options for a Tk widget.  The
'\"	options follow on successive lines, in four columns separated
'\"	by tabs.
'\"
'\" .SE
'\"	End of list of standard options for a Tk widget.
'\"
'\" .OP cmdName dbName dbClass
'\"	Start of description of a specific option.  cmdName gives the
'\"	option's name as specified in the class command, dbName gives
'\"	the option's name in the option database, and dbClass gives
'\"	the option's class in the option database.
'\"
'\" .UL arg1 arg2
'\"	Print arg1 underlined, then print arg2 normally.
'\"
'\" RCS: @(#) $Id: nroff_manmacros.tcl,v 1.2 2009/04/29 02:09:46 andreas_kupries Exp $
'\"
'\"	# Set up traps and other miscellaneous stuff for Tcl/Tk man pages.
.if t .wh -1.3i ^B
.nr ^l \n(.l
.ad b
'\"	# Start an argument description
.de AP
.ie !"\\$4"" .TP \\$4
.el \{\
.   ie !"\\$2"" .TP \\n()Cu
.   el          .TP 15
.\}
.ta \\n()Au \\n()Bu
.ie !"\\$3"" \{\
\&\\$1	\\fI\\$2\\fP	(\\$3)
.\".b
.\}
.el \{\
.br
.ie !"\\$2"" \{\
\&\\$1	\\fI\\$2\\fP
.\}
.el \{\
\&\\fI\\$1\\fP
.\}
.\}
..
'\"	# define tabbing values for .AP
.de AS
.nr )A 10n
.if !"\\$1"" .nr )A \\w'\\$1'u+3n
.nr )B \\n()Au+15n
.\"
.if !"\\$2"" .nr )B \\w'\\$2'u+\\n()Au+3n
.nr )C \\n()Bu+\\w'(in/out)'u+2n
..
.AS Tcl_Interp Tcl_CreateInterp in/out
'\"	# BS - start boxed text
'\"	# ^y = starting y location
'\"	# ^b = 1
.de BS
.br
.mk ^y
.nr ^b 1u
.if n .nf
.if n .ti 0
.if n \l'\\n(.lu\(ul'
.if n .fi
..
'\"	# BE - end boxed text (draw box now)
.de BE
.nf
.ti 0
.mk ^t
.ie n \l'\\n(^lu\(ul'
.el \{\
.\"	Draw four-sided box normally, but don't draw top of
.\"	box if the box started on an earlier page.
.ie !\\n(^b-1 \{\
\h'-1.5n'\L'|\\n(^yu-1v'\l'\\n(^lu+3n\(ul'\L'\\n(^tu+1v-\\n(^yu'\l'|0u-1.5n\(ul'
.\}
.el \}\
\h'-1.5n'\L'|\\n(^yu-1v'\h'\\n(^lu+3n'\L'\\n(^tu+1v-\\n(^yu'\l'|0u-1.5n\(ul'
.\}
.\}
.fi
.br
.nr ^b 0
..
'\"	# VS - start vertical sidebar
'\"	# ^Y = starting y location
'\"	# ^v = 1 (for troff;  for nroff this doesn't matter)
.de VS
.if !"\\$2"" .br
.mk ^Y
.ie n 'mc \s12\(br\s0
.el .nr ^v 1u
..
'\"	# VE - end of vertical sidebar
.de VE
.ie n 'mc
.el \{\
.ev 2
.nf
.ti 0
.mk ^t
\h'|\\n(^lu+3n'\L'|\\n(^Yu-1v\(bv'\v'\\n(^tu+1v-\\n(^Yu'\h'-|\\n(^lu+3n'
.sp -1
.fi
.ev
.\}
.nr ^v 0
..
'\"	# Special macro to handle page bottom:  finish off current
'\"	# box/sidebar if in box/sidebar mode, then invoked standard
'\"	# page bottom macro.
.de ^B
.ev 2
'ti 0
'nf
.mk ^t
.if \\n(^b \{\
.\"	Draw three-sided box if this is the box's first page,
.\"	draw two sides but no top otherwise.
.ie !\\n(^b-1 \h'-1.5n'\L'|\\n(^yu-1v'\l'\\n(^lu+3n\(ul'\L'\\n(^tu+1v-\\n(^yu'\h'|0u'\c
.el \h'-1.5n'\L'|\\n(^yu-1v'\h'\\n(^lu+3n'\L'\\n(^tu+1v-\\n(^yu'\h'|0u'\c
.\}
.if \\n(^v \{\
.nr ^x \\n(^tu+1v-\\n(^Yu
\kx\h'-\\nxu'\h'|\\n(^lu+3n'\ky\L'-\\n(^xu'\v'\\n(^xu'\h'|0u'\c
.\}
.bp
'fi
.ev
.if \\n(^b \{\
.mk ^y
.nr ^b 2
.\}
.if \\n(^v \{\
.mk ^Y
.\}
..
'\"	# DS - begin display
.de DS
.RS
.nf
.sp
..
'\"	# DE - end display
.de DE
.fi
.RE
.sp
..
'\"	# SO - start of list of standard options
.de SO
.SH "STANDARD OPTIONS"
.LP
.nf
.ta 4c 8c 12c
.ft B
..
'\"	# SE - end of list of standard options
.de SE
.fi
.ft R
.LP
See the \\fBoptions\\fR manual entry for details on the standard options.
..
'\"	# OP - start of full description for a single option
.de OP
.LP
.nf
.ta 4c
Command-Line Name:	\\fB\\$1\\fR
Database Name:	\\fB\\$2\\fR
Database Class:	\\fB\\$3\\fR
.fi
.IP
..
'\"	# CS - begin code excerpt
.de CS
.RS
.nf
.ta .25i .5i .75i 1i
..
'\"	# CE - end code excerpt
.de CE
.fi
.RE
..
.de UL
\\$1\l'|0\(ul'\\$2
..}

package provide doctools::nroff::man_macros 0.2
return
