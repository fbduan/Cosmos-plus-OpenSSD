
#################################################################
#
#   Utils procedure used in the fifo_generator_v12_0 tcl script
#
#################################################################

namespace eval fifo_generator_v12_0_utils {
namespace import [namespace parent]::blk_mem_gen_v8_2_utils::*
   ###################################################################
   #
   # set_Output_Data_Width
   #
   ###################################################################
   proc set_Output_Data_Width {Input_Data_Width Input_Depth} {

      set valid_width_list []

      set narrow_bound 8
      set wide_bound 8
      
      # add primitives narrower than write_a to the list
      for {set i $narrow_bound} {$i >= 2} {set i [expr $i/2]} {
	 #Check to see if we can divide the width evenly
	 if {[ expr {$Input_Data_Width % $i }] == 0} {
	    #Check if the new depth would be too large
	    if {[ expr {$Input_Data_Width / $i }] >= 1} {
	       tcl::lappend valid_width_list [expr { $Input_Data_Width / $i}]
	    }
	 }
      }
      
      tcl::lappend valid_width_list $Input_Data_Width
      
      # add primitives wider than write_a to the list
      for {set i 2} {$i <= $wide_bound} {set i [expr $i*2]} {
	 #Check to see if we can divide the depth evenly
	 if {[ expr {$Input_Depth % $i }] == 0} {
	    #Check if the new depth would be too small
	    if {[ expr {$Input_Depth / $i }] >= 16} {
	       #Check if the width is below the max width
	       if {[ expr {$Input_Data_Width * $i }] <= 1024} {
		  tcl::lappend valid_width_list [expr { $Input_Data_Width * $i}]
	       }
	    }
	 }
      }
      
      return $valid_width_list
   }

   ###################################################################
   #
   # set_Output_Data_Width for 8 series in Builtin fifo
   #
   ###################################################################
   proc set_Output_Data_Width_8series_builtin_fifo {Input_Data_Width Input_Depth asym } {

      set valid_width_list []

      set narrow_bound 8
      set wide_bound 8
	  set upper_limit 8192
	
       if { $asym  && [ expr {$Input_Data_Width % 9} ] == 0 } { set upper_limit  4096}
      # add primitives narrower than write_a to the list
      for {set i $narrow_bound} {$i >= 2} {set i [expr $i/2]} {
	 #Check to see if we can divide the width evenly
	 #send_msg INFO 2010 "narrow_bound = $i"
	 if {[ expr {$Input_Data_Width % $i }] == 0} {
	    #Check if the new depth would be too large
	    if {[ expr {$Input_Data_Width / $i }] >= 4} {
              if {[ expr {$Input_Depth * $i }] <= $upper_limit} {
	        tcl::lappend valid_width_list [expr { $Input_Data_Width / $i}]
	       }
	    }
	 }
      }
      #send_msg INFO 2020 "Input_data_width = $Input_Data_Width"
      tcl::lappend valid_width_list $Input_Data_Width
	  	
      # add primitives wider than write_a to the list
      for {set i 2} {$i <= $wide_bound} {set i [expr $i*2]} {
	 #Check to see if we can divide the depth evenly
	 if {[ expr {$Input_Depth % $i }] == 0} {
	    #Check if the new depth would be too small
	    if {[ expr {$Input_Depth / $i }] >= 512} {
	       #Check if the width is below the max width
	       if {[ expr {$Input_Data_Width * $i }] <= 1024} {
		#   send_msg INFO 2040 "valid values = [expr { $Input_Data_Width * $i}]"
		  tcl::lappend valid_width_list [expr { $Input_Data_Width * $i}]
	       }
	    }
	 }
      }
      #send_msg INFO 2050 "valid_width_list = $valid_width_list"
      return $valid_width_list
   }


   ###################################################################
   #
   # set_Ram_PF_Max
   #
   ###################################################################
   proc set_Ram_PF_Max { Family
			Fifo_Implementation
			Read_Faster
			Input_Data_Width
			Input_Depth
			Output_Depth
			Performance_Options
                        Enable_ECC Output_Width {asym 0}} {

      set actual_wrdepth [get_Actual_Input_Fifo_Depth $Family $Fifo_Implementation $Performance_Options $Read_Faster $Input_Data_Width $Input_Depth $Output_Depth $Enable_ECC $Output_Width $asym]

     if { $Performance_Options == "Standard_FIFO" } {
      return [expr {$actual_wrdepth-2}] 
     } else {
       if {$Input_Depth < $Output_Depth} {
	 return [expr {$Input_Depth-3}]         
       } else {
	 return [expr {$Input_Depth-1}] 
       }
     }
   }

   ###################################################################
   #
   # set_Ram_PE_Max
   #
   ###################################################################
   proc set_Ram_PE_Max { Family
			Fifo_Implementation
			Read_Faster
			Input_Data_Width
			Input_Depth
         Output_Width
			Output_Depth
			Performance_Options
                        Enable_ECC {asym 0}} {

      set actual_rddepth [get_Actual_Output_Fifo_Depth $Family $Fifo_Implementation $Performance_Options $Read_Faster $Input_Data_Width $Input_Depth $Output_Width $Output_Depth $Enable_ECC $asym]

      return [expr {$actual_rddepth-3}]

   }

   ###################################################################
   #
   # set_Ram_PF_Min
   #
   ###################################################################
   proc set_Ram_PF_Min { Family
			Fifo_Implementation
			Input_Depth
			Output_Depth
			Performance_Options {asym 0} } {
      
     # If common clock not FWFT
     if { $Performance_Options == "Standard_FIFO" } {
       return [expr {int(3)}] 
     } else {
       # Common Clock FWFT
       if { ((($Family != "virtexu") || (!$asym && $Family == "virtexu")) && $Fifo_Implementation  == "Common_Clock_Block_RAM") \
	    || $Fifo_Implementation == "Common_Clock_Distributed_RAM" \
	    || $Fifo_Implementation == "Common_Clock_Shift_Register" } {       
         return [expr {int(5)}]          
       } else { 
         # Independent Clock FWFT
         if { $Output_Depth > $Input_Depth } {
           return [expr {int(3+1+7)}]           
         } else {
           # For Input_Depth >= Output_Depth
 	   set RATIO_W [expr {int( $Input_Depth / $Output_Depth )}]
	   return [expr {int(3+$RATIO_W*2+7)}]
         }
       }
     }
   }

