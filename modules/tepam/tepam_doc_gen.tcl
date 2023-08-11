##########################################################################
# TEPAM - Tcl's Enhanced Procedure and Argument Manager
##########################################################################
# tepam_doc.tcl - TEPAM doc generation package
# 
# Copyright (C) 2013 Andreas Drollinger
# 
# Id: tepam_doc.tcl
##########################################################################
# See the file "license.terms" for information on usage and redistribution
# of this file, and for a DISCLAIMER OF ALL WARRANTIES.
##########################################################################

package require Tcl 8.5 9
package require tepam 0.5

namespace eval tepam::doc_gen {
   # Exports the major commands from this package:
   namespace export doc_gen

   # Format validation command (checks if a format is defined)
   proc ::tepam::Validate(tepam_doc_format) {v} {expr {[info proc ::tepam::doc_gen::gen($v,Begin)]!=""}}
   
   # get_full_proc_name returns the full qualified procedure name. It takes also into acocunt
   # sub-procedure names: 'display message' -> '::display message'
   #
   proc get_full_proc_name {name} {
      return [concat [namespace origin [lindex $name 0]] [lrange $name 1 end]]
   }


   ##########################################################################
   #     generate: Generates the documentation for a procedure in a certain format
   ##########################################################################
   
   # The command 'generate' is the main procedure of the document generation framework. It
   # calls a set of sub procedures to generate the different document sections. The exact
   # content of each document segment is specified for each supported document format in 
   # a later part of this file.
   #
   tepam::procedure generate {
      -named_arguments_first 1
      -short_description "Get procedure documentation"
      -description
         "Generates the documentation for a given procedure in one of the supported\
         formats (TXT, HTML, POD (Perl Doc), DT (TclLib DocTool), or in an application specific\
         format).
         If a file is provided a full document file is generated that includes a proper file\
         header and file footer, and the file name is returned. Header and footer are otherwise\
         not generated and the documentation text is returned by doc_gen.
         The documentation is by default generated in Tcl style\
         (e.g. command <arg1> <arg2> ...). C-style documentation can be generated by setting\
         the argument 'style' to 'C' (e.g. command(<arg1>,<arg2>))."
      -example "generate -format HTML -dest_file my_func_help.html ::my_func"
      -args {
         {-format    -type tepam_doc_format -default TXT
                     -description "Documentation format"}
         {-style     -type string -default Tcl -choices {Tcl C}
                     -choicelabels {"Tcl style" "C style"}
                     -description "Procedure calling style used in the generated documentation"}
         {-header_footer -type none
                     -description "If set the header and footer are also generated. This flag is set by default if a file is generated."}
         {-dest_file -type file -optional
                     -description "Destination file name"}
         {name       -type string -validatecommand {expr ![catch {get_full_proc_name "%P"}]}
                     -validatecommand_error_text "Unknown procedure provided (argument 'name')"
                     -description "Procedure name for which the documentation has to be generated"}
      }
   } {
      # Create the full qualified procedure name (procedure name including namespace).
      # Check if the procedure name contains already the name space identification:
      set ProcName [get_full_proc_name $name]; # Variable name required by 'tepam::PureProcName'

      # Set the doc style to 'Tcl' if the short description starts with 'Property:'
      if {[info exists ::tepam::ProcDef($ProcName,-short_description)] && 
          [string first "Property:" $::tepam::ProcDef($ProcName,-short_description)]==0} {
         set style "Tcl"
      }

      # Define a function indicator for 'C' style documentation
      set FuncIndicator [expr {$style=="Tcl" ? "" : "()"}]
      
      # Set the header/footer generation flag if a file is generated
      if {[info exists dest_file]} {
         set header_footer 1
      }
      
      # Create the list of the main and sub-procedure names. Don't consider
      # the main procedure that is only used to access the sub procedures
      foreach pName [lsort [concat [list $ProcName] [info procs "$ProcName *"]]] {
         if {[info exists ::tepam::ProcDef($pName,VarList)]} { # Check that the procedure has been declared as TEPAM procedure
            lappend ProcNames $pName
         }
      }

      # Initiate the documentation string variable
      set Doc ""

      # Genrate the header if required
      if {$header_footer} {
         append Doc [gen($format,Header) [::tepam::PureProcName]]
      }
      
      # Generate the document prolog (preamble)
      append Doc [gen($format,Begin)]

      ### Name section ###
      # Add only the short description of the main procedure (in case sub procedures exist)
      append Doc [gen($format,SectionTitle) "Name"]
      if {[info exists ::tepam::ProcDef($ProcName,-short_description)]} { # Add the short description if existing
         append Doc [gen($format,Name) "[::tepam::PureProcName]$FuncIndicator - $::tepam::ProcDef($ProcName,-short_description)"]
      } else {
         append Doc [gen($format,Name) "[::tepam::PureProcName]$FuncIndicator"]
      }
      
      ### Synopsis section ###
      append Doc [gen($format,SectionTitle) "Synopsis"]
      set NbrDescriptions 0
      set NbrExamples 0
      # Add the synopsis for each main and sub procedures and register if they have a
      # description or an example
      foreach ProcName $ProcNames {
         incr NbrDescriptions [info exists ::tepam::ProcDef($ProcName,-description)]
         incr NbrExamples [info exists ::tepam::ProcDef($ProcName,-example)]
         append Doc [doc_gen_Synopsis $ProcName $format $style]
      }
   
      ### Description ###
      # Generate a description title if necessary (if a procedure has a description, or if
      # there is a main and sub procedures that are matching
      if {$NbrDescriptions>0 || [llength $ProcNames]>1} {
         append Doc [gen($format,SectionTitle) "Description"]
      }
   
      # Loop over all main and sub procedures
      foreach ProcName $ProcNames {
         # Add the sub-section title (= procedure name) if multiple procedures are matching
         if {[llength $ProcNames]>1} {
            append Doc [gen($format,SubSectionTitle) $ProcName]
         }
         
         # Add (again) the Synopsis line. Some documentation format require this 
         # synopsis line inside the description section, because the Synopsis is 
         # automatically derived (eg Tcl DocTools)
         append Doc [doc_gen_Synopsis $ProcName $format $style 1]
         
         # Add the description
         if {[info exists ::tepam::ProcDef($ProcName,-description)]} {
            append Doc [doc_gen_Description $ProcName $format $style]
         }
   
         ### Arguments ###
         # Add the argument section only if only one procedure is matching. The
         # arguments are otherwise listed in the description section.
         if {$::tepam::ProcDef($ProcName,VarList)!={}} {
            if {[llength $ProcNames]==1} {
               append Doc [gen($format,SectionTitle) "Arguments"]
            }
            append Doc [doc_gen_Arguments $ProcName $format $style]
         }
      }
      
      ### Example ###
      # Generate a example section if an example exists
      if {$NbrExamples>0} {
         append Doc [gen($format,SectionTitle) "Example"]
      }
      # Add the examples of each main and sub procedure
      foreach ProcName $ProcNames {
         if {[info exists ::tepam::ProcDef($ProcName,-example)]} {
            # Add the synopsis of the procedure that has an example, in case multiple 
            # procedures are matching
            if {[llength $ProcNames]>1} {
               # Add the sub-section title if multiple procedures are matching
               append Doc [gen($format,SubSectionTitle) $ProcName]
            }
            # Add the example
            append Doc [doc_gen_Example $ProcName $format $style]
         }
      }
      
      # Generate the document epilog
      append Doc [gen($format,End)]
      
      # Genrate the footer if required
      if {$header_footer} {
         append Doc [gen($format,Footer) ""]
      }

      # Save the documentation in a file and return the file name if 'dest_file' 
      # is defined. Return the documentation data otherwise.
      if {[info exists dest_file]} {
         set f [open $dest_file w]
         puts $f $Doc
         close $f
         return $dest_file
      } else {
         return $Doc
      }
   }
   
