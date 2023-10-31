//This file was generated from (Academic) UPPAAL 4.1.26-1 (rev. 7BCF30B7363A9518), February 2022

/*

*/
A[]no deadlock

/*

*/
A[](Chess1.row >= 0 && Chess1.row < 4 && Chess1.col >=0 &&Chess1.col < 3)

/*

*/
A[](Chess3.row >= 0 && Chess3.row < 4 && Chess3.col >=0 &&Chess3.col <= 3)

/*

*/
A[](Chess2.row >= 0 && Chess2.row <= 4 && Chess2.col >=0 &&Chess2.col < 3)

/*

*/
A[](Chess7.row >= 0 && Chess7.row <= 4 && Chess7.col >=0 &&Chess7.col <= 3)

/*

*/
E<>(Chess1.row == 3 && Chess1.col == 1 && step < 200)