   ###################################################################
   #
   # set_Ram_PE_Min
   #
   ###################################################################
   proc set_Ram_PE_Min { Family
 			Fifo_Implementation
			Performance_Options} {
      
     # If common clock block RAM based or not FWFT
     if { $Performance_Options == "Standard_FIFO" } {
       return [expr {int(2)}]
     } else {
       return [expr {int(4)}]
     }
   }

   ################################################################################ 
   # pf_assert_min
   #  Minimum value of range for programmable full constant assert threshold
   #  This function should just return 1 when the assert constant threshold value
   #  is not relevant.
   ################################################################################
   proc pf_assert_min { Family
			Fifo_Implementation
			Read_Faster
			Input_Data_Width
			Input_Depth
			Output_Depth
			Programmable_Full_Type
			Performance_Options
                        Enable_ECC 
			Write_Clock_Frequency Read_Clock_Frequency Output_Data_Width {asym 0} } {
      
      set actual_depth [get_Actual_Input_Fifo_Depth $Family $Fifo_Implementation $Performance_Options $Read_Faster $Input_Data_Width $Input_Depth $Output_Depth $Enable_ECC $Output_Data_Width $asym]
      set prim_depth [get_Primitive_Depth $Family $Input_Data_Width $Output_Data_Width $Input_Depth $Enable_ECC]
	  set num_prims_indepth [ expr (($Input_Depth-1)/$prim_depth)+1 ]
	#########################3  
	   if { $Read_Clock_Frequency == $Write_Clock_Frequency} {
	     set freq_ratio 1
	   } elseif {[ expr {$Write_Clock_Frequency % $Read_Clock_Frequency }] == 0} {
	     set freq_ratio [expr {int(4*$Write_Clock_Frequency/$Read_Clock_Frequency)}]
           } else {
	     set freq_ratio [expr {int(4*$Write_Clock_Frequency/$Read_Clock_Frequency) + 1}]
           }

            # SYNC FIFO
           if { $Fifo_Implementation == "Common_Clock_Builtin_FIFO" } {	
               set addend 2
           } else {
            # ASYNC FIFO
	     if {$freq_ratio == 1} {
	       if { $Performance_Options == "First_Word_Fall_Through" } {
                  set addend 8
	       } else {
                  set addend 7
	       }
	     } else {
	       set addend [expr {$freq_ratio+6}]
	     }
          }
		 ################### 
      if { ($Fifo_Implementation == "Common_Clock_Builtin_FIFO" 
	   ||  $Fifo_Implementation == "Independent_Clocks_Builtin_FIFO" ) && (($Family != "virtexu") || ($Family == "virtexu" && !$asym ))} {
		
			if { ($Family != "virtexu") } {
				if { $Fifo_Implementation == "Common_Clock_Builtin_FIFO" } {	
				   # SYNC FIFO
				   if { $Performance_Options == "First_Word_Fall_Through" } {
				  
				  return [expr {$actual_depth-$prim_depth} + $addend];
				   } else {
				  
				  return [expr {$actual_depth-$prim_depth} + $addend];
				   }
				} else {
				   # ASYNC FIFO
				   if { $Performance_Options == "First_Word_Fall_Through" } {
				  
				  return [expr {$actual_depth-$prim_depth} + $addend];
				   } else {
				  
				  return [expr {$actual_depth-$prim_depth} + $addend];
				   }
				}
			} else {
				return [expr {(($num_prims_indepth-1)*$prim_depth)} + $addend]
			}
      } else {

	 # RAM-based FIFO
         set pf_min [ set_Ram_PF_Min $Family $Fifo_Implementation $Input_Depth $Output_Depth $Performance_Options $asym]
	 
	  if {$Programmable_Full_Type == "Single_Programmable_Full_Threshold_Constant"} {
            return [expr {$pf_min}]; 
         
          } else {

            return [expr {$pf_min+1}]; 
	  }       

      }
      
      return [expr {int(1)}]

   } ;# end pf_assert_min

   ################################################################################ 
   # pf_assert_max
   #  Maximum value of range for programmable full constant assert threshold
   #  This function should just return DEPTH when the assert constant threshold value
   #  is not relevant.
   ################################################################################
   proc pf_assert_max { Family
			Fifo_Implementation
			Read_Faster
			Input_Data_Width
			Input_Depth
			Output_Depth
			Programmable_Full_Type
			Performance_Options
                        Enable_ECC
			Write_Clock_Frequency
			Read_Clock_Frequency Output_Data_Width {asym 0} } {		
      
      set actual_depth [get_Actual_Input_Fifo_Depth $Family $Fifo_Implementation $Performance_Options $Read_Faster $Input_Data_Width $Input_Depth $Output_Depth $Enable_ECC $Output_Data_Width $asym]
      set prim_depth [get_Primitive_Depth $Family $Input_Data_Width $Output_Data_Width $Input_Depth $Enable_ECC]
	  set num_prims_indepth [ expr (($Input_Depth-1)/$prim_depth)+1 ]

      set subtrahend 1
      set freq_ratio 1


	   if { $Read_Clock_Frequency == $Write_Clock_Frequency} {
	     set freq_ratio 1
	   } elseif {[ expr {$Write_Clock_Frequency % $Read_Clock_Frequency }] == 0} {
	     set freq_ratio [expr {int(4*$Write_Clock_Frequency/$Read_Clock_Frequency)}]
           } else {
	     set freq_ratio [expr {int(4*$Write_Clock_Frequency/$Read_Clock_Frequency) + 1}]
           }

            # SYNC FIFO
           if { $Fifo_Implementation == "Common_Clock_Builtin_FIFO" } {	
               set subtrahend 2
           } else {
            # ASYNC FIFO
	     if {$freq_ratio == 1} {
	       if { $Performance_Options == "First_Word_Fall_Through" } {
                  set subtrahend 8
	       } else {
                  set subtrahend 7
	       }
	     } else {
	       set subtrahend [expr {$freq_ratio+6}]
	     }
          }

      if { ($Fifo_Implementation == "Common_Clock_Builtin_FIFO" 
	   || $Fifo_Implementation == "Independent_Clocks_Builtin_FIFO" ) && (($Family != "virtexu" ) || ($Family == "virtexu" && !$asym ))} {
			if {($Family != "virtexu" ) } {
				return [expr {$actual_depth-$subtrahend}];
			} else {
				return [expr {(($num_prims_indepth)*$prim_depth) - $num_prims_indepth }]
			}
      } else {
        # RAM based FIFO
         set pf_max [ set_Ram_PF_Max $Family $Fifo_Implementation $Read_Faster $Input_Data_Width $Input_Depth $Output_Depth $Performance_Options $Enable_ECC $Output_Data_Width $asym]
	  return [expr {$pf_max}];          
      }
      
      return [expr {int(1)}]
      
   } ;# end pf_assert_max