   # GetCleanText removes white spaces and "'" on the line begins.
   #
   proc GetCleanText {Text} {
      regsub -all {\n[\s\t]+'*} $Text "\n" Text
      return $Text
   }
   
   # doc_gen_Synopsis generates a formatted synopsis line. This string starts with 
   # the procedure name, followed by the arguments. The arguments are between 
   # parenthesis if not Tcl style is selected.
   #
   proc doc_gen_Synopsis {ProcName format style {DescriptionSynopsis 0}} {
      # Start the synopsis with the procedure name, followed with '(' if not Tcl style is selected
      set Synopsis [::tepam::PureProcName]
      append Synopsis [expr {$style=="Tcl" ? " " : "("}]

      # Add all arguments, separate them depending the style
      set Sep ""
      foreach Var $::tepam::ProcDef($ProcName,VarList) {
         append Synopsis $Sep
         append Synopsis [gen($format,ArgumentString) \
                             $Var $::tepam::ProcDef($ProcName,Arg,$Var,-optional) \
                             $::tepam::ProcDef($ProcName,Arg,$Var,IsNamed) \
                             $::tepam::ProcDef($ProcName,Arg,$Var,-type)]
         set Sep [expr {$style=="Tcl" ? " " : ", "}]
      }
      # Close the parenthesis if non Tcl style is selected
      append Synopsis [expr {$style=="Tcl" ? "" : ")"}]

      # Returned the formatted synopsis string
      if {$DescriptionSynopsis} {
         return [gen($format,DescriptionSynopsis) $Synopsis]
      } else {
         return [gen($format,Synopsis) $Synopsis]
      }
   }
   
   # doc_gen_Description generates a formatted documentation section. It recognizes
   # paragraphs and unordered lists in the description text and formats them adequately.
   #
   proc doc_gen_Description {ProcName format style} {
      # Get the cleaned-up description string
      set Description [GetCleanText $::tepam::ProcDef($ProcName,-description)]
      
      # Loop over every paragraph (parts separated with a newline)
      set ParStyle ""; # Stores the current paragraph style
      set formattedDescription ""; # Stores the formatted description section
      foreach Paragraph [split $Description \n] {
         # Remove eventual leading and tailing white spaces
         set Paragraph [string trim $Paragraph]
         
         # Handle unordered list items (line that starts with '*'). 
         if {[string index $Paragraph 0]=="*"} {
            # Add the list begin code if this is the first list item
            if {$ParStyle!="list"} {
               append formattedDescription [gen($format,DescriptionListBegin)]
            }
            # Add the list item (remove the leading '*')
            append formattedDescription [gen($format,DescriptionListItem) "[string trim [string range $Paragraph 1 end]]"]
            set ParStyle "list"
         
         # Handle non list paragraphs
         } else {
            # Close an eventually opened unordered list
            if {$ParStyle=="list"} {
               append formattedDescription [gen($format,DescriptionListEnd)]
            }
            # Add the paragraph
            append formattedDescription [gen($format,Description) $Paragraph]
            set ParStyle "par"
         }
      }
      
      # Close an eventually opened unordered list
      if {$ParStyle=="list"} {
         append formattedDescription [gen($format,DescriptionListEnd)]
      }
      
      # Return the formatted description
      return $formattedDescription
   }

   # doc_gen_Arguments generates the formatted argument section which includes a list of arguments
   # together with their descriptions and attributes
   #
   proc doc_gen_Arguments {ProcName format style} {
      # Start the section with the argument list prolog
      set formattedArguments [gen($format,ArgumentListBegin)]
      
      # Loop through all arguments
      foreach Var $::tepam::ProcDef($ProcName,VarList) {
         # Add the argument line
         append formattedArguments [gen($format,ArgumentListItem) \
                                        $Var $::tepam::ProcDef($ProcName,Arg,$Var,-optional) \
                                        $::tepam::ProcDef($ProcName,Arg,$Var,IsNamed) \
                                        $::tepam::ProcDef($ProcName,Arg,$Var,-type)]

         # Start the argument detail section, and add an eventual existing 
         # argument description
         append formattedArguments [gen($format,ArgumentDetailBegin)]
         if {[info exists ::tepam::ProcDef($ProcName,Arg,$Var,-description)] && $::tepam::ProcDef($ProcName,Arg,$Var,-description)!=""} {
            append formattedArguments [gen($format,ArgumentDescription) $::tepam::ProcDef($ProcName,Arg,$Var,-description)]
         }
      
         # Add the argument type if it is known and if it is not a flag (type=none)
         if {[lsearch -exact {"" "none"} $::tepam::ProcDef($ProcName,Arg,$Var,-type)]<0} {
            append formattedArguments [gen($format,ArgumentAttribute) "Type: $::tepam::ProcDef($ProcName,Arg,$Var,-type)"]
         }
         
         # Add the default value if existing. Put it in double quotes ("") if the 
         # type is unknown or a string, or if the default value is an empty string
         if {[info exists ::tepam::ProcDef($ProcName,Arg,$Var,-default)]} {
            if {[lsearch -exact {"" "string"} $::tepam::ProcDef($ProcName,Arg,$Var,-type)]>=0 || $::tepam::ProcDef($ProcName,Arg,$Var,-default)==""} {
               append formattedArguments [gen($format,ArgumentAttribute) "Default: \"$::tepam::ProcDef($ProcName,Arg,$Var,-default)\""]
            } else {
               append formattedArguments [gen($format,ArgumentAttribute) "Default: $::tepam::ProcDef($ProcName,Arg,$Var,-default)"]
            }
         }
         
         # Add the remaining attributes if they exist
         if {$::tepam::ProcDef($ProcName,Arg,$Var,-multiple)} {
            append formattedArguments [gen($format,ArgumentAttribute) "Multiple: yes"]
         }
         if {[info exists ::tepam::ProcDef($ProcName,Arg,$Var,-range)]} {
            append formattedArguments [gen($format,ArgumentAttribute) "Range: [lindex $::tepam::ProcDef($ProcName,Arg,$Var,-range) 0]..[lindex $::tepam::ProcDef($ProcName,Arg,$Var,-range) 1]"]
         }
         if {[info exists ::tepam::ProcDef($ProcName,Arg,$Var,-choices)]} {
            append formattedArguments [gen($format,ArgumentAttribute) "Choices: [::tepam::GetChoiceHelpText $ProcName $Var]"]
         }
         append formattedArguments [gen($format,OptionDetailEnd)]
      }
      
      # Add the argument section's epilog, and return the optained formatted section string
      append formattedArguments [gen($format,OptionEnd)]
      return $formattedArguments
   }

   # doc_gen_Example generates a formatted example section. It handles every
   # example line individually and formats it either as a command line, or as
   # a result line.
   #
   proc doc_gen_Example {ProcName format style} {
      # Cleanup the example paragraph
      set Example [GetCleanText [string trim $::tepam::ProcDef($ProcName,-example)]]
      
      # Generate the example section prolog
      set formattedExample [gen($format,ExampleBegin)]
      
      # Loop through all example lines
      foreach line [split $Example \n] {
         # Format the line either as an example command, or as a result
         if {[string range $line 0 1]=="->"} {
            append formattedExample [gen($format,ExampleResultLine) $line]
         } else {
            append formattedExample [gen($format,ExampleCommandLine) $line]
         }
      }
      
      # Add the example section's epilog, and return the formatted example section
      append formattedExample [gen($format,ExampleEnd)]
      return $formattedExample
   }
   
   ##########################################################################
   #     patch: Patches an existing documentation by inserting procedure documentations
   ##########################################################################
   
   # Patches an existing master document by inserting procedure documentations. The
   # command calls 'generate' to get the documentation of for the different procedures.
   #
   tepam::procedure patch {
      -named_arguments_first 1
      -short_description "Patches an existing master document by inserting procedure documentations"
      -description
         "Patch inserts procedure documentations into an existing master document at the\
         locations indicated by insertion placeholders that are matching the pattern of\
         'search_pattern'.
         The existing master document is either provided as string argument (src_string)\
         or as a file (src_file). The final document is returned by patch if no\
         destination file is defined (via 'dest_file'). Otherwise, the document is stored\
         in a file, and the number of insertion placeholders that could be handled\
         successfully is returned.
         Any insertion placeholders of the master document are handled by default. By\
         defining the argument 'name' the documentation insertion will be restricted\
         to a particular procedure.
         Patch handles the documentation in one of the supported\
         formats (TXT, HTML, POD (Perl Doc), DT (TclLib DocTool), or in an application\
         specific format). The documentation is by default generated in Tcl style\
         (e.g. command <arg1> <arg2> ...). C-style documentation can be generated by\
         setting the argument 'style' to 'C' (e.g. command(<arg1>,<arg2>))."
      -example "patch -format HTML -src_file my_func_help.template -dest_file my_func_help.html"
      -args {
         {-format    -type tepam_doc_format -default TXT
                     -description "Documentation format"}
         {-style     -type string -default Tcl -choices {Tcl C}
                     -choicelabels {"Tcl style" "C style"}
                     -description "Procedure calling style used in the generated documentation"}
         {-search_pattern -type string -default {\{!(.*?)!\}}
                     -description "Regular expression search pattern"}
         {-src_string -type string -optional
                     -description "Source string"}
         {-src_file -type existingfile -optional
                     -description "Source file name"}
         {-dest_file -type file -optional
                     -description "Destination file name"}
         {name       -type string -optional -validatecommand {expr ![catch {get_full_proc_name "%P"}]}
                     -validatecommand_error_text "Unknown procedure provided (argument 'name')"
                     -description "Procedure name to which the document generation is restricted"}
      }
      -validatecommand {expr {[info exists src_file]!=[info exists src_string]}}
      -validatecommand_error_text "Either src_string or src_file need to be defined!"
   } {
      # In case a procedure name is provided, make sure it is fully qualified
      if {[info exists name]} {
         set name [get_full_proc_name $name]
      }

      # Load the master document data
      if {[info exists src_file]} {
         set f [open $src_file r]
         set Doc [read $f 0x10000000]
         close $f
      } else {
         set Doc $src_string
      }

      # Get all placeholder locations
      set AllMatchPos [regexp -all -indices -inline $search_pattern $Doc]
      
      # Handle all placeholders, starting at the document end. Don't rely on
      # 'lreverse' (only available in Tcl8.5)
      set NbrInsertion 0
      for {set m [expr [llength $AllMatchPos]-1]} {$m>=0} {incr m -2} {
         set MatchPos [lindex $AllMatchPos $m-1]
         set ProcPos [lindex $AllMatchPos $m-0]
         set ProcName [string range $Doc [lindex $ProcPos 0] [lindex $ProcPos 1]]
         
         # Catch any errors: Documentations that cannot be generated for certain procedures
         # are simply skipped
         catch {
            # Make sure a fully qualified procedure name is used
            set ProcName [get_full_proc_name $ProcName]
            
            # Skip the procedure if it is not matching with the defined procedure name
            if {[info exists name] && $name!=$ProcName} continue
         
            # Replace the placeholder with the procedure documentation
            set ProcHelp [tepam::doc_gen::generate -format $format -style $style $ProcName]
            set Doc [string replace $Doc [lindex $MatchPos 0] [lindex $MatchPos 1] $ProcHelp]
            incr NbrInsertion
         }
      }

      # Save the patched master document in a file if 'dest_file' is defined. Return 
      # the document data otherwise.
      if {[info exists dest_file]} {
         set f [open $dest_file w]
         puts $f $Doc
         close $f
         return $NbrInsertion
      } else {
         return $Doc
      }
   }

   
   ##########################################################################
   #     Documentation style definitions
   ##########################################################################

   # Various document generation options will be stored in the array variable 'Option'.
   array set Option {}
   
   ###### Text ######
   
   # Text document generation options
   set Option(TXT,MaxLineLength) 80; # Specifies the word wrap limit

   # TxtFormat formats text in the following way: Tabulator characters are 
   # replaced by 3 spaces. Lines are reformatted to respect the maximum 
   # allowed line length. In case a line is wrapped, the leading spaces of the 
   # first line are added to the begin of the following lines. Multiple lines 
   # can be provided as text piece and these multiple lines are handled 
   # independently each to another.

   proc TxtFormat {Text} {
      variable Option
      set FormatedText ""
      
      # Replace tabs through 3 spaces:
      regsub -all {\t} $Text "   " Text
      
      # Extract the initial spaces of the first line:
      regexp {^(\s*)} $Text {} SpaceStart
      
      # Loop through each of the provided help text line:
      foreach line [split $Text "\n"] {
         
         # Eliminate leading spaces of the line:
         regexp {^\s+'*(.*)$} $line {} line
         
         # Cut the line into segments that doesn't exceed the maximum allowed help line length. 
         # Add in front of each new line the initial spaces of the first line:
         while {$line!=""} {
            # Align the leading line spaces to the first line:
            set line ${SpaceStart}${line}
            
            #### Next line cutoff position evaluation ####

            # Select the next line cut position. The default position is set to the line end:
            set LastPos [string length $line]
            # Search for the last space inside the line section that is inside the specified 
            # maximum line length:
            if {$LastPos>$Option(TXT,MaxLineLength)} {
               set LastPos [string last " " $line $Option(TXT,MaxLineLength)]
            }
            # If the evaluated line break position is inside the range of the initial line spaces,
            # something goes wrong and the line should be broken at another adequate character:
            if {$LastPos<=[string length $SpaceStart]-1} {
               # Search for other good line break characters (:
               set LastPos [lindex [lindex \
                  [regexp -inline -indices {[^,:\.?\)]+$} \
                  {ProcDef(::ImportTestPointAssignmentsGeneric,Arg_SectionComment,ColumnSeparation}] 0] 0]
               # No line break position could be found:
               if {$LastPos=={}} {set LinePos 0}
            }
            # Break the line simply at the maximum allowed length in case no break position could 
            # be found:
            if {$LastPos<=[string length $SpaceStart]-1} {set LastPos $Option(TXT,MaxLineLength)}

            # Add the line segment to the help text:
            append FormatedText [string range $line 0 [expr $LastPos-1]]\n
            
            # Eliminate the segment from the actual line:
            set line [string range $line [expr $LastPos+1] end]
         }
      }
      return $FormatedText
   }

   proc gen(TXT,Header) {Text}                 {return [TxtFormat ""]}
   proc gen(TXT,Begin) {}                      {return [TxtFormat ""]}
   proc gen(TXT,End) {}                        {return [TxtFormat ""]}
   proc gen(TXT,SectionTitle) {Text}           {return [TxtFormat "  [string toupper $Text]\n"]}
   proc gen(TXT,SubSectionTitle) {Text}        {return [TxtFormat "    $Text\n"]}
   proc gen(TXT,Name) {Text}                   {return [TxtFormat "      $Text\n"]}
   proc gen(TXT,Synopsis) {Text}               {return [TxtFormat "      $Text\n"]}
   proc gen(TXT,Description) {Text}            {return [TxtFormat "      $Text\n"]}
   proc gen(TXT,DescriptionSynopsis) {Text}    {return ""}
   proc gen(TXT,DescriptionListBegin) {}       {return [TxtFormat ""]}
   proc gen(TXT,DescriptionListItem) {Text}    {return [TxtFormat "      * $Text\n"]}
   proc gen(TXT,DescriptionListEnd)   {}       {return [TxtFormat ""]}
   proc gen(TXT,ArgumentListBegin) {}          {return [TxtFormat ""]}
   proc gen(TXT,ArgumentString) {Name IsOptional IsNamed Type} {
      if {$IsNamed} {set ArgStr "-$Name"}
      if {$Type!="none"} {append ArgStr " <$Name>"}
      set ArgStr [string trim $ArgStr]
      if {$IsOptional} {set ArgStr "\[$ArgStr\]"}
      return $ArgStr
   }
   proc gen(TXT,ArgumentListItem) {Name IsOptional IsNamed Type} {
      return "      [gen(TXT,ArgumentString) $Name $IsOptional $IsNamed $Type]\n"
   }
   proc gen(TXT,ArgumentDetailBegin)  {}       {return [TxtFormat ""]}
   proc gen(TXT,ArgumentDescription) {Text}    {return [TxtFormat "        $Text\n"]}
   proc gen(TXT,ArgumentAttribute) {Text}      {return [TxtFormat "        $Text\n"]}
   proc gen(TXT,OptionDetailEnd)  {}           {return [TxtFormat ""]}
   proc gen(TXT,OptionEnd)   {}                {return [TxtFormat ""]}
   proc gen(TXT,ExampleBegin) {}               {return [TxtFormat ""]}
   proc gen(TXT,ExampleCommandLine) {Text}     {return [TxtFormat "      $Text"]}
   proc gen(TXT,ExampleResultLine) {Text}      {return [TxtFormat "      $Text"]}
   proc gen(TXT,ExampleEnd) {}                 {return [TxtFormat ""]}
   proc gen(TXT,Footer) {Text}                 {return [TxtFormat ""]}

   ###### HTML ######

   # HTML document generation options
   set Option(HTML,CssFile) "tepam_doc_stylesheet.css"; # Specifies the CSS stylesheet file

   proc Htmlformat {Text} {
      regsub -all {<} $Text {\&lt;} Text
      regsub -all {>} $Text {\&gt;} Text
      return $Text
   }

   proc gen(HTML,Header) {Text}                {set    s "<html>\n"
                                                append s "  <head>\n"
                                                append s "    <title>[Htmlformat $Text]</title>\n"
                                                append s "    <link rel=\"stylesheet\" href=\"$::tepam::doc_gen::Option(HTML,CssFile)\">\n"
                                                append s "  </head>\n"
                                                append s "  <body>\n"
                                                append s "      <h1 class=\"tepam_page_title\">[Htmlformat $Text]</h1>\n"
                                                return $s }
   proc gen(HTML,Begin) {}                     {return "<div class=\"tepam_command_help\">\n"}
   proc gen(HTML,End) {}                       {return "</div><p></p>\n"}
   proc gen(HTML,SectionTitle) {Text}          {return "    <p class=\"tepam_section_title\">[Htmlformat $Text]</p>\n"}
   proc gen(HTML,SubSectionTitle) {Text}       {return "    <p class=\"tepam_sub_section_title\">[Htmlformat $Text]</p>\n"}
   proc gen(HTML,Name) {Text}                  {return "      <p class=\"tepam_name\">[Htmlformat $Text]</p>\n"}
   proc gen(HTML,Synopsis) {Text}              {return "      <p class=\"tepam_synopsis\">$Text</p>\n"}
   proc gen(HTML,Description) {Text}           {return "      <p class=\"tepam_description\">[Htmlformat $Text]</p>\n"}
   proc gen(HTML,DescriptionSynopsis) {Text}   {return ""}
   proc gen(HTML,DescriptionListBegin) {}      {return "      <ul class=\"tepam_description_list\">\n"}
   proc gen(HTML,DescriptionListItem) {Text}   {return "        <li>[Htmlformat $Text]</li>\n"}
   proc gen(HTML,DescriptionListEnd)   {}      {return "      </ul>\n"}
   proc gen(HTML,ArgumentListBegin) {}         {return "      <dl>\n"}
   proc gen(HTML,ArgumentString) {Name IsOptional IsNamed Type} {
      if {$IsNamed} {set ArgStr "-$Name"}
      if {$Type!="none"} {append ArgStr " <$Name>"}
      set ArgStr [string trim $ArgStr]
      if {$IsOptional} {set ArgStr "\[$ArgStr\]"}
      return [Htmlformat $ArgStr]
   }
   proc gen(HTML,ArgumentListItem) {Name IsOptional IsNamed Type} {
      return "        <dt class=\"tepam_argument\">[gen(HTML,ArgumentString) $Name $IsOptional $IsNamed $Type]</dt>\n"
   }
   proc gen(HTML,ArgumentDetailBegin)  {}      {return "          <dd>\n"}
   proc gen(HTML,ArgumentDescription) {Text}   {return "            <p class=\"tepam_argument_description\">[Htmlformat $Text]</p>\n"}
   proc gen(HTML,ArgumentAttribute) {Text}     {return "              <p class=\"tepam_argument_attribute\">[Htmlformat $Text]</p>\n"}
   proc gen(HTML,OptionDetailEnd)  {}          {return "          </dd>\n"}
   proc gen(HTML,OptionEnd)   {}               {return "      </dl>\n"}
   proc gen(HTML,ExampleBegin) {}              {return "    <pre class=\"tepam_example\">"}
   proc gen(HTML,ExampleCommandLine) {Text}    {return "<strong>[Htmlformat $Text]</strong>\n"}
   proc gen(HTML,ExampleResultLine) {Text}     {return "<em>[Htmlformat $Text]</em>\n"}
   proc gen(HTML,ExampleEnd) {}                {return "</pre>\n"}
   proc gen(HTML,Footer) {Text}                {return "  </body>\n<html>"}

   ###### POD ######
   
   proc Podformat {Text} {
      regsub -all {<} $Text {E<lt>} Text
      regsub -all {([^E][^<][^l][^t])>} $Text {\1E<gt>} Text
      regsub -all {\|} $Text {E<verbar>} Text
      regsub -all {/} $Text {E<sol>} Text
      return $Text
   }

   proc gen(POD,Header) {Text}                 {return [Podformat ""]}
   proc gen(POD,Begin) {}                      {return ""}
   proc gen(POD,End) {}                        {return ""}
   proc gen(POD,SectionTitle) {Text}           {return "=head1 [Podformat [string toupper $Text]]\n\n"}
   proc gen(POD,SubSectionTitle) {Text}        {return "=head2 [Podformat $Text]\n\n"}
   proc gen(POD,Name) {Text}                   {return "B<[Podformat $Text]>\n\n"}
   proc gen(POD,Synopsis) {Text}               {return "$Text\n\n"}
   proc gen(POD,Description) {Text}            {return "[Podformat $Text]\n\n"}
   proc gen(POD,DescriptionSynopsis) {Text}    {return ""}
   proc gen(POD,DescriptionListBegin) {}       {return "=over 4\n\n"}
   proc gen(POD,DescriptionListItem) {Text}    {return "=item * [Podformat $Text]\n\n"}
   proc gen(POD,DescriptionListEnd)   {}       {return "=back\n\n"}
   proc gen(POD,ArgumentListBegin) {}          {return "=over 4\n\n"}
   proc gen(POD,ArgumentString) {Name IsOptional IsNamed Type} {
      if {$IsNamed} {set ArgStr "-$Name"}
      if {$Type!="none"} {append ArgStr " <$Name>"}
      set ArgStr [string trim $ArgStr]
      if {$IsOptional} {set ArgStr "\[$ArgStr\]"}
      return [Podformat $ArgStr]
   }
   proc gen(POD,ArgumentListItem) {Name IsOptional IsNamed Type} {
      return "=item [gen(POD,ArgumentString) $Name $IsOptional $IsNamed $Type]\n\n"
   }
   proc gen(POD,ArgumentDetailBegin)  {}       {return ""}
   proc gen(POD,ArgumentDescription) {Text}    {return "[Podformat $Text]\n\n"}
   proc gen(POD,ArgumentAttribute) {Text}      {return "[Podformat $Text]\n\n"}
   proc gen(POD,OptionDetailEnd)  {}           {return ""}
   proc gen(POD,OptionEnd)   {}                {return "=back\n\n"}
   proc gen(POD,ExampleBegin) {}               {return ""}
   proc gen(POD,ExampleCommandLine) {Text}     {return "C<B<[Podformat $Text]>>\n\n"}
   proc gen(POD,ExampleResultLine) {Text}      {return "C<I<[Podformat $Text]>>\n\n"}
   proc gen(POD,ExampleEnd) {}                 {return ""}
   proc gen(POD,Footer) {Text}                 {return ""}

   ###### Tcllib doctools ######

   proc Dtformat {Text} {
      regsub -all {([\[\]])} $Text {\\\1} Text
      return $Text
   }

   proc gen(DT,Header) {Text} {
      upvar ProcName ProcName
      set    s "\[manpage_begin \"$Text\" n 1.0.3\]\n"
      if {[info exists ::tepam::ProcDef($ProcName,-short_description)]} {
         append s "\[moddesc \{[Dtformat $::tepam::ProcDef($ProcName,-short_description)]\}\]\n"
         append s "\[titledesc \{[Dtformat $::tepam::ProcDef($ProcName,-short_description)]\}\]\n"
      }
      append s "\[description\]\n"
      return $s
   }
   proc gen(DT,Begin) {}                       {return ""}
   proc gen(DT,End) {}                         {return ""}
   proc gen(DT,SectionTitle) {Text}            {
      if {[lsearch -exact {Name Synopsis Description} $Text]>=0} return
      return "\n\[section \"[Dtformat $Text]\"\]\n\n"
   }
   proc gen(DT,SubSectionTitle) {Text}            {
      return "\n\[subsection \"[Dtformat $Text]\"\]\n\n"
   }
   proc gen(DT,Name) {Text}                    {return ""}
   proc gen(DT,Synopsis) {Text}                {return ""}; # DocTools generates automatically the Synopsis
   proc gen(DT,Description) {Text}             {
      return "[Dtformat $Text]\[para\]\n"}
   proc gen(DT,DescriptionSynopsis) {Text}     { # Add the synopsis to the begin of the description. This will generate then also the Synopsis.
      set    s "\[list_begin definitions\]\n"
      append s "\[call $Text\]\n"
      append s "\[list_end\]\n"
      return $s
   }
   proc gen(DT,DescriptionListBegin) {}        {return "\[list_begin itemized\]\n"}
   proc gen(DT,DescriptionListItem) {Text}     {return "  \[item\][Dtformat $Text]\n"}
   proc gen(DT,DescriptionListEnd)   {}        {return "\[list_end\]\n"}
   proc gen(DT,ArgumentListBegin) {}           {return "\[list_begin definitions\]\n\n"}
   proc gen(DT,ArgumentString) {Name IsOptional IsNamed Type} {
      if {$IsNamed} {set ArgStr "-$Name"}
      if {$Type!="none"} {append ArgStr " \[arg $Name\]"}
      set ArgStr [string trim $ArgStr]
      if {$IsOptional} {set ArgStr "\[opt \"$ArgStr\"\]"}
      return $ArgStr
   }
   proc gen(DT,ArgumentListItem) {Name IsOptional IsNamed Type} {
      return "\[def [gen(DT,ArgumentString) $Name $IsOptional $IsNamed $Type]\]\n"
   }
   proc gen(DT,ArgumentDetailBegin)  {}        {return ""}
   proc gen(DT,ArgumentDescription) {Text}     {return "  \[para\][Dtformat $Text]\n"}
   proc gen(DT,ArgumentAttribute) {Text}       {return "  \[para\][Dtformat $Text]\n"}
   proc gen(DT,OptionDetailEnd)  {}            {return "\n"}
   proc gen(DT,OptionEnd)   {}                 {return "\[list_end\]\n"}
   proc gen(DT,ExampleBegin) {}                {return "\[para\]\n\[example \{\n"}
   proc gen(DT,ExampleCommandLine) {Text}      {return "[Dtformat $Text]\n"}
   proc gen(DT,ExampleResultLine) {Text}       {return "[Dtformat $Text]\n"}
   proc gen(DT,ExampleEnd) {}                  {return "\}\]\n"}
   proc gen(DT,Footer) {Text}                  {return "\[manpage_end\]"}

}; # End namespace tepam::doc

# Specify the TEPAM version that is provided by this file:
package provide tepam::doc_gen 0.1.1

##########################################################################
# Id: tepam_doc.tcl
# Modifications:
#
# Revision 0.1.1  2013/10/18 droll
# * Correction of bug [66d0effebc]: POD format incorrectly formatted
#
# Revision 0.1.0  2013/10/14 droll
# * First TEPAM doc_gen revision
##########################################################################
