`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2023 15:11:04
// Design Name: 
// Module Name: traffic_light_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module traffic_light_controller(
    input clk,
    input rst,
    input [3:0] Emergency,      //for east 1000, for north 0100, for west 0010, for south 0001 default 0000
    input [3:0] Jam,            //for east 1000, for north 0100, for west 0010, for south 0001 default 0000
    input [3:0] Empty,          //for east 1000, for north 0100, for west 0010, for south 0001 default 0000
    output reg [2:0] East_road,     //Red=100, Yellow=010, Green=001, RedYellow=110, none=000
    output reg [2:0] North_road,
    output reg [2:0] West_road,
    output reg [2:0] South_road
    );
    
    reg[2:0] state;
    
    parameter [2:0] east_green=3'd0;
    parameter [2:0] east_yellow=3'd1;
    parameter [2:0] north_green=3'd2;
    parameter [2:0] north_yellow=3'd3;
    parameter [2:0] west_green=3'd4;
    parameter [2:0] west_yellow=3'd5;
    parameter [2:0] south_green=3'd6;
    parameter [2:0] south_yellow=3'd7;
    
    reg[4:0] count;
    
    always@(posedge clk, negedge rst)
    begin
     if(!rst)
      begin
      count=5'b00000;
      end
      
      else if(|Emergency)
       begin
       state={Emergency[1]|Emergency[0],Emergency[2]|Emergency[0],1'b0};            //logic for emergency condition
       count=5'b00000;
       end
       
       else if(|Jam)
       begin
       state={Jam[1]|Jam[0],Jam[2]|Jam[0],1'b0};                                   //logic for jam condition
       count=5'b00000;
       end
       
       else
        begin
        case(state)
        
         east_green:
          begin
          if(count==5'b10011||Empty==4'b1000)             //Max time for green signal is 20 sec and if empty cond. is true before 20 sec then signal will become yellow
           begin
           count=5'b00000;
           state=east_yellow;
           end
          else                                          //logic to produce delay of 20 clk cycles
           begin
           count=count+5'b00001;
           state=east_green;
           end
          end
          
          east_yellow:
          begin
          if(count==5'b00011)                           //Max time for yellow signal is 4 sec
           begin
           count=5'b00000;
           state=north_green;
           end
          else                                          //logic to produce delay of 4 clk cycles
           begin
           count=count+5'b00001;
           state=east_yellow;
           end
          end
          
          north_green:
          begin
          if(count==5'b10011||Empty==4'b0100)
           begin
           count=5'b00000;
           state=north_yellow;
           end
          else
           begin
           count=count+5'b00001;
           state=north_green;
           end
          end
          
          north_yellow:
          begin
          if(count==5'b00011)
           begin
           count=5'b00000;
           state=west_green;
           end
          else
           begin
           count=count+5'b00001;
           state=north_yellow;
           end
          end
          
          west_green:
          begin
          if(count==5'b10011||Empty==4'b0010)
           begin
           count=5'b00000;
           state=west_yellow;
           end
          else
           begin
           count=count+5'b00001;
           state=west_green;
           end
          end
          
          west_yellow:
          begin
          if(count==5'b00011)
           begin
           count=5'b00000;
           state=south_green;
           end
          else
           begin
           count=count+5'b00001;
           state=west_yellow;
           end
          end
          
          south_green:
          begin
          if(count==5'b10011||Empty==4'b0001)
           begin
           count=5'b00000;
           state=south_yellow;
           end
          else
           begin
           count=count+5'b00001;
           state=south_green;
           end
          end
          
          south_yellow:
          begin
          if(count==5'b00011)
           begin
           count=5'b00000;
           state=east_green;
           end
          else
           begin
           count=count+5'b00001;
           state=south_yellow;
           end
          end
          
          default:
           begin
           count=5'b00000;
           state=east_green;
           end
          
        endcase
        end
    end
    
//Red=100, Yellow=010, Green=001, RedYellow=110, none=000
 
 always@(state , negedge rst)
  begin
  if(!rst)
   begin
   East_road=3'b000;              //none of the lights is ON
   North_road=3'b000;
   West_road=3'b000;
   South_road=3'b000;
   end
  else
   begin
   case(state)
   
   east_green:
    begin
    East_road=3'b001;
    North_road=3'b100;
    West_road=3'b100;
    South_road=3'b100;
    end
    
   east_yellow:
    begin
    East_road=3'b010;
    North_road=3'b110;
    West_road=3'b100;
    South_road=3'b100;
    end
    
   north_green:
    begin
    East_road=3'b100;
    North_road=3'b001;
    West_road=3'b100;
    South_road=3'b100;
    end
    
   north_yellow:
    begin
    East_road=3'b100;
    North_road=3'b010;
    West_road=3'b110;
    South_road=3'b100;
    end
    
   west_green:
    begin
    East_road=3'b100;
    North_road=3'b100;
    West_road=3'b001;
    South_road=3'b100;
    end
    
   west_yellow:
    begin
    East_road=3'b100;
    North_road=3'b100;
    West_road=3'b010;
    South_road=3'b110;
    end
    
   south_green:
    begin
    East_road=3'b100;
    North_road=3'b100;
    West_road=3'b100;
    South_road=3'b001;
    end
    
   south_yellow:
    begin
    East_road=3'b110;
    North_road=3'b100;
    West_road=3'b100;
    South_road=3'b010;
    end
    
    default:
     begin
     East_road=3'b001;
     North_road=3'b100;
     West_road=3'b100;
     South_road=3'b100;
     end    
   endcase
   end
  end
    
endmodule