   ################################################################################ 
   # pf_negate_min
   #  Minimum value of range for programmable full constant negate threshold.
   #  This value is only relevant when we have multiple threshold constants.
   #  This function should just return 1 when the negate constant threshold value
   #  is not relevant.
   ################################################################################
   proc pf_negate_min { Family
			Fifo_Implementation
			Read_Faster
			Input_Data_Width
			Input_Depth
			Output_Depth
			Programmable_Full_Type
			Performance_Options
         Enable_ECC Output_Data_Width {asym 0}} {

      set actual_depth [get_Actual_Input_Fifo_Depth $Family $Fifo_Implementation $Performance_Options $Read_Faster $Input_Data_Width $Input_Depth $Output_Depth $Enable_ECC $Output_Data_Width $asym]
      set prim_depth [get_Primitive_Depth $Family $Input_Data_Width $Output_Data_Width $Input_Depth $Enable_ECC]


       if { ( $Fifo_Implementation == "Common_Clock_Builtin_FIFO" 
 	   ||  $Fifo_Implementation == "Independent_Clocks_Builtin_FIFO" ) && (($Family != "virtexu" ) || ($Family == "virtexu" && !$asym )) } {
          # For BuiltIn Configuration, there is no negate value.  In this case, set negate value pf_assert_min-1
             if { $Fifo_Implementation == "Common_Clock_Builtin_FIFO" } {	
                # SYNC FIFO 36
                if { $Performance_Options == "First_Word_Fall_Through" } {
              
              return [expr {$actual_depth-$prim_depth+2-1}];
                } else {
              
              return [expr {$actual_depth-$prim_depth+2-1}];
                }
             } else {
                # ASYNC FIFO36
                if { $Performance_Options == "First_Word_Fall_Through" } {
              
              return [expr {$actual_depth-$prim_depth+5-1}];
                } else {
              
              return [expr {$actual_depth-$prim_depth+5-1}];
                }
             }
 		 
       } else {
 	 
 	      # RAM-based FIFO
         set pf_min [ set_Ram_PF_Min $Family $Fifo_Implementation $Input_Depth $Output_Depth $Performance_Options $asym]
         if { $Programmable_Full_Type == "Single_Programmable_Full_Threshold_Constant" 
           || $Programmable_Full_Type == "Single_Programmable_Full_Threshold_Input_Port" } {
	         return [expr { $pf_min - 1}]
         } else {
            return $pf_min
         }
 
       }     
      
      return [expr {int(1)}]

   } ;# end pf_negate_min

   ################################################################################ 
   # pf_negate_max
   #  Maximum value of range for programmable full constant negate threshold.
   #  This value is only relevant when we have multiple threshold constants.
   #  This function should just return INPUT_DEPTH when the negate constant threshold value
   #  is not relevant.
   ################################################################################
   proc pf_negate_max { Input_Depth
			Programmable_Full_Type
			Full_Threshold_Assert_Value} {

      return [expr {int( $Full_Threshold_Assert_Value - 1 )}]
      
   } ;# end pf_negate_max

   ################################################################################ 
   # pe_assert_min
   #  Minimum value of range for programmable empty constant assert threshold
   #  This function should just return 1 when the assert constant threshold value
   #  is not relevant.
   ################################################################################
   proc pe_assert_min { Family
			Fifo_Implementation
			Read_Faster
			Input_Data_Width
			Input_Depth
			Output_Depth
			Programmable_Empty_Type
			Performance_Options
                        Enable_ECC
                        Frequency_Info Output_Data_Width {asym 0}} {		

      set actual_depth [get_Actual_Input_Fifo_Depth $Family $Fifo_Implementation $Performance_Options $Read_Faster $Input_Data_Width $Input_Depth $Output_Depth $Enable_ECC $Output_Data_Width $asym]
	  
      set prim_depth [get_Primitive_Depth $Family $Input_Data_Width $Output_Data_Width $Input_Depth $Enable_ECC]


      if { ($Fifo_Implementation == "Common_Clock_Builtin_FIFO" 
	   || $Fifo_Implementation == "Independent_Clocks_Builtin_FIFO" ) && (($Family != "virtexu" ) || ($Family == "virtexu" && !$asym )) } {
	    if { $Fifo_Implementation == "Common_Clock_Builtin_FIFO" } {	
	       # SYNC FIFO36/FIFO36E1
               set pe_min [ set_Ram_PE_Min $Family $Fifo_Implementation $Performance_Options]
	       return $pe_min; 	 
	    } else {
	       # ASYNC FIFO36/FIFO36E1
	       if { $Performance_Options == "First_Word_Fall_Through" } {
               # If rdclk >= wrclk, then it should use the min value specified in V5 user guide v4.6,
               # otherwise, it should use the formula specified in the same user guide (UG190).
		    return 6;
	       } else {
		  return 5;
	       }
	    }
	 
      } else {
        # RAM based FIFO
         set pe_min [ set_Ram_PE_Min $Family $Fifo_Implementation $Performance_Options]
	 return $pe_min; 	 

      }
      
   } ;# end pe_assert_min

