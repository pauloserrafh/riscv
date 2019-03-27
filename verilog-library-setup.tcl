#DO NOT USE WITH MODELSIM-ALTERA VERSION                                                                
#This file contains the commands to create libraries and compile the library file into those libraries. 
                                                                                                        
set path_to_quartus C:/altera/15.0/quartus

set type_of_sim compile_all
                                                                                                        
if {[string equal $type_of_sim "compile_all"]} {                                                        
# compiles all libraries                                                                                
	vlib lpm_ver     
	vmap lpm_ver lpm_ver 	
	vlog -work lpm_ver $path_to_quartus/eda/sim_lib/220model.v  
	
	vlib altera_mf_ver
	vmap altera_mf_ver altera_mf_ver 
	vlog -work altera_mf_ver $path_to_quartus/eda/sim_lib/altera_mf.v  
	
	vlib altera_ver	 
	vmap altera_ver altera_ver  
	vlog -work altera_ver $path_to_quartus/eda/sim_lib/altera_primitives.v 
	
	vlib sgate_ver  
	vmap sgate_ver sgate_ver 
	vlog -work sgate_ver $path_to_quartus/eda/sim_lib/sgate.v   
	
	vlib cycloneiv_ver
	vmap cycloneiv_ver cycloneiv_ver                          
	vlog -work cycloneiv_ver $path_to_quartus/eda/sim_lib/cycloneiv_atoms.v

                         
} else {                                                                                                
	puts "invalid code"                                                                                   
}                                                                                   