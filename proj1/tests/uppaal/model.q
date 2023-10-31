//This file was generated from (Academic) UPPAAL 4.1.26-1 (rev. 7BCF30B7363A9518), February 2022

/*

*/
E<> (Left_elevator.current_floor==3)

/*

*/
E<> (Left_elevator.current_floor==2)

/*

*/
E<> (Left_elevator.current_floor==1)

/*

*/
E<> (Right_elevator.current_floor==3)

/*

*/
E<> (Right_elevator.current_floor==2)

/*

*/
E<> (Right_elevator.current_floor==1)

/*

*/
A[] !(Left_elevator.whether_down == 1 && Left_elevator.whether_up == 1)||(Left_elevator.whether_down==1 && Left_elevator.whether_stay==1)||(Left_elevator.whether_up==1 && Left_elevator.whether_stay==1)

/*

*/
A[] !(Right_elevator.whether_down == 1 && Right_elevator.whether_up == 1)||(Right_elevator.whether_down==1 && Right_elevator.whether_stay==1)||(Right_elevator.whether_up==1 && Right_elevator.whether_stay==1)

/*

*/
A[] !(First_floor.Left_open && Second_floor.Left_open && Third_floor.Left_open)

/*

*/
A[] !(First_floor.Right_open && Second_floor.Right_open && Third_floor.Right_open)
