# User Manual

[TOC]

## **System Architecture**

![System_arch](D:\lzz\SE\proj\proj1\assets\System_arch.png)

## Main Manual

### 1. Overview

​	In proj1/src folder, run **main** to start main.m script. The system will start. At beginning, the following ui graph will appear.

![overview](D:\lzz\SE\proj\proj1\docs\manual\overview.jpg)

1. Left three-floor elevator doors. (Simulate open and close)
2. Left elevator shaft. (Simulate left elevator moving) 
3. Digital indicator for the current floor of the left three-floor elevator. (On the outer panel)
4. Outer panel of double-elevator system.
   Press "一层↑" button means someone who on the first floor wants to go up.
   Press "二层↓" button means someone who on the second floor wants to go down.
   Press "二层↑" button means someone who on the second floor wants to go up.
   Press "三层↓" button means someone who on the third floor wants to go down.
5. Digital indicator for the current floor of the right three-floor elevator. (On the outer panel)
6. Right elevator shaft. (Simulate right elevator moving) 
7. Right three-floor elevator doors. (Simulate open and close)
8. Left elevator's inner panel.
   Press "内呼1" button means someone in the left elevator wants to go to first floor.
   Press "内呼2" button means someone in the left elevator wants to go to second floor.
   Press "内呼3" button means someone in the left elevator wants to go to third floor.
   Press "开门" button means someone in the left elevator wants to open the floor.
   Press "关门" button means someone in the left elevator wants to close the floor.
9. Left elevator's inner display board.(Show current floor and up/down state)
10. Right elevator's inner display board.(Show current floor and up/down state)
11. Right elevator's inner panel.
    Press "内呼1" button means someone in the right elevator wants to go to first floor.
    Press "内呼2" button means someone in the right elevator wants to go to second floor.
    Press "内呼3" button means someone in the right elevator wants to go to third floor.
    Press "开门" button means someone in the right elevator wants to open the floor.
    Press "关门" button means someone in the right elevator wants to close the floor.

### 2. Outer panel control

​	At the beginning, user can choose a direction which he wants to go.

![outer_panel](D:\lzz\SE\proj\proj1\docs\manual\outer_panel.jpg)

​	When press a button, it will change to green color to show that it's been activated.

​	If an elevator is already on the target floor, it will respond to the door opening, otherwise the scheduling system will attempt to dispatch an elevator to the corresponding floor to respond to the command.

​	If a elevator will open directly,  the corresponding elevator shaft will stay and corresponding door will open to show the movement.

​	If a elevator will move, the corresponding elevator shaft will show it's position state. Also the inner panel will show it's moving state by change color. Outer digital board and inner digital board both will show the current floor number.

![outer_finish](D:\lzz\SE\proj\proj1\docs\manual\outer_finish.png)

​	When instruction have been done, button will back to original color. Elevator shaft and display board will update according to current system state.

![outer2](D:\lzz\SE\proj\proj1\docs\manual\outer2.png)

Also it will work the same process for go down instruction.

![outer2_finish](D:\lzz\SE\proj\proj1\docs\manual\outer2_finish.png)

### 3. Door control

The door open/close event will only occur when corresponding elevator is **stop**.

The door will open when it arrive target floor each time automatically.

And there are three methods to open an elevator manually : 

​	Inner : 1. press "开门" 2. press correspond "内呼*"

​	Outer : 1. press "*层↑/↓"

![open1](D:\lzz\SE\proj\proj1\docs\manual\open1.png)

![open2](D:\lzz\SE\proj\proj1\docs\manual\open2.png)

​	When elevator open to Max. It will stay Max state for 5 seconds and then close the door. (Wait passenger get on and get off)

​	Also passenger can press "关门" button and end the Max state immediately(The door will start closing without waiting 5 seconds)

![close](D:\lzz\SE\proj\proj1\docs\manual\close.png)

### 4. Inner panel control

When passenger get on an elevator, he can press "内呼*" button to get to target floor.

![inner](D:\lzz\SE\proj\proj1\docs\manual\inner.png)

The elevator shaft and display board will also move and update.

![inner_finish](D:\lzz\SE\proj\proj1\docs\manual\inner_finish.png)

When finish command, button color will restore too.

![inner2](D:\lzz\SE\proj\proj1\docs\manual\inner2.png)

Also it work for go down instruction.

![inner2_finish](D:\lzz\SE\proj\proj1\docs\manual\inner2_finish.png)

### 5. Double-click cancel instruction

​	When passenger in the elevator want to cancel an "has been pressed" instruction, he can double click the button **within 0.5 second**.

![cancel1](D:\lzz\SE\proj\proj1\docs\manual\cancel1.png)

​	Just like this example, left elevator receive "内呼1" and "内呼2". It is executing "内呼2" now. If passenger don't want to go third floor or just mis-click the button, he can double click within 0.5 second interval to cancel this instruction.

![cancel_finish](D:\lzz\SE\proj\proj1\docs\manual\cancel_finish.png)

As figure show, "内呼3" command doesn't work(It's been canceled).