   ################################################################################ 
   # pe_assert_max
   #  Maximum value of range for programmable empty constant assert threshold
   #  This function should just return OUTPUT_DEPTH when the assert constant threshold value
   #  is not relevant.
   ################################################################################
   proc pe_assert_max { Family
			Fifo_Implementation
			Read_Faster
			Input_Data_Width
			Input_Depth
			Output_Width
			Output_Depth
			Programmable_Empty_Type
			Performance_Options
                        Enable_ECC
		        Get_Frequency_info {asym 0}} {

      set actual_depth [get_Actual_Input_Fifo_Depth $Family $Fifo_Implementation $Performance_Options $Read_Faster $Input_Data_Width $Input_Depth $Output_Depth $Enable_ECC $Output_Width $asym]
	  if {!$asym} {
      set prim_depth [get_Primitive_Depth $Family $Input_Data_Width $Output_Width $Input_Depth $Enable_ECC]
	  } else { 
	  set prim_depth [get_Primitive_Depth $Family $Input_Data_Width $Output_Width $Output_Depth $Enable_ECC]
	  }


      set subtrahend [expr {int(3*$Get_Frequency_info)+3}]
      
      if { $Fifo_Implementation == "Common_Clock_Builtin_FIFO" 
	   || $Fifo_Implementation == "Independent_Clocks_Builtin_FIFO" } {
	 
             if { $Fifo_Implementation == "Common_Clock_Builtin_FIFO" } {	
                   return [expr {$prim_depth-2}];
             } else {
                # ASYNC FIFO36
	 	 return [expr {$prim_depth-6}];
             }
	 
      } else {

	      # RAM-based FIFO
         set pe_max [ set_Ram_PE_Max $Family $Fifo_Implementation $Read_Faster $Input_Data_Width $Input_Depth $Output_Width $Output_Depth $Performance_Options $Enable_ECC $asym]

         if { $Programmable_Empty_Type == "Single_Programmable_Empty_Threshold_Constant" ||
                  $Programmable_Empty_Type == "Single_Programmable_Empty_Threshold_Input_Port" } {
            return [expr {$pe_max}]; 
         } else {
            return [expr {$pe_max-1}];           
         }
      }
      
      
   } ;# end pe_assert_max

   ################################################################################ 
   # pe_negate_min
   #  Minimum value of range for programmable empty constant negate threshold
   #  This value is only relevant when we have multiple threshold constants.
   #  This function should just return 1 when the negate constant threshold value
   #  is not relevant.
   ################################################################################
   proc pe_negate_min { Programmable_Empty_Type
			Empty_Threshold_Assert_Value} {		

      return [expr {int( $Empty_Threshold_Assert_Value + 1 )}]
      

   } ;# end pe_negate_min

   ################################################################################ 
   # pe_negate_max
   #  Maximum value of range for programmable empty constant negate threshold
   #  This value is only relevant when we have multiple threshold constants.
   #  This function should just return OUTPUT_DEPTH when the negate constant threshold value
   #  is not relevant.
   ################################################################################
   proc pe_negate_max { Family
			Fifo_Implementation
			Read_Faster
			Input_Data_Width
			Input_Depth
			Output_Width
			Output_Depth
			Programmable_Empty_Type
			Performance_Options
                        Enable_ECC {asym 0}} {

      set actual_depth [get_Actual_Input_Fifo_Depth $Family $Fifo_Implementation $Performance_Options $Read_Faster $Input_Data_Width $Input_Depth $Output_Depth $Enable_ECC $Output_Width $asym]
      set prim_depth [get_Primitive_Depth $Family $Input_Data_Width $Output_Width $Input_Depth $Enable_ECC]
   if {!$asym} {
      set prim_depth [get_Primitive_Depth $Family $Input_Data_Width $Output_Width $Input_Depth $Enable_ECC]
	  } else { 
	  set prim_depth [get_Primitive_Depth $Family $Input_Data_Width $Output_Width $Output_Depth $Enable_ECC]
	  }

      if { $Fifo_Implementation == "Common_Clock_Builtin_FIFO" 
	   || $Fifo_Implementation == "Independent_Clocks_Builtin_FIFO" } {
          # For BuiltIn FIFO, there is no negate value, hence return pe_assert_max-1
             if { $Fifo_Implementation == "Common_Clock_Builtin_FIFO" } {	
                # SYNC FIFO 36
                if { $Performance_Options == "First_Word_Fall_Through" } {
              
              return [expr {$prim_depth-1+1}];
                } else {
              
              return [expr {$prim_depth-2+1}];
                }
             } else {
                # ASYNC FIFO36
                if { $Performance_Options == "First_Word_Fall_Through" } {
              
              return [expr {$prim_depth-4+1}];
                } else {
              
              return [expr {$prim_depth-5+1}];
                }
             }
	 
      } else {

	      # RAM-based FIFO
         set pe_max [ set_Ram_PE_Max $Family $Fifo_Implementation $Read_Faster $Input_Data_Width $Input_Depth $Output_Width $Output_Depth $Performance_Options $Enable_ECC $asym]
         if { $Programmable_Empty_Type == "Single_Programmable_Empty_Threshold_Constant" 
           || $Programmable_Empty_Type == "Single_Programmable_Empty_Threshold_Input_Port" } {
	         return [expr { $pe_max + 1}]; 
         } else {
            return $pe_max;  
         }
      }

      
   } ;# end pe_negate_max
   

