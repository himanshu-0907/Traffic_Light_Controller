# Traffic_Light_Controller
4-way Traffic Light Controller based on Finite State Machine (FSM) using verilog

This traffic light controller controls the signals for four roads: East, North, West, and South.
The controller uses different states to handle normal operation, emergency conditions, and jam conditions.

>>Schematic of the project
![Screenshot 2023-07-22 180802](https://github.com/himanshu-0907/Traffic_Light_Controller/assets/97429283/e3713a63-3e08-414e-8ea0-ddd137d28411)


>>State Diagram
![Screenshot 2023-07-22 181123](https://github.com/himanshu-0907/Traffic_Light_Controller/assets/97429283/edfc93ce-a385-46a9-b716-88a22649aa08)


>>Meanings of different output signals
![Screenshot 2023-07-22 181057](https://github.com/himanshu-0907/Traffic_Light_Controller/assets/97429283/08a3f2f7-7af7-4bf8-afce-279159531e6f)


>>Output signals at different states
![Screenshot 2023-07-22 181111](https://github.com/himanshu-0907/Traffic_Light_Controller/assets/97429283/51b87fa8-8dc2-4fe6-a9fd-88ddeb827cdb)


Here's a brief overview of the verilog code:

>>Inputs:
clk: Clock signal.
rst: Asynchronous reset signal.
Emergency: A 4-bit input indicating emergency conditions for each road. If a bit is set to '1', it represents an emergency on the corresponding road (east, north, west, south).
Jam: A 4-bit input indicating jam conditions for each road. If a bit is set to '1', it represents a jam on the corresponding road (east, north, west, south).
Empty: A 4-bit input indicating if each road is empty. If a bit is set to '1', it means the road is empty (no vehicles present).

>>Outputs:
East_road, North_road, West_road, South_road: 3-bit output signals indicating the state of traffic lights for each road. The encoding is as follows:
Red = 3'b100
Yellow = 3'b010
Green = 3'b001
RedYellow = 3'b110
None = 3'b000

>>Parameters:
The module defines several parameters to represent different states, such as green, yellow, etc., for each road.

>>Internal Registers:
state: A 3-bit register to hold the current state of the traffic light controller.
count: A 5-bit register used for counting clock cycles to manage signal timings.

>>State Transitions:
The module uses an always block to handle state transitions based on the inputs, count, and the presence of emergencies, jams, or empty roads.

>>Output Assignment:
The always block assigns the appropriate output signals based on the current state of the traffic light controller.

>>Reset:
During the reset (rst), all outputs are initialized to '000', indicating that no traffic light is on.
