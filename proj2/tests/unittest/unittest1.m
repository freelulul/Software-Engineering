classdef unittest1 < matlab.uitest.TestCase
    %test menu UI
    properties
        ui;

    end
    methods(Test)
        %T1.1.1 init_board
        function chessboard_init(testCase)
            addpath('../../src');
            matrix = [1,1,2,2;1,1,3,4;6,5,3,4;6,5,7,9;8,10,0,0];
            board = chessboard();
            board.init_board(matrix)
            testCase.verifyEqual(board.get_chessboard(),matrix)
            close all force;
        end
        %T1.2 left_update()
        %T1.1.2.1
        function chessboard_left_update1(testCase)
            addpath('../../src');
            matrix = [0,1,1,0;0,1,1,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.left_update(1,[1,2],[2,3])
            testCase.verifyEqual(board.get_chessboard(),[1,1,0,0;1,1,0,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.2.2
        function chessboard_left_update2(testCase)
            addpath('../../src');
            matrix = [0,2,2,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.left_update(2,1,[2,3])
            testCase.verifyEqual(board.get_chessboard(),[2,2,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.2.3
        function chessboard_left_update3(testCase)
            addpath('../../src');
            matrix = [0,0,3,0;0,0,3,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.left_update(3,[1,2],3)
            testCase.verifyEqual(board.get_chessboard(),[0,3,0,0;0,3,0,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.2.4
        function chessboard_left_update4(testCase)
            addpath('../../src');
            matrix = [0,0,4,0;0,0,4,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.left_update(4,[1,2],3)
            testCase.verifyEqual(board.get_chessboard(),[0,4,0,0;0,4,0,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.2.5
        function chessboard_left_update5(testCase)
            addpath('../../src');
            matrix = [0,0,5,0;0,0,5,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.left_update(5,[1,2],3)
            testCase.verifyEqual(board.get_chessboard(),[0,5,0,0;0,5,0,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.2.6
        function chessboard_left_update6(testCase)
            addpath('../../src');
            matrix = [0,0,6,0;0,0,6,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.left_update(6,[1,2],3)
            testCase.verifyEqual(board.get_chessboard(),[0,6,0,0;0,6,0,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.2.7
        function chessboard_left_update7(testCase)
            addpath('../../src');
            matrix = [0,0,7,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.left_update(7,1,3)
            testCase.verifyEqual(board.get_chessboard(),[0,7,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.2.8
        function chessboard_left_update8(testCase)
            addpath('../../src');
            matrix = [0,0,8,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.left_update(8,1,3)
            testCase.verifyEqual(board.get_chessboard(),[0,8,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.2.9
        function chessboard_left_update9(testCase)
            addpath('../../src');
            matrix = [0,0,9,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.left_update(9,1,3)
            testCase.verifyEqual(board.get_chessboard(),[0,9,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.2.10
        function chessboard_left_update10(testCase)
            addpath('../../src');
            matrix = [0,0,10,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.left_update(10,1,3)
            testCase.verifyEqual(board.get_chessboard(),[0,10,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.3 right_update()
        %T1.1.3.1
        function chessboard_right_update1(testCase)
            addpath('../../src');
            matrix = [0,1,1,0;0,1,1,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.right_update(1,[1,2],[2,3])
            testCase.verifyEqual(board.get_chessboard(),[0,0,1,1;0,0,1,1;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.3.2
        function chessboard_rihgt_update2(testCase)
            addpath('../../src');
            matrix = [0,2,2,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.right_update(2,1,[2,3])
            testCase.verifyEqual(board.get_chessboard(),[0,0,2,2;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.3.3
        function chessboard_right_update3(testCase)
            addpath('../../src');
            matrix = [0,0,3,0;0,0,3,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.right_update(3,[1,2],3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,0,3;0,0,0,3;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.3.4
        function chessboard_right_update4(testCase)
            addpath('../../src');
            matrix = [0,0,4,0;0,0,4,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.right_update(4,[1,2],3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,0,4;0,0,0,4;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.3.5
        function chessboard_right_update5(testCase)
            addpath('../../src');
            matrix = [0,0,5,0;0,0,5,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.right_update(5,[1,2],3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,0,5;0,0,0,5;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.3.6
        function chessboard_right_update6(testCase)
            addpath('../../src');
            matrix = [0,0,6,0;0,0,6,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.right_update(6,[1,2],3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,0,6;0,0,0,6;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.3.7
        function chessboard_right_update7(testCase)
            addpath('../../src');
            matrix = [0,0,7,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.right_update(7,1,3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,0,7;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.3.8
        function chessboard_right_update8(testCase)
            addpath('../../src');
            matrix = [0,0,8,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.right_update(8,1,3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,0,8;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.3.9
        function chessboard_right_update9(testCase)
            addpath('../../src');
            matrix = [0,0,9,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.right_update(9,1,3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,0,9;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.3.10
        function chessboard_right_update10(testCase)
            addpath('../../src');
            matrix = [0,0,10,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.right_update(10,1,3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,0,10;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.4 up_update()
        %T1.1.4.1
        function chessboard_up_update1(testCase)
            addpath('../../src');
            matrix = [0,0,0,0;0,1,1,0;0,1,1,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.up_update(1,[2,3],[2,3])
            testCase.verifyEqual(board.get_chessboard(),[0,1,1,0;0,1,1,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.4.2
        function chessboard_up_update2(testCase)
            addpath('../../src');
            matrix = [0,0,0,0;0,2,2,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.up_update(2,2,[2,3])
            testCase.verifyEqual(board.get_chessboard(),[0,2,2,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.4.3
        function chessboard_up_update3(testCase)
            addpath('../../src');
            matrix = [0,0,0,0;0,0,3,0;0,0,3,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.up_update(3,[2,3],3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,3,0;0,0,3,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.4.4
        function chessboard_up_update4(testCase)
            addpath('../../src');
            matrix = [0,0,0,0;0,0,4,0;0,0,4,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.up_update(4,[2,3],3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,4,0;0,0,4,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.4.5
        function chessboard_up_update5(testCase)
            addpath('../../src');
            matrix = [0,0,0,0;0,0,5,0;0,0,5,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.up_update(5,[2,3],3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,5,0;0,0,5,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.4.6
        function chessboard_up_update6(testCase)
            addpath('../../src');
            matrix = [0,0,0,0;0,0,6,0;0,0,6,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.up_update(6,[2,3],3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,6,0;0,0,6,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.4.7
        function chessboard_up_update7(testCase)
            addpath('../../src');
            matrix = [0,0,0,0;0,0,7,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.up_update(7,2,3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,7,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.4.8
        function chessboard_up_update8(testCase)
            addpath('../../src');
            matrix = [0,0,0,0;0,0,8,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.up_update(8,2,3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,8,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.4.9
        function chessboard_up_update9(testCase)
            addpath('../../src');
            matrix = [0,0,0,0;0,0,9,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.up_update(9,2,3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,9,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.4.10
        function chessboard_up_update10(testCase)
            addpath('../../src');
            matrix = [0,0,0,0;0,0,10,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.up_update(10,2,3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,10,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.5 down_update()
        %T1.1.5.1
        function chessboard_down_update1(testCase)
            addpath('../../src');
            matrix = [0,0,0,0;0,1,1,0;0,1,1,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.down_update(1,[2,3],[2,3])
            testCase.verifyEqual(board.get_chessboard(),[0,0,0,0;0,0,0,0;0,1,1,0;0,1,1,0;0,0,0,0])
            close all force;
        end
        %T1.1.5.2
        function chessboard_down_update2(testCase)
            addpath('../../src');
            matrix = [0,0,0,0;0,2,2,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.down_update(2,2,[2,3])
            testCase.verifyEqual(board.get_chessboard(),[0,0,0,0;0,0,0,0;0,2,2,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.5.3
        function chessboard_down_update3(testCase)
            addpath('../../src');
            matrix = [0,0,0,0;0,0,3,0;0,0,3,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.down_update(3,[2,3],3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,0,0;0,0,0,0;0,0,3,0;0,0,3,0;0,0,0,0])
            close all force;
        end
        %T1.1.5.4
        function chessboard_down_update4(testCase)
            addpath('../../src');
            matrix = [0,0,0,0;0,0,4,0;0,0,4,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.down_update(4,[2,3],3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,0,0;0,0,0,0;0,0,4,0;0,0,4,0;0,0,0,0])
            close all force;
        end
        %T1.1.5.5
        function chessboard_down_update5(testCase)
            addpath('../../src');
            matrix = [0,0,0,0;0,0,5,0;0,0,5,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.down_update(5,[2,3],3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,0,0;0,0,0,0;0,0,5,0;0,0,5,0;0,0,0,0])
            close all force;
        end
        %T1.1.5.6
        function chessboard_down_update6(testCase)
            addpath('../../src');
            matrix = [0,0,0,0;0,0,6,0;0,0,6,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.down_update(6,[2,3],3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,0,0;0,0,0,0;0,0,6,0;0,0,6,0;0,0,0,0])
            close all force;
        end
        %T1.1.5.7
        function chessboard_down_update7(testCase)
            addpath('../../src');
            matrix = [0,0,0,0;0,0,7,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.down_update(7,2,3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,0,0;0,0,0,0;0,0,7,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.5.8
        function chessboard_down_update8(testCase)
            addpath('../../src');
            matrix = [0,0,0,0;0,0,8,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.down_update(8,2,3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,0,0;0,0,0,0;0,0,8,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.5.9
        function chessboard_down_update9(testCase)
            addpath('../../src');
            matrix = [0,0,0,0;0,0,9,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.down_update(9,2,3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,0,0;0,0,0,0;0,0,9,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.5.10
        function chessboard_down_update10(testCase)
            addpath('../../src');
            matrix = [0,0,0,0;0,0,10,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            board.down_update(10,2,3)
            testCase.verifyEqual(board.get_chessboard(),[0,0,0,0;0,0,0,0;0,0,10,0;0,0,0,0;0,0,0,0])
            close all force;
        end
        %T1.1.6.1
        function check_win_test1(testCase)
            addpath('../../src');
            matrix = [0,0,0,0;0,0,0,0;0,0,0,0;0,1,1,0;0,1,1,0];
            board = chessboard();
            board.init_board(matrix)
            result = board.check_win();
            testCase.verifyEqual(result,true);
            close all force;
        end
        %T1.1.6.2
        function check_win_test2(testCase)
            addpath('../../src');
            matrix = [0,0,0,0;0,0,0,0;0,1,1,0;0,1,1,0;0,0,0,0];
            board = chessboard();
            board.init_board(matrix)
            result = board.check_win();
            testCase.verifyEqual(result,false);
            close all force;
        end
        %T1.1.7.1 
        %No button
        function put_chess_test1(testCase)
            addpath('../../src');
            board = chessboard();
            matrix = [0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board.init_board(matrix)
            result = board.put_chess(0,1,1);
            testCase.verifyEqual(result,1)
            close all force;
        end
        %T1.1.7.2 
        %button 1 ,edge
        function put_chess_test2(testCase)
            addpath('../../src');
            board = chessboard();
            matrix = [0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board.init_board(matrix)
            result = board.put_chess(1,5,1);
            testCase.verifyEqual(result,3)
            close all force;
        end
        %T1.1.7.3 
        %button 1,no space
        function put_chess_test3(testCase)
            addpath('../../src');
            board = chessboard();
            matrix = [7,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board.init_board(matrix)
            result = board.put_chess(1,1,1);
            testCase.verifyEqual(result,3)
            close all force;
        end
        %T1.1.7.4 
        %button 1,succeessfully put
        function put_chess_test4(testCase)
            addpath('../../src');
            board = chessboard();
            matrix = [0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board.init_board(matrix)
            result = board.put_chess(1,1,1);
            testCase.verifyEqual(result,2)
            close all force;
        end
        %T1.1.7.5 
        %button 2 ,edge
        function put_chess_test5(testCase)
            addpath('../../src');
            board = chessboard();
            matrix = [0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board.init_board(matrix)
            result = board.put_chess(2,1,4);
            testCase.verifyEqual(result,3)
            close all force;
        end
        %T1.1.7.6 
        %button 2,no space
        function put_chess_test6(testCase)
            addpath('../../src');
            board = chessboard();
            matrix = [7,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board.init_board(matrix)
            result = board.put_chess(2,1,1);
            testCase.verifyEqual(result,3)
            close all force;
        end
        %T1.1.7.7 
        %button 2,succeessfully put
        function put_chess_test7(testCase)
            addpath('../../src');
            board = chessboard();
            matrix = [0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board.init_board(matrix)
            result = board.put_chess(2,1,1);
            testCase.verifyEqual(result,2)
            close all force;
        end
        %T1.1.7.8 
        %button 3 ,edge
        function put_chess_test8(testCase)
            addpath('../../src');
            board = chessboard();
            matrix = [0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board.init_board(matrix)
            result = board.put_chess(3,5,1);
            testCase.verifyEqual(result,3)
            close all force;
        end
        %T1.1.7.9 
        %button 3,no space
        function put_chess_test9(testCase)
            addpath('../../src');
            board = chessboard();
            matrix = [7,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board.init_board(matrix)
            result = board.put_chess(3,1,1);
            testCase.verifyEqual(result,3)
            close all force;
        end
        %T1.1.7.10 
        %button 3,succeessfully put
        function put_chess_test10(testCase)
            addpath('../../src');
            board = chessboard();
            matrix = [0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board.init_board(matrix)
            result = board.put_chess(3,1,1);
            testCase.verifyEqual(result,2)
            close all force;
        end
        %T1.1.7.11 
        %button 7,no space
        function put_chess_test11(testCase)
            addpath('../../src');
            board = chessboard();
            matrix = [2,2,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board.init_board(matrix)
            result = board.put_chess(7,1,1);
            testCase.verifyEqual(result,3)
            close all force;
        end
        %T1.1.7.12 
        %button 7,succeessfully put
        function put_chess_test12(testCase)
            addpath('../../src');
            board = chessboard();
            matrix = [0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board.init_board(matrix)
            result = board.put_chess(7,1,1);
            testCase.verifyEqual(result,2)
            close all force;
        end
        %T1.1.8.1
        function release_chess_test(testCase)
            addpath('../../src');
            board = chessboard();
            matrix = [1,1,0,0;1,1,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board.init_board(matrix)
            board.release_chess(1);
            testCase.verifyEqual(board.ChessBoard,zeros(5,4))
            close all force;
        end
        %T1.1.9.1
        function check_chess_test1(testCase)
            addpath('../../src');
            board = chessboard();
            matrix = [1,1,0,0;1,1,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board.init_board(matrix)
            result = board.check_chess(1);
            testCase.verifyEqual(result,true)
            close all force;
        end
        %T1.1.9.2
        function check_chess_test2(testCase)
            addpath('../../src');
            board = chessboard();
            matrix = [0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            board.init_board(matrix)
            result = board.check_chess(1);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.2.1.1
        function move_2_2_init_test(testCase)
            addpath('../../src');
            chess2_2 = move_2_2();
            matrix = [1,1,0,0;1,1,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess2_2.init_move(matrix,1)
            testCase.verifyEqual(chess2_2.get_row(),[1,2])
            testCase.verifyEqual(chess2_2.get_column(),[1,2])
            close all force;
        end
        %T1.2.2.1
        function move_2_2_left_check_test1(testCase)
            addpath('../../src');
            chess2_2 = move_2_2();
            matrix = [1,1,0,0;1,1,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess2_2.init_move(matrix,1)
            result = chess2_2.left_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.2.2.2
        function move_2_2_left_check_test2(testCase)
            addpath('../../src');
            chess2_2 = move_2_2();
            matrix = [3,1,1,0;3,1,1,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess2_2.init_move(matrix,1)
            result = chess2_2.left_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.2.2.3
        function move_2_2_left_check_test3(testCase)
            addpath('../../src');
            chess2_2 = move_2_2();
            matrix = [0,1,1,0;0,1,1,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess2_2.init_move(matrix,1)
            result = chess2_2.left_check(matrix);
            testCase.verifyEqual(result,true)
            close all force;
            
        end
        %T1.2.3.1
        function move_2_2_right_check_test1(testCase)
            addpath('../../src');
            chess2_2 = move_2_2();
            matrix = [0,0,1,1;0,0,1,1;0,0,0,0;0,0,0,0;0,0,0,0];
            chess2_2.init_move(matrix,1)
            result = chess2_2.right_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.2.3.2
        function move_2_2_right_check_test2(testCase)
            addpath('../../src');
            chess2_2 = move_2_2();
            matrix = [0,1,1,3;0,1,1,3;0,0,0,0;0,0,0,0;0,0,0,0];
            chess2_2.init_move(matrix,1)
            result = chess2_2.right_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.2.3.3
        function move_2_2_right_check_test3(testCase)
            addpath('../../src');
            chess2_2 = move_2_2();
            matrix = [0,1,1,0;0,1,1,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess2_2.init_move(matrix,1)
            result = chess2_2.right_check(matrix);
            testCase.verifyEqual(result,true)
            close all force;
        end
        %T1.2.4.1
        function move_2_2_up_check_test1(testCase)
            addpath('../../src');
            chess2_2 = move_2_2();
            matrix = [1,1,0,0;1,1,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess2_2.init_move(matrix,1)
            result = chess2_2.up_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.2.4.2
        function move_2_2_up_check_test2(testCase)
            addpath('../../src');
            chess2_2 = move_2_2();
            matrix = [0,2,2,0;0,1,1,0;0,1,1,0;0,0,0,0;0,0,0,0];
            chess2_2.init_move(matrix,1)
            result = chess2_2.up_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.2.4.3
        function move_2_2_up_check_test3(testCase)
            addpath('../../src');
            chess2_2 = move_2_2();
            matrix = [0,0,0,0;0,1,1,0;0,1,1,0;0,0,0,0;0,0,0,0];
            chess2_2.init_move(matrix,1)
            result = chess2_2.up_check(matrix);
            testCase.verifyEqual(result,true)
            close all force;
        end
        %T1.2.5.1
        function move_2_2_down_check_test1(testCase)
            addpath('../../src');
            chess2_2 = move_2_2();
            matrix = [0,0,0,0;0,0,0,0;0,0,0,0;1,1,0,0;1,1,0,0];
            chess2_2.init_move(matrix,1)
            result = chess2_2.down_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.2.5.2
        function move_2_2_down_check_test2(testCase)
            addpath('../../src');
            chess2_2 = move_2_2();
            matrix = [0,1,1,0;0,1,1,0;0,2,2,0;0,0,0,0;0,0,0,0];
            chess2_2.init_move(matrix,1)
            result = chess2_2.down_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.2.5.3
        function move_2_2_down_check_test3(testCase)
            addpath('../../src');
            chess2_2 = move_2_2();
            matrix = [0,1,1,0;0,1,1,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess2_2.init_move(matrix,1)
            result = chess2_2.down_check(matrix);
            testCase.verifyEqual(result,true)
            close all force;
        end
         %T1.3.1.1
        function move_2_1_init_test(testCase)
            addpath('../../src');
            chess2_1 = move_2_1();
            matrix = [2,2,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess2_1.init_move(matrix,2)
            testCase.verifyEqual(chess2_1.get_row(),1)
            testCase.verifyEqual(chess2_1.get_column(),[1,2])
            close all force;
        end
        %T1.3.2.1
        function move_2_1_left_check_test1(testCase)
            addpath('../../src');
            chess2_1 = move_2_1();
            matrix = [2,2,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess2_1.init_move(matrix,2)
            result = chess2_1.left_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.3.2.2
        function move_2_1_left_check_test2(testCase)
            addpath('../../src');
            chess2_1 = move_2_1();
            matrix = [7,2,2,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess2_1.init_move(matrix,2)
            result = chess2_1.left_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.3.2.3
        function move_2_1_left_check_test3(testCase)
            addpath('../../src');
            chess2_1 = move_2_1();
            matrix = [0,2,2,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess2_1.init_move(matrix,2)
            result = chess2_1.left_check(matrix);
            testCase.verifyEqual(result,true)
            close all force;
            
        end
        %T1.3.3.1
        function move_2_1_right_check_test1(testCase)
            addpath('../../src');
            chess2_1 = move_2_1();
            matrix = [0,0,2,2;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess2_1.init_move(matrix,2)
            result = chess2_1.right_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.3.3.2
        function move_2_1_right_check_test2(testCase)
            addpath('../../src');
            chess2_1 = move_2_1();
            matrix = [2,2,3,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess2_1.init_move(matrix,2)
            result = chess2_1.right_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.3.3.3
        function move_2_1_right_check_test3(testCase)
            addpath('../../src');
            chess2_1 = move_2_1();
            matrix = [2,2,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess2_1.init_move(matrix,2)
            result = chess2_1.right_check(matrix);
            testCase.verifyEqual(result,true)
            close all force;
        end
        %T1.3.4.1
        function move_2_1_up_check_test1(testCase)
            addpath('../../src');
            chess2_1 = move_2_1();
            matrix = [2,2,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess2_1.init_move(matrix,2)
            result = chess2_1.up_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.3.4.2
        function move_2_1_up_check_test2(testCase)
            addpath('../../src');
            chess2_1 = move_2_1();
            matrix = [0,7,0,0;2,2,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess2_1.init_move(matrix,2)
            result = chess2_1.up_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.3.4.3
        function move_2_1_up_check_test3(testCase)
            addpath('../../src');
            chess2_1 = move_2_1();
            matrix = [0,0,0,0;2,2,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess2_1.init_move(matrix,2)
            result = chess2_1.up_check(matrix);
            testCase.verifyEqual(result,true)
            close all force;
        end
        %T1.3.5.1
        function move_2_1_down_check_test1(testCase)
            addpath('../../src');
            chess2_1 = move_2_1();
            matrix = [0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,2,2,0];
            chess2_1.init_move(matrix,2)
            result = chess2_1.down_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.3.5.2
        function move_2_1_down_check_test2(testCase)
            addpath('../../src');
            chess2_1 = move_2_1();
            matrix = [2,2,0,0;0,7,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess2_1.init_move(matrix,2)
            result = chess2_1.down_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
         %T1.3.5.3
        function move_2_1_down_check_test3(testCase)
            addpath('../../src');
            chess2_1 = move_2_1();
            matrix = [2,2,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess2_1.init_move(matrix,2)
            result = chess2_1.down_check(matrix);
            testCase.verifyEqual(result,true)
            close all force;
        end
        %T1.4.1.1
        function move_1_2_init_test(testCase)
            addpath('../../src');
            chess1_2 = move_1_2();
            matrix = [3,0,0,0;3,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess1_2.init_move(matrix,3)
            testCase.verifyEqual(chess1_2.get_row(),[1,2])
            testCase.verifyEqual(chess1_2.get_column(),1)
            close all force;
        end
        %T1.4.2.1
        function move_1_2_left_check_test1(testCase)
            addpath('../../src');
            chess1_2 = move_1_2();
            matrix = [3,0,0,0;3,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess1_2.init_move(matrix,3)
            result = chess1_2.left_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.4.2.2
        function move_1_2_left_check_test2(testCase)
            addpath('../../src');
            chess1_2 = move_1_2();
            matrix = [7,3,0,0;0,3,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess1_2.init_move(matrix,3)
            result = chess1_2.left_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.4.2.3
        function move_1_2_left_check_test3(testCase)
            addpath('../../src');
            chess1_2 = move_1_2();
            matrix = [0,3,0,0;0,3,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess1_2.init_move(matrix,3)
            result = chess1_2.left_check(matrix);
            testCase.verifyEqual(result,true)
            close all force;
            
        end
        %T1.4.3.1
        function move_1_2_right_check_test1(testCase)
            addpath('../../src');
            chess1_2 = move_1_2();
            matrix = [0,0,0,3;0,0,0,3;0,0,0,0;0,0,0,0;0,0,0,0];
            chess1_2.init_move(matrix,3)
            result = chess1_2.right_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.4.3.2
        function move_1_2_right_check_test2(testCase)
            addpath('../../src');
            chess1_2 = move_1_2();
            matrix = [0,3,7,0;0,3,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess1_2.init_move(matrix,3)
            result = chess1_2.right_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.4.3.3
        function move_1_2_right_check_test3(testCase)
            addpath('../../src');
            chess1_2 = move_1_2();
            matrix = [0,3,0,0;0,3,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess1_2.init_move(matrix,3)
            result = chess1_2.right_check(matrix);
            testCase.verifyEqual(result,true)
            close all force;
        end
        %T1.4.4.1
        function move_1_2_up_check_test1(testCase)
            addpath('../../src');
            chess1_2 = move_1_2();
            matrix = [0,3,0,0;0,3,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess1_2.init_move(matrix,3)
            result = chess1_2.up_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.4.4.2
        function move_1_2_up_check_test2(testCase)
            addpath('../../src');
            chess1_2 = move_1_2();
            matrix = [0,7,0,0;0,3,0,0;0,3,0,0;0,0,0,0;0,0,0,0];
            chess1_2.init_move(matrix,3)
            result = chess1_2.up_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.4.4.3
        function move_1_2_up_check_test3(testCase)
            addpath('../../src');
            chess1_2 = move_1_2();
            matrix = [0,0,0,0;0,3,0,0;0,3,0,0;0,0,0,0;0,0,0,0];
            chess1_2.init_move(matrix,3)
            result = chess1_2.up_check(matrix);
            testCase.verifyEqual(result,true)
            close all force;
        end
        %T1.4.5.1
        function move_1_2_down_check_test1(testCase)
            addpath('../../src');
            chess1_2 = move_1_2();
            matrix = [0,0,0,0;0,0,0,0;0,0,0,0;0,3,0,0;0,3,0,0];
            chess1_2.init_move(matrix,3)
            result = chess1_2.down_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.4.5.2
        function move_1_2_down_check_test2(testCase)
            addpath('../../src');
            chess1_2 = move_1_2();
            matrix = [0,0,0,0;0,0,0,0;0,3,0,0;0,3,0,0;0,7,0,0];
            chess1_2.init_move(matrix,3)
            result = chess1_2.down_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
         %T1.4.5.3
        function move_1_2_down_check_test3(testCase)
            addpath('../../src');
            chess1_2 = move_1_2();
            matrix = [0,0,0,0;0,0,0,0;0,3,0,0;0,3,0,0;0,0,0,0];
            chess1_2.init_move(matrix,3)
            result = chess1_2.down_check(matrix);
            testCase.verifyEqual(result,true)
            close all force;
        end
        %T1.5.1.1
        function move_1_1_init_test(testCase)
            addpath('../../src');
            chess1_1 = move_1_1();
            matrix = [7,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess1_1.init_move(matrix,7)
            testCase.verifyEqual(chess1_1.get_row(),1)
            testCase.verifyEqual(chess1_1.get_column(),1)
            close all force;
        end
        %T1.5.2.1
        function move_1_1_left_check_test1(testCase)
            addpath('../../src');
            chess1_1 = move_1_1();
            matrix = [7,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess1_1.init_move(matrix,7)
            result = chess1_1.left_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.5.2.2
        function move_1_1_left_check_test2(testCase)
            addpath('../../src');
            chess1_1 = move_1_1();
            matrix = [8,7,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess1_1.init_move(matrix,7)
            result = chess1_1.left_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.5.2.3
        function move_1_1_left_check_test3(testCase)
            addpath('../../src');
            chess1_1 = move_1_1();
            matrix = [0,7,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess1_1.init_move(matrix,7)
            result = chess1_1.left_check(matrix);
            testCase.verifyEqual(result,true)
            close all force;
            
        end
        %T1.5.3.1
        function move_1_1_right_check_test1(testCase)
            addpath('../../src');
            chess1_1 = move_1_1();
            matrix = [0,0,0,7;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess1_1.init_move(matrix,7)
            result = chess1_1.right_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.5.3.2
        function move_1_1_right_check_test2(testCase)
            addpath('../../src');
            chess1_1 = move_1_1();
            matrix = [0,0,7,8;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess1_1.init_move(matrix,7)
            result = chess1_1.right_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.5.3.3
        function move_1_1_right_check_test3(testCase)
            addpath('../../src');
            chess1_1 = move_1_1();
            matrix = [0,0,7,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess1_1.init_move(matrix,7)
            result = chess1_1.right_check(matrix);
            testCase.verifyEqual(result,true)
            close all force;
        end
        %T1.5.4.1
        function move_1_1_up_check_test1(testCase)
            addpath('../../src');
            chess1_1 = move_1_1();
            matrix = [0,0,7,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess1_1.init_move(matrix,7)
            result = chess1_1.up_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.5.4.2
        function move_1_1_up_check_test2(testCase)
            addpath('../../src');
            chess1_1 = move_1_1();
            matrix = [0,0,8,0;0,0,7,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess1_1.init_move(matrix,7)
            result = chess1_1.up_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.5.4.3
        function move_1_1_up_check_test3(testCase)
            addpath('../../src');
            chess1_1 = move_1_1();
            matrix = [0,0,0,0;0,0,7,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess1_1.init_move(matrix,7)
            result = chess1_1.up_check(matrix);
            testCase.verifyEqual(result,true)
            close all force;
        end
        %T1.5.5.1
        function move_1_1_down_check_test1(testCase)
            addpath('../../src');
            chess1_1 = move_1_1();
            matrix = [0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0;0,0,7,0];
            chess1_1.init_move(matrix,7)
            result = chess1_1.down_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
        %T1.5.5.2
        function move_1_1_down_check_test2(testCase)
            addpath('../../src');
            chess1_1 = move_1_1();
            matrix = [0,0,0,0;0,0,7,0;0,0,8,0;0,0,0,0;0,0,0,0];
            chess1_1.init_move(matrix,7)
            result = chess1_1.down_check(matrix);
            testCase.verifyEqual(result,false)
            close all force;
        end
         %T1.5.5.3
        function move_1_1_down_check_test3(testCase)
            addpath('../../src');
            chess1_1 = move_1_1();
            matrix = [0,0,0,0;0,0,7,0;0,0,0,0;0,0,0,0;0,0,0,0];
            chess1_1.init_move(matrix,7)
            result = chess1_1.down_check(matrix);
            testCase.verifyEqual(result,true)
            close all force;
        end

    end
end

