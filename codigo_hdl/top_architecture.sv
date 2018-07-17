
// RELEASE HISTORY
// VERSION 	DATE         AUTHOR		DESCRIPTION
// 1.0		2018-05-07   group   	version sv

`timescale 1ns/1ps
module top_architecture (
	input logic clk,
	input logic rst
	//---------------------------//
);
//------------------internal-signals-----------------//
//----------------WSBN---------------------//
logic  ACK_I_M0;         //wshbn_master wbus
logic [7:0] ADR;         // ADR = ADR_O_M0 wshbn_master     wbus
logic  [7:0] ADR_O_M0;     //wshbn_master
//----------------------------//
logic ACK_O_S0;
logic ACK_O_S1;
//----------------------------//
logic  ACMP0;
logic  ACMP1;
logic  ACMP2;
//----------------------------//
logic  CYC ;                     
logic  CYC_O_M0 ;              //wshbn_master wbus
logic  [31:0] DAT_O_M0 ;     //wshbn_master wbus
logic  [31:0] DAT_O_S0 ;    //wshbn_pio SLV0
logic  [31:0] DAT_O_S1 ;    //wshbn_timer
logic  [31:0] DAT_O_S2 ;     //UART
//----------------------------//
logic  [31:0] DRD ;           
logic  [31:0] DWR ;           
//----------------------------//
logic  STB    ;             //STB = STB_O_M0     wshbn_master wbus
logic  STB_O_M0;            //wshbn_master wbus
logic  STB_I_S0;            //wshbn_pio SLV0
logic  STB_I_S1;            //wshbn_timer SLV1
//----------------------------//
logic  STB_I_S2;
logic  WE     ;       
logic  WE_O_M0;    
//----------------MEM---------------------//
logic [31:0] 	pc_out_top			;
logic 			start_read_top		;
logic [31:0] 	instruction_out_top ;

/* mem_ctrl mem_ctrl_riscv (


); */
/* d_cache mem_program(


); */
top_cpu top_cpu_riscv (

	.clk_top_cpu			(	clk		),
	.rst_top_cpu			(	rst		),
	//		
	.pc_out					(	pc_out_top			),
	.start_read				(	start_read_top		),
	.instruction_out		(	instruction_out_top	)
);
/* 
interrupt_controller interrupt_controller_riscv(

);

wsbn_master wsbn_master_riscv(

);

wsbn_timer wsbn_timer_riscv(

); 

wsbn_pio wsbn_pio_riscv(

); 

wshbn_uart wshbn_uart_riscv(

); */

//---------------------------//

 //------------------------DECODER-BUS-ADDRESS------------------------------//
/*     always @(ADR)  begin                    
            ACMP2 = ( ~ADR[7] & ~ADR[6] & ADR[5]  & ~ADR[4] );  //0010
            ACMP1 = ( ~ADR[7] & ~ADR[6] & ~ADR[5] & ADR[4]  );  //0001
            ACMP0 = ( ~ADR[7] & ~ADR[6] & ~ADR[5] & ~ADR[4] ); //0000
    end
    //--------------------------DECODER-BUS-CONTROL----------------------------//
    always @(ACMP2,ACMP1, ACMP0, CYC, STB)
    begin
            STB_I_S2 = CYC & STB & ACMP2;
            STB_I_S1 = CYC & STB & ACMP1;
            STB_I_S0 = CYC & STB & ACMP0;
            
    end
    //-----------------------CONTROL-BUS-MASTER-------------------------------//
    assign ACK_I_M0 = ACK_O_S0;         //ACK_I_M0 wshbn_master wbus
    assign CYC = CYC_O_M0;             //wshbn_master wbus
    assign ADR = ADR_O_M0;                 //wshbn_master     wbus
    assign WE  = WE_O_M0;             //wshbn_master wbus    
    assign DWR = DAT_O_M0;             //wshbn_master wbus
    assign STB = STB_O_M0;             //wshbn_master wbus
    //-----------------------DECODER-BUS-DATA-------------------------------//
    always @(DAT_O_S1, DAT_O_S0, ADR ) 
    begin                                   
            case ( ADR[7:4] )
                4'b0000:  DRD <= DAT_O_S0;         // IO wshbn_pio SLV0
                4'b0001:  DRD <= DAT_O_S1;         //    wshbn_timer
                4'b0010:  DRD <= DAT_O_S2;         // UART
                default :  DRD <= DAT_O_S0;        // wshbn_pio SLV0
            endcase
            
    end */
endmodule