   ###################################################################
   #
   # get_Actual_Input_Fifo_Depth
   #
   ###################################################################
   proc get_Actual_Input_Fifo_Depth {  Family
				       Fifo_Implementation
				       Performance_Options
				       Read_Faster
				       Input_Width
				       Input_Depth
				       Output_Depth
                                       Enable_ECC Output_Width {asym 0}} {		
      
      set prim_depth [get_Primitive_Depth $Family $Input_Width $Output_Width $Input_Depth $Enable_ECC]

      set num_prims_indepth [ expr (($Input_Depth-1)/$prim_depth)+1 ]

      if { $Fifo_Implementation  == "Common_Clock_Builtin_FIFO" } {

	    if { $Performance_Options == "First_Word_Fall_Through" } {
               if { $Family == "virtexu" } {

                 # First, calculate the ratios RATIO_W and RATIO_R
                 if { $Output_Depth > $Input_Depth } {
                    set RATIO_R [expr {int( $Output_Depth / $Input_Depth )}]
                 } else {
                    set RATIO_R 1
                 }
                 if { $Input_Depth > $Output_Depth } {
                    set RATIO_W [expr {int( $Input_Depth / $Output_Depth )}]
                 } else {
                    set RATIO_W 1
                 }
             
                 #Actual Write Depth calculation:
                 # Memory depth is Input_Depth-1
                 # Output register stages add 2 stages, in the WR_CLK domain,
                 # each one is 2*RATIO_W/RATIO_R words
                 return [expr {($Input_Depth-1) + (2 * $RATIO_W / $RATIO_R)}];
               } else {
	         return [ expr ($prim_depth+1)*($num_prims_indepth) ]
               }
	    } else {
	       return [ expr ($prim_depth+1)*($num_prims_indepth-1)+$prim_depth ]
	    }

      } elseif {$Fifo_Implementation  == "Independent_Clocks_Builtin_FIFO" } {
	 
	    if { $Performance_Options == "First_Word_Fall_Through" } {
               if { $Family == "virtexu" } {

                 # First, calculate the ratios RATIO_W and RATIO_R
                 if { $Output_Depth > $Input_Depth } {
                    set RATIO_R [expr {int( $Output_Depth / $Input_Depth )}]
                 } else {
                    set RATIO_R 1
                 }
                 if { $Input_Depth > $Output_Depth } {
                    set RATIO_W [expr {int( $Input_Depth / $Output_Depth )}]
                 } else {
                    set RATIO_W 1
                 }
             
                 #Actual Write Depth calculation:
                 # Memory depth is Input_Depth-1
                 # Output register stages add 2 stages, in the WR_CLK domain,
                 # each one is 2*RATIO_W/RATIO_R words
                 return [expr {($Input_Depth-1) + (2 * $RATIO_W / $RATIO_R)}];
               } else {
	  	 return [ expr ($prim_depth+1)*($num_prims_indepth) ]
               }
	    
	    } else {
				return [ expr ($prim_depth+1)*($num_prims_indepth-1)+$prim_depth ]
	    }

      } else {
         ##########################################################
         # Non Built-In FIFO base FIFOs
         ##########################################################
 
	 if {  $Fifo_Implementation == "Common_Clock_Distributed_RAM" \
	      || $Fifo_Implementation == "Common_Clock_Shift_Register" || ((($Family != "virtexu") || (!$asym && $Family == "virtexu")) && $Fifo_Implementation == "Common_Clock_Block_RAM") } {

           if  { $Performance_Options == "First_Word_Fall_Through" } {
               if { $Family == "virtexu" } {

                 # First, calculate the ratios RATIO_W and RATIO_R
                 if { $Output_Depth > $Input_Depth } {
                    set RATIO_R [expr {int( $Output_Depth / $Input_Depth )}]
                 } else {
                    set RATIO_R 1
                 }
                 if { $Input_Depth > $Output_Depth } {
                    set RATIO_W [expr {int( $Input_Depth / $Output_Depth )}]
                 } else {
                    set RATIO_W 1
                 }
             
                 #Actual Write Depth calculation:
                 # Memory depth is Input_Depth-1
                 # Output register stages add 2 stages, in the WR_CLK domain,
                 # each one is 2*RATIO_W/RATIO_R words
                 return [expr {($Input_Depth) + (2 * $RATIO_W / $RATIO_R)}];
               } else {
	         return [expr {$Input_Depth+2}]
               }
           } else {	    
	     return $Input_Depth
           }
	    
	 } elseif { $Performance_Options == "First_Word_Fall_Through" } {

	    # First, calculate the ratios RATIO_W and RATIO_R
	    if { $Output_Depth > $Input_Depth } {
	       set RATIO_R [expr {int( $Output_Depth / $Input_Depth )}]
	    } else {
	       set RATIO_R 1
	    }
	    if { $Input_Depth > $Output_Depth } {
	       set RATIO_W [expr {int( $Input_Depth / $Output_Depth )}]
	    } else {
	       set RATIO_W 1
	    }

	    #Actual Write Depth calculation:
	    # Memory depth is Input_Depth-1
	    # Output register stages add 2 stages, in the WR_CLK domain,
	    # each one is 2*RATIO_W/RATIO_R words
	    return [expr {($Input_Depth-1) + (2 * $RATIO_W / $RATIO_R)}];

	 } else {
	    return [expr {$Input_Depth-1}]
	 }
      }  
      
   }
   
   ###################################################################
   #
   # get_Actual_Output_Fifo_Depth
   #
   ###################################################################
   proc get_Actual_Output_Fifo_Depth { Family
				       Fifo_Implementation
				       Performance_Options
				       Read_Faster
				       Input_Width
				       Input_Depth
				       Output_Width
				       Output_Depth
                   Enable_ECC {asym 0}} {

    # First, calculate the ratios RATIO_W and RATIO_R
    if { $Output_Depth > $Input_Depth } {
       set RATIO_R [expr {int( $Output_Depth / $Input_Depth )}]
    } else {
       set RATIO_R 1
    }
    if { $Input_Depth > $Output_Depth } {
       set RATIO_W [expr {int( $Input_Depth / $Output_Depth )}]
    } else {
       set RATIO_W 1
    }
     set Actual_Input_Depth [ get_Actual_Input_Fifo_Depth $Family $Fifo_Implementation $Performance_Options $Read_Faster $Input_Width $Input_Depth $Output_Depth $Enable_ECC $Output_Width $asym]
   # Only need Output Depth, FWFT, ECC 
   if {(( $Fifo_Implementation  == "Common_Clock_Builtin_FIFO" ) || ( $Fifo_Implementation  == "Independent_Clocks_Builtin_FIFO")) && ($Input_Depth == $Output_Depth)} {
     # Built-In FIFO
     return [ get_Actual_Input_Fifo_Depth $Family $Fifo_Implementation $Performance_Options $Read_Faster $Input_Width $Input_Depth $Output_Depth $Enable_ECC $Output_Width $asym]
   } else {
     # Sync FIFO
     if {  ($Fifo_Implementation == "Common_Clock_Block_RAM" && (($Family != "virtexu") || ($Family == "virtexu" && !$asym))) || $Fifo_Implementation == "Common_Clock_Distributed_RAM" || $Fifo_Implementation == "Common_Clock_Shift_Register" } {
       if  { $Performance_Options == "First_Word_Fall_Through" } {
          return [expr {$Output_Depth+2}]
       } else {
          return $Output_Depth
       }
     } elseif { $Performance_Options == "First_Word_Fall_Through" } {
        # Async FIFO and FWFT
        if {$Input_Depth < $Output_Depth} {
           ### Actual output depth increases by the product of read ratio by actual input depth
           ### if the input depth is 16 and the output depth is 128, then the actual input depth
           ### is 15 and the actual output depth is 130
           return [expr {($Actual_Input_Depth * $RATIO_R)}];
        } elseif {$Input_Depth > $Output_Depth} {
           return [expr {($Actual_Input_Depth / $RATIO_W)}];
        } else {
            return [expr {$Output_Depth+1}]
        }
     } else {
        # Async FIFO and NO FWFT
        if {$Input_Depth != $Output_Depth} {
           return [expr {($Output_Depth -$RATIO_R)}];
        } else {
           return [expr {$Output_Depth-1}]    
        }
     }
   }

   }

