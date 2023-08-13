module universal_shift_register
#(parameter N = 8)(
input clk,
input enable ,
input s1 , s0 ,
input msb_in , lsb_in ,
input reset_n ,  //Asynchronous reset
input clear,    // synchronous reset
input [N-1 :0]I ,
output [N-1 :0]Q
);
reg [N-1 : 0]Q_reg , Q_next ;

always @(posedge clk , negedge reset_n)
begin
if (!reset_n)
Q_reg <= 'b0 ;
else if(enable)
  Q_reg <= Q_next  ;
else
Q_reg <= Q_reg ;
end

always @(clear , Q_reg , s0 , s1 , msb_in , lsb_in , I)
begin
Q_next = Q_reg ;
  if(clear)
    Q_next = 'b0 ;
  else
    begin
      if(!s1 && !s0)
        Q_next = Q_reg ;
      else if(!s1 && s0)
        Q_next = {msb_in , Q_reg[N-1 :1]}  ;
      else if(s1 && !s0)
        Q_next = {Q_reg[N-2 :0] , lsb_in}  ;
      else if(s1 && s0)
        Q_next = I ;
      else
        Q_next = 'b0 ;
    end
end

assign Q = Q_reg ;

endmodule
