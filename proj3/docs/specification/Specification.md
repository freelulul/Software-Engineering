<h1><center>Specifications</center></h1>



<h2>Content</h2>

[TOC]

# System Architecture

![image-20230601152442909](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601152442909.png)



# Software Specification

## S0 Basic Introduction

In development folder, open `main.m` and run it. The system will begin to run. At beginning, there will be a UI show up as picture below.

![image-20230601153335542](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601153335542.png)

There are 4 section in the UI. The `1` section is the 12306 main UI. The `2` section is time controller. The `3` section is train location monitor and `4` monitor is train seat left monitor. `2`, `3`, `4` are all backend UI.



## S1 Main Panel

![image-20230603142326354](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230603142326354.png)



### S1.1 Press DatePicker

- Date will turn to value user pick.

### S1.2 Press DropDown

- DropDown value will become the one that user chooses.

### S1.3 Press `查询`

- Process will use time now, departure station, arrival station and date to search available routines. 
- And will sort the result and display it in search panel. 
- Finally, current panel will be invisible and search panel will be visible.

### S1.4 Press `我的`

- Current panel will be invisible and `我的` Panel will be visible.



## S2 Log In

![image-20230601155425143](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601155425143.png)





### S2.1 Edit EditField

- Type in a number in the EditField to change its value, the limit of EditField is set to `[1, +inf]`.

### S2.2 Press `登陆` 

- Process will check whether there is record of the user id in EditField, if not, a new record of the new user ID will be added to database.
- Current panel will be invisible and the after-login `我的` will be visible.
- The after-login `我的` panel will show the login ID.

### S2.3 Press `首页`

- Current panel will be invisible and `首页` panel will be visible.



## S3 Mine Panel After Log In

![image-20230601165437346](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601165437346.png)

### S3.1 Press `登出`

- Log out function will be triggered.
- Current panel will be invisible and the before-login `我的` will be visible.

### S3.2 Press `本人车票`

- Process will check whether logged in and whether the has a ticket. If not, a warning panel will jump out like below.



![image-20230601165849971](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601165849971.png)

- If there is a ticket in the account, current panel will be invisible and the ticket panel will be visible.
- Information about the ticket will be set in the ticket panel.

### S3.3 Press `首页`

- Current panel will be invisible and `首页` panel will be visible.





## S4 Search Result



![image-20230601170551850](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601170551850.png)



### S4.1 Press `返回` 

- Current panel will be invisible and the main panel will be visible.

### S4.2 Press `购买`

- System will remember which `购买` is pushed and get the detailed information on the ticket user choose as well as set these information in payment panel.
- Current panel will be invisible and the payment panel will be visible.
- The payment clock countdown is set to 15 minutes.



## S5 Pay



![image-20230603150820594](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230603150820594.png)

### S5.1 DropDown

- The DropDown value will be set to what user choose.

### S5.2 Press `返回首页`

- Current panel will be invisible and the main panel will be visible.

### S5.3 Press `确定`

- Process will buy the ticket according to the information by triggering `buy_ticket()`, and if the function returns 1(success), a success panel will show up as above.
- If the function returns 0(error), corresponding msgbox will jump out.

![image-20230601172201912](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601172201912.png)



## S6 My Ticket

![image-20230601172605335](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601172605335.png)

### S6.1 Press `返回`

- Current panel will be invisible and Mine Panel will be visible.

### S6.2 Press `改签`

- The reschedule panel will be visible and current panel will be invisible.

### S6.3 Press `退票`

- After pushing `退票` , a reconfirm panel will be visible like picture below.

    ![image-20230601194433412](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601194433412.png)

#### S6.3.1 Press `取消`

- The reconfirm panel will be invisible.

#### S6.3.2 Press `确定`

- Will be illustrated in S6.5.

### S6.4 Unpress `上车`

- The button value will be changed and will affect `timerFunction()` when triggered.

### S6.5 Press `确定` in S6.3.2

- As S6.3.2 triggered, process will check whether there is a ticket, if so process will cancel the ticket and release seats to corresponding train.
- If the function returns 0(error), corresponding msgbox will jump out.

![image-20230601194605343](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601194605343.png)



## S7 Reschedule Ticket

### S7.1 `改签` button

- Ticket panel will be invisible and reschedule panel like below will be visible.

![image-20230601195237781](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601195237781.png)

### S7.2 Press `返回` 

- Current panel will be invisible and Mine panel will be visible.

### S7.3 Press `查询` 

- Similiar to main page, user can choose the departure station, arrival station and sorting way.
- User can click the button to search available ticket.

![image-20230601195548882](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601195548882.png)

### S7.4 Press `返回`

- Current panel will be invisible and Main page will be visible.

### S7.5 Press `购买`

- Still similiar to buying ticket, user can press different `购买` to buy tickets. System will remember which `购买` is pushed and get the detailed information on the ticket user choose as well as set these information in payment panel.

![image-20230601195846176](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601195846176.png)

### S7.6 DropDown

- The DropDown value will be set to what user choose.

### S7.7 Press `返回`

- Current panel will be invisible and the main panel will be visible.

### S7.8 Press `确定`

- Process will buy the ticket according to the information by triggering `buy_ticket()`, and if the function returns 1(success), a success panel will show up as above.
- If the function returns 0(error), corresponding msgbox will jump out.

![image-20230601200002819](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601200002819.png)

### S7.9 Press `返回` 

- Current panel will be invisible and the main panel will be visible.

## S8 Time Controller

![image-20230601200544897](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601200544897.png)

### S8.1 Type in editfield and press `设定` 

- Time speed will be changed by triggering `setSpeed()`. 

### S8.2 Press `继续` 

- Continue time when clock is paused. In other case there won't be any respond. System will check the clock running status.

### S8.3 Press `暂停`

- Pause time when clock is running. In other case there won't be any respond. System will check the clock running status.



## S9 Trainstate Monitor

![image-20230601200942948](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601200942948.png)

### S9.1 System TimerFunction

- As Time goes,  process will check which should be move according to its arrival and departure.
- The movement speed is corresponding to system time speed because the update function is in `timerFunction()`.

![image-20230601201056911](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601201056911.png)

### S9.2 Writeback TimerFunction

- Process will merge `schedule.csv` and `ticket.csv` and create a new table and display it.
- The write back timer function triggers every 2 seconds.(Doesn't have GUI to change)





## S10 Concurrent Buy Ticket

### S10.1 Windows

- Run `multi_main.m` which is the multi version of 12306 that has same instance of database but different instance of other class. 





