   ###################################################################
   #
   # Get Primitive Depth procedure
   #
   ###################################################################
   proc get_Primitive_Depth { Family width read_width depth use_ecc} {
      
      switch [get_Prim_Fifo_Type $Family $width $read_width $depth $use_ecc] {
         4kx4   { set prim_depth [ expr 4096 ]}
	 2kx9   { set prim_depth [ expr 2048 ]}
	 1kx18  { set prim_depth [ expr 1024 ]}
	 512x36 { set prim_depth [ expr 512  ]}
	 8kx4   { set prim_depth [ expr 8192 ]}
	 4kx9   { set prim_depth [ expr 4096 ]}
	 2kx18  { set prim_depth [ expr 2048 ]}
	 1kx36  { set prim_depth [ expr 1024 ]}
	 512x72 { set prim_depth [ expr 512  ]}
      }

      return $prim_depth

   }

   ###################################################################
   #
   # Estimated FIFO Usage procedure
   #
   ###################################################################
   proc get_Estimated_FIFO_Usage {Family width read_width 
				   depth
                                   use_ecc} {
      
      set 4kx4_used   [ expr {(($width-1)/4 +1)*(($depth-1)/4096 +1)}]
      set 2kx9_used   [ expr {(($width-1)/9 +1)*(($depth-1)/2048 +1)}]
      set 1kx18_used  [ expr {(($width-1)/18+1)*(($depth-1)/1024 +1)}]
      set 512x36_used [ expr {(($width-1)/36+1)*(($depth-1)/512  +1)}]
      
      set 8kx4_used   [ expr {(($width-1)/4 +1)*(($depth-1)/8192 +1)}]
      set 4kx9_used   [ expr {(($width-1)/9 +1)*(($depth-1)/4096 +1)}]
      set 2kx18_used  [ expr {(($width-1)/18+1)*(($depth-1)/2048 +1)}]
      set 1kx36_used  [ expr {(($width-1)/36+1)*(($depth-1)/1024 +1)}]
      if ($use_ecc) {            
        # ECC primitive width is 64
        set 512x72_used [ expr {(($width-1)/64+1)*(($depth-1)/512  +1)}]
      } else {
        set 512x72_used [ expr {(($width-1)/72+1)*(($depth-1)/512  +1)}]
      }      

      set min_type [get_Prim_Fifo_Type $Family $width $read_width $depth $use_ecc]
      switch $min_type {
         4kx4   { set min_used $4kx4_used   }
	 2kx9   { set min_used $2kx9_used   }
	 1kx18  { set min_used $1kx18_used  }
	 512x36 { set min_used $512x36_used }
	 8kx4   { set min_used $8kx4_used   }
	 4kx9   { set min_used $4kx9_used   }
	 2kx18  { set min_used $2kx18_used  }
	 1kx36  { set min_used $1kx36_used  }
	 512x72 { set min_used $512x72_used }
      }
      
      return "$min_used of type: $min_type"
   }
  
   ###################################################################
   #
   # Estimated FIFO Chained in depth  procedure
   #
   ###################################################################
   proc get_Estimated_FIFO_InDepth { Family width read_width 
				     depth
                                     use_ecc} {
      
      set prim_depth [get_Primitive_Depth $Family $width $read_width $depth $use_ecc]
      set temp [expr {int($depth/$prim_depth)}]
      if { ($depth > ($temp*$prim_depth))} {
	return [expr {$depth/$prim_depth + 1}]
      } else {
	return [expr {$depth/$prim_depth}]
      }

     ## If the above function doesn't work (some error), comment code above
     ## uncomment code below
     ##   return [expr {int(1)}]

   }

   #############################################################
   #
   # Get the Primitive fifo type
   # Description: Algorithm for Built-In FIFO implementation
   # to determine which primitive is most optimal to use 
   #
   #############################################################

