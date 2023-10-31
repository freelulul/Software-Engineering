<h1><center>User Manual</center></h1>



<h2>Content</h2>

[TOC]

# System Architecture

![image-20230601152442909](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601152442909.png)



# Main Manual

## 2.1 Basic

In development folder, open `main.m` and run it. The system will begin to run. At beginning, there will be a UI show up as picture below.

![image-20230601153335542](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601153335542.png)

There are 4 section in the UI. The `1` section is the 12306 main UI. The `2` section is time controller. The `3` section is train location monitor and `4` monitor is train seat left monitor. `2`, `3`, `4` are all backend UI.



## 2.2 Main Panel

![image-20230601154851267](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601154851267.png)



Like the real world 12306, the front page of the app is inquiry. 

- User can see the date on the upper left corner. But choosing different date can't pose effect on ticket. The time in one day is based on the time on upper right corner (i.e. if the time on upper right stays in one day, then the system will regard the operations take place in one day). 
- User can click`从` to choose deaprture station,`去往` to choose arrival station and `排序` to choose the way to show inquiry result. 
- Finally, press the `查询` button to search for available ticket for the time now and information user choose.

- User can click `我的` to turn to user information and log in panel.  Notice that user doesn't need to login to search available ticket, but when using other function like buy ticket, cancel ticket and etc., login is required and user will receive a error msgbox if not logged in.

It is important to mention that the time is editable. But we **highly suggest** that you change the time when the clock is paused. Changing time when the clock is running can be successful, but when is clock is very fast, you may find it hard to type in.

A rough operating procedure is as below:

- [optional] Adjust time.
- Choose departure station.
- Choose arrival station.
- Choose sorting way. [default = less time]
- Click `查询` button.

## 2.3 Log In

![image-20230601155425143](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601155425143.png)





User can type in a number in `[1, +inf]` in the editfield and press `登陆` to login. In this panel, User can also return to front page by pushing `首页` with or without logging in.



## 2.4 Mine Panel After Log In

![image-20230601165437346](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601165437346.png)

After log in, you can see your user id on the upper left corner and a little `已登录` . Also, user can push `登出` button to log out. On the middle of the panel, you can see `本人车票`. User can push `本人车票` to see his ticket and if there is no ticket, a panel below will jump out to notice user.



![image-20230601165849971](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601165849971.png)



## 2.5 Search Result



![image-20230601170551850](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601170551850.png)



In the search result, you can see a lot of informations about the ticket on these panels. User can push `返回` on the upper left corner to return to main page and push `购买` to buy ticket user wants, 12306 will lead user to the corresponding payment.

Notice that if the last or third panel gives a result of **0 or NULL** is **NOT A BUG**. It indicates there are search paths less than 4. Also, only showing 4 results does't means there are only 4 possible path. User can see different paths by changing way of sorting in main page. (i.e. We will sort all search results and only show the top 4 result.)



## 2.6 Pay



![image-20230601171609218](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601171609218.png)

After choosing the ticket user wants, a pay panel above will appear. User can confirm information about the ticket and choose the seat class he want. 

- Pull down the dropdown to choose seat class and press `确定` to buy ticket. 
- If user don't want this ticket, he/she can push `返回首页` to return to main page.
- After click `确定` you will see a success page below.

![image-20230601172201912](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601172201912.png)

Notice that if user already have a ticket, he/she cannot buy another ticket. At this time if he/she tries to buy a ticket, a error msgbox will jump out to prevent his operation.



## 2.7 My Ticket

![image-20230601172605335](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601172605335.png)

After buying a ticket successfully, you can see your ticket in `Mine`. In this panel, user's information is listed above and 4 buttons are on below. 

- The `上车` button is on default pressed. If user can't board the train, he/she can unpress the button. 
- There are still `返回` button to go back to main page,  `退票` button to cancel the ticket and `改签` button to reschedule ticket.



## 2.8 Cancel Ticket

​		After pushing `退票` , a reconfirm panel will exist like picture below.

![image-20230601194433412](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601194433412.png)

- If user clicks `取消` he will return to his ticket.
- If user clicks `确定` his ticket will be canceled and a success panel will show up.

![image-20230601194605343](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601194605343.png)



## 2.9 Reschedule Ticket

After pushing `改签` button a ui will show up like below.

![image-20230601195237781](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601195237781.png)

- User can press `返回` on the upper left to go back.
- Similiar to main page, user can choose the departure station, arrival station and sorting way.
- User can click the button to search available ticket.

![image-20230601195548882](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601195548882.png)

- User can press `返回` to go back.
- Still similiar to buying ticket, user can press different `购买` to buy tickets. 

![image-20230601195846176](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601195846176.png)

- User can see information about the ticket. Specially, the price is the gap price.
- User can choose seat class by choosing the dropdown.
- User can press `返回` to go back.
- User can press `确定` to reschedule ticket and a success panel will show up.

![image-20230601200002819](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601200002819.png)

- Press `返回` to go back.



## 2.10 Time Controller

![image-20230601200544897](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601200544897.png)

- Type in editfield and press `设定` to change time speed, you don't have to stop the clock.
- Press `继续` to continue time when clock is paused. In other case there won't be any respond.
- Press `暂停` to pause time when clock is running. In other case there won't be any respond.



## 2.11 Trainstate Monitor

![image-20230601200942948](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601200942948.png)

- As Time goes, you can see train Id move along the railway.

- The movement speed is corresponding to system time speed.

![image-20230601201056911](C:\Users\wyh_a\AppData\Roaming\Typora\typora-user-images\image-20230601201056911.png)

- User can see the ticket condition in every station.
- When user board the train, seat will not be released.
- Every new day (system time reaches 00:00), this will reset to all 2 tickets.
- User can scroll down to see all informations.
- This table updates every 2 seconds.









































