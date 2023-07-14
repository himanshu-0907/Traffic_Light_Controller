`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2023 22:33:55
// Design Name: 
// Module Name: traffic_ligtht_controller_tb
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


module traffic_ligtht_controller_tb;
wire [2:0] East_road, North_road, West_road, South_road;
reg clk, rst;
reg [3:0] Emergency, Jam, Empty;

//Instantiating the traffic_light_controller module
traffic_light_controller dut(.clk(clk), .rst(rst), .Emergency(Emergency), .Jam(Jam), .Empty(Empty), .East_road(East_road), .North_road(North_road), .West_road(West_road), .South_road(South_road));

//Initializing the input values
initial
 begin
 clk=1'b0;
 rst=1'b0;
 Emergency=4'b0000;
 Jam=4'b0000;
 Empty=4'b0000;
 end
 
always #5 clk=~clk;         //logic for generating clock

initial
 begin
 $monitor($time , "rst=%1b, Emergency=%4b, Jam=%4b, Empty=%4b, East_road=%3b, North_road=%3b, West_road=%3b, South_road=%3b", rst, Emergency, Jam, Empty, East_road, North_road, West_road, South_road);
 //this statement will display output when any of the listed variables changes
 
 #10 rst=1'b1;              //rst is made high for normal operation 
 #290 Empty=4'b0100;        //Empty at North
 #50 Emergency=4'b0001;     //Emergency at South
 #50 Emergency=4'b0000;     //Emergency removed
 #50 Empty=4'b0001;         //Empty at South
 #20 Jam=4'b0010;           //Jam at West
 #30 Jam=4'b0000;           //Jam removed
 #50 Empty=4'b0010;         //Empty at West
 #30 Emergency=4'b0100; Jam=4'b0001;        //Emergency at North as well as Jam at South------->> More priority to Emergency
 #50 Emergency=4'b0000;                     //Emergency removed
 #50 Jam=4'b0000;                           //Jam removed
 #30 rst=1'b0;                              //Traffc Light Controller is reset
 #50 $finish;                               //test bench finished
 
 end
 
endmodule