   proc get_Prim_Fifo_Type_old { width
			     depth
                             use_ecc } {
      
      set 4kx4_used   [ expr {(($width-1)/4 +1)*(($depth-1)/4096 +1)}]
      set 2kx9_used   [ expr {(($width-1)/9 +1)*(($depth-1)/2048 +1)}]
      set 1kx18_used  [ expr {(($width-1)/18+1)*(($depth-1)/1024 +1)}]
      set 512x36_used [ expr {(($width-1)/36+1)*(($depth-1)/512  +1)}]
      
      set 8kx4_used   [ expr {(($width-1)/4 +1)*(($depth-1)/8192 +1)}]
      set 4kx9_used   [ expr {(($width-1)/9 +1)*(($depth-1)/4096 +1)}]
      set 2kx18_used  [ expr {(($width-1)/18+1)*(($depth-1)/2048 +1)}]
      set 1kx36_used  [ expr {(($width-1)/36+1)*(($depth-1)/1024 +1)}]
      set 512x72_used [ expr {(($width-1)/72+1)*(($depth-1)/512  +1)}]
      
      set min_used $4kx4_used
      set min_type "4kx4"
      
      if (!$use_ecc) {      

        ##########################################################
        # Rules: Primitive used should
        # - generate correct full flags if depth >= 512
        # - use min number of primitives
        # - use primitive that reduces latency when possible
        # This creates 3 cases:
        # 1) depth <= 512
        # 2) depth = 1k 
        # 3) depth = 2k 
        # 4) depth >= 4k
        ##########################################################
        if {$depth <= 512} {

	  set min_used $512x36_used;
	  set min_type "512x36"     
          # Below code irrelevant because of statement above.     
          ##if {$min_used > $512x36_used} {
	  ##  set min_used $512x36_used;
	  ##  set min_type "512x36"
          ##}

          if {$min_used > $512x72_used} {
	    set min_used $512x72_used;
	    set min_type "512x72"
          }
      
        } elseif {$depth == 1024} {

	  set min_used $1kx18_used;
	  set min_type "1kx18"
          # Below code irrelevant because of statement above.     
          ##if {$min_used > $1kx18_used} {
	  ##  set min_used $1kx18_used;
	  ##  set min_type "1kx18"
          ##}

          if {$min_used > $512x36_used} {
	    set min_used $512x36_used;
	    set min_type "512x36"
          }
          if {$min_used > $1kx36_used} {
	    set min_used $1kx36_used;
	    set min_type "1kx36"
          }
          if {$min_used > $512x72_used} {
	    set min_used $512x72_used;
	    set min_type "512x72"
          }

        } elseif {$depth == 2048} {

	  set min_used $2kx9_used;
	  set min_type "2kx9"
          # Below code irrelevant because of statement above.     
          ##if {$min_used > $2kx9_used} {
	  ##  set min_used $2kx9_used;
	  ##  set min_type "2kx9"
          ##}

          if {$min_used > $1kx18_used} {
	    set min_used $1kx18_used;
	    set min_type "1kx18"
          }
          if {$min_used > $512x36_used} {
	  set min_used $512x36_used;
	  set min_type "512x36"
          }
          if {$min_used > $2kx18_used} {
	    set min_used $2kx18_used;
	    set min_type "2kx18"
          }
          if {$min_used > $1kx36_used} {
	    set min_used $1kx36_used;
	    set min_type "1kx36"
          }
          if {$min_used > $512x72_used} {
	    set min_used $512x72_used;
	    set min_type "512x72"
          }

        } else { 

	  set min_used $4kx4_used;
	  set min_type "4kx4"
          # Below code irrelevant because of statement above.     
          ##if {$min_used > $4kx4_used} {
	  ##  set min_used $4kx4_used;
	  ##  set min_type "4kx4"
          ##}

          if {$min_used > $2kx9_used} {
	    set min_used $2kx9_used;
	    set min_type "2kx9"
          }
          if {$min_used > $1kx18_used} {
	    set min_used $1kx18_used;
	    set min_type "1kx18"
          }
          if {$min_used > $512x36_used} {
	    set min_used $512x36_used;
	    set min_type "512x36"
          }
          if {$min_used > $8kx4_used} {
	    set min_used $8kx4_used;
	    set min_type "8kx4"
          }
          if {$min_used > $4kx9_used} {
	    set min_used $4kx9_used;
	    set min_type "4kx9"
          }
          if {$min_used > $2kx18_used} {
	    set min_used $2kx18_used;
	    set min_type "2kx18"
          }
          if {$min_used > $1kx36_used} {
	    set min_used $1kx36_used;
	    set min_type "1kx36"
          }
          if {$min_used > $512x72_used} {
	    set min_used $512x72_used;
	    set min_type "512x72"
          }
        }
     } else {
       
       ### if ecc is used, always use the 512x72 primitive
       set min_used $512x72_used;
       set min_type "512x72"
  
     }
       
      return $min_type
   }

   #############################################################
   #
   # Get the Primitive fifo type updated to include 8 Series
   # Description: Algorithm for Built-In FIFO implementation
   # to determine which primitive is most optimal to use 
   #
   #############################################################
  proc get_Prim_Fifo_Type {Family width read_width 
			     depth
                             use_ecc } {
      
      set 4kx4_used   [ expr {(($width-1)/4 +1)*(($depth-1)/4096 +1)}]
      set 2kx9_used   [ expr {(($width-1)/9 +1)*(($depth-1)/2048 +1)}]
      set 1kx18_used  [ expr {(($width-1)/18+1)*(($depth-1)/1024 +1)}]
      set 512x36_used [ expr {(($width-1)/36+1)*(($depth-1)/512  +1)}]
      
      set 8kx4_used   [ expr {(($width-1)/4 +1)*(($depth-1)/8192 +1)}]
      set 4kx9_used   [ expr {(($width-1)/9 +1)*(($depth-1)/4096 +1)}]
      set 2kx18_used  [ expr {(($width-1)/18+1)*(($depth-1)/2048 +1)}]
      set 1kx36_used  [ expr {(($width-1)/36+1)*(($depth-1)/1024 +1)}]
      set 512x72_used [ expr {(($width-1)/72+1)*(($depth-1)/512  +1)}]
      
      set min_used $4kx4_used
      set min_type "4kx4"
     if {($Family == "virtexu") && ($width != $read_width)}  { 
      if (!$use_ecc) {      

        ##########################################################
        # single primitive needs to be used. So restricting the 
        # primitive used based on depth.
        ##########################################################
        if {$depth <= 512} {

	  set min_used $512x36_used;
	  set min_type "512x36"     
          if {$min_used > $512x72_used} {
	    set min_used $512x72_used;
	    set min_type "512x72"
          }
      
        } elseif {$depth == 1024} {

	  set min_used $1kx18_used;
	  set min_type "1kx18"
          if {$min_used > $1kx36_used} {
	    set min_used $1kx36_used;
	    set min_type "1kx36"
          }

        } elseif {$depth == 2048} {

	  set min_used $2kx9_used;
	  set min_type "2kx9"
          if {$min_used > $2kx18_used} {
	    set min_used $2kx18_used;
	    set min_type "2kx18"
          }

        } elseif {$depth == 4096} { 

	  set min_used $4kx4_used;
	  set min_type "4kx4"
          if {$min_used > $4kx9_used} {
	    set min_used $4kx9_used;
	    set min_type "4kx9"
          }
        } else {

          set min_used $8kx4_used;
	  set min_type "8kx4"
          }
     } else {
       
       ### if ecc is used, always use the 512x72 primitive
       set min_used $512x72_used;
       set min_type "512x72"
  
     }
   } else {
      if (!$use_ecc) {      

        ##########################################################
        # Rules: Primitive used should
        # - generate correct full flags if depth >= 512
        # - use min number of primitives
        # - use primitive that reduces latency when possible
        # This creates 3 cases:
        # 1) depth <= 512
        # 2) depth = 1k 
        # 3) depth = 2k 
        # 4) depth >= 4k
        ##########################################################
        if {$depth <= 512} {

	  set min_used $512x36_used;
	  set min_type "512x36"     
          # Below code irrelevant because of statement above.     
          ##if {$min_used > $512x36_used} {
	  ##  set min_used $512x36_used;
	  ##  set min_type "512x36"
          ##}

          if {$min_used > $512x72_used} {
	    set min_used $512x72_used;
	    set min_type "512x72"
          }
      
        } elseif {$depth == 1024} {

	  set min_used $1kx18_used;
	  set min_type "1kx18"
          # Below code irrelevant because of statement above.     
          ##if {$min_used > $1kx18_used} {
	  ##  set min_used $1kx18_used;
	  ##  set min_type "1kx18"
          ##}

          if {$min_used > $512x36_used} {
	    set min_used $512x36_used;
	    set min_type "512x36"
          }
          if {$min_used > $1kx36_used} {
	    set min_used $1kx36_used;
	    set min_type "1kx36"
          }
          if {$min_used > $512x72_used} {
	    set min_used $512x72_used;
	    set min_type "512x72"
          }

        } elseif {$depth == 2048} {

	  set min_used $2kx9_used;
	  set min_type "2kx9"
          # Below code irrelevant because of statement above.     
          ##if {$min_used > $2kx9_used} {
	  ##  set min_used $2kx9_used;
	  ##  set min_type "2kx9"
          ##}

          if {$min_used > $1kx18_used} {
	    set min_used $1kx18_used;
	    set min_type "1kx18"
          }
          if {$min_used > $512x36_used} {
	  set min_used $512x36_used;
	  set min_type "512x36"
          }
          if {$min_used > $2kx18_used} {
	    set min_used $2kx18_used;
	    set min_type "2kx18"
          }
          if {$min_used > $1kx36_used} {
	    set min_used $1kx36_used;
	    set min_type "1kx36"
          }
          if {$min_used > $512x72_used} {
	    set min_used $512x72_used;
	    set min_type "512x72"
          }

        } else { 

	  set min_used $4kx4_used;
	  set min_type "4kx4"
          # Below code irrelevant because of statement above.     
          ##if {$min_used > $4kx4_used} {
	  ##  set min_used $4kx4_used;
	  ##  set min_type "4kx4"
          ##}

          if {$min_used > $2kx9_used} {
	    set min_used $2kx9_used;
	    set min_type "2kx9"
          }
          if {$min_used > $1kx18_used} {
	    set min_used $1kx18_used;
	    set min_type "1kx18"
          }
          if {$min_used > $512x36_used} {
	    set min_used $512x36_used;
	    set min_type "512x36"
          }
          if {$min_used > $8kx4_used} {
	    set min_used $8kx4_used;
	    set min_type "8kx4"
          }
          if {$min_used > $4kx9_used} {
	    set min_used $4kx9_used;
	    set min_type "4kx9"
          }

          if {$min_used > $2kx18_used} {
	    set min_used $2kx18_used;
	    set min_type "2kx18"
          }
          if {$min_used > $1kx36_used} {
	    set min_used $1kx36_used;
	    set min_type "1kx36"
          }
          if {$min_used > $512x72_used} {
	    set min_used $512x72_used;
	    set min_type "512x72"
          }
        }
     } else {
       
       ### if ecc is used, always use the 512x72 primitive
       set min_used $512x72_used;
       set min_type "512x72"
  
     }
    }
        return $min_type
   }
 
 


