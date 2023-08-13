module universal_shift_register_dut             
#(parameter N = 6) ();
reg clk , enable ,reset_n , clear , s0 , s1 , msb_in , lsb_in ;
reg [N-1 :0] I ;
wire [N-1 :0] Q ;

universal_shift_register #(.N(N)) uut
(
.clk(clk),
.enable(enable),
.reset_n(reset_n),
.clear(clear),
.s0(s0),
.s1(s1),
.msb_in(msb_in),
.lsb_in(lsb_in),
.I(I),
.Q(Q)
);

always
begin
   clk = 1'b0 ; #25
   clk = 1'b1 ; #25 ;
end

always
begin
   msb_in = 1'b1 ; #40 
   msb_in = 1'b0 ; #40 ;
end

always
begin
   lsb_in = 1'b1 ; #40 
   lsb_in = 1'b0 ; #40 ;
end

initial
begin
I = 6'b101101 ;
clear = 1'b0 ;
enable = 1'b1 ;
reset_n = 1'b0 ; #1
reset_n = 1'b1; 
s0 = 1'b1 ; s1 = 1'b0 ;  # 350
s0 = 1'b0 ; s1 = 1'b0 ;  # 120
s0 = 1'b0 ; s1 = 1'b1 ;  # 350
s0 = 1'b0 ; s1 = 1'b0 ;  # 120
s0 = 1'b1 ; s1 = 1'b1 ;  # 200
s0 = 1'b1 ; s1 = 1'b0 ;  # 350
clear = 1'b1 ; #160 
clear = 1'b0 ;
s0 = 1'b1 ; s1 = 1'b0 ;  # 350
enable = 1'b0 ; #150
enable = 1'b1 ;
s0 = 1'b0 ; s1 = 1'b1 ;  # 130
reset_n = 1'b0 ; #110
reset_n = 1'b1 ;
s0 = 1'b1 ; s1 = 1'b1 ;  # 200 ;
$stop  ;
end
endmodule