   ###################################################################
   #
   # Delay between read enable and a valid output of the core  procedure
   #
   ###################################################################
   proc get_Read_Latency { Family
                           Fifo_Implementation
                           Performance_Options
                           Use_Embedded_Registers
                         } {
     if { $Family == "virtexu" && ($Fifo_Implementation  == "Independent_Clocks_Builtin_FIFO" || $Fifo_Implementation  == "Common_Clock_Builtin_FIFO") } {
        if { $Performance_Options == "First_Word_Fall_Through" } {
             return [expr {int(0)}]      
           } else {       
             return [expr {int(1)}]
           }
     } else {

         if { $Performance_Options == "First_Word_Fall_Through" } {
            if { $Use_Embedded_Registers &&
                 $Fifo_Implementation  == "Common_Clock_Builtin_FIFO" 
               } {	
              return [expr {int(1)}]      
            } else {       
              return [expr {int(0)}]
            }
         } else {
           if { $Use_Embedded_Registers &&
                ($Fifo_Implementation      == "Common_Clock_Block_RAM" \
                  || $Fifo_Implementation  == "Independent_Clocks_Block_RAM" \
                  || $Fifo_Implementation  == "Common_Clock_Builtin_FIFO") 
               } {	
             return [expr {int(2)}]      
           } else {
             return [expr {int(1)}]
           }
    
         }
     }
    
     ## If the above function doesn't work (some error), comment code above
     ## uncomment code below
     ##   return [expr {int(1)}]

   }

   proc get_Estimated_BlockRAM_Usage_x { Family 
				       Is_Common_clk
				       Input_Width
				       Input_Depth
				       Output_Width
				       Output_Depth
                                       Ecc
                                       Size} {

      # Always set to 4 for 7-series and above architectures
      set tmp_family 4

      # 2 (NO_CHANGE) for V5 ECC, else 1 (READ_FIRST)
      set Write_Mode 1

      # 1 if ECC is selected, else 0
      set Ecc_Bit   [expr {$Ecc?1:0}]

      # 0 (fixed primitive) if ECC is selected, else 1 (minimum area)
      set algo_type [expr {$Ecc?0:1}]

      set prim_type [expr {$Ecc?6:1}]


      ### c_max_prims \
      ### c_algorithm \
      ### c_prim_type \
      ### c_xdevicefamily \
      ### c_mem_type \
      ### c_use_byte_wea \
      ### c_use_byte_web \
      ### c_byte_size \
      ### write_width_a \
      ### write_width_b \
      ### read_width_a \
      ### read_width_b \
      ### write_depth_a \
      ### write_depth_b \
      ### read_depth_a \
      ### read_depth_b \
      ### write_mode_a \
      ### write_mode_b \
      ### use_ecc \
      ### use_common_clk

      #Use BMG estimator function
      set rams_used [ GetPlacementAlgoNumPrims_$Size \
                          3000 \
                          $algo_type \
                          $prim_type \
                          $tmp_family \
                          1 \
                          0 \
                          0 \
                          8 \
                          $Input_Width \
                          $Output_Width \
                          $Input_Width \
                          $Output_Width \
                          $Input_Depth \
                          $Output_Depth \
                          $Input_Depth \
                          $Output_Depth \
                          $Write_Mode \
                          $Write_Mode \
                          $Ecc_Bit \
                          $Is_Common_clk ]
      return $rams_used
      

   }


}

