classdef functionaltest < matlab.uitest.TestCase
    %FUNCTIONALTEST 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        ui;
    end

    methods
        function start(self,matrix,level)
            addpath('../../src');
            board = chessboard();
            board.init_board(matrix)
            self.ui = app_play();
            step_controller = step(self.ui);
            history_chessboard = history();
            self.ui.init_history(history_chessboard)
            self.ui.Stepconstructer(step_controller,level)
            board.init_ui(self.ui)
            self.ui.init_chessboard(board)
            self.addTeardown(@delete, self.ui);
        end        
        function start1(self)
            addpath('../../src');
            board = chessboard();
            self.ui = app_define();
            back  = define_back(self.ui);
            self.ui.init_define(board,back)
        end  
        function  start2(self)
            addpath('../../src');
            self.ui = app_menu();
            board = chessboard();
            matrix = [3 1 1 4 ; 3 1 1 4;5 2 2 6;5 8 9 6;7 0 0 10];
            board.init_board(matrix)
            self.ui.init(board)
        end
        function start3(self)
            addpath('../../src');
            self.ui = app_history();
            back  = history_backend(self.ui);
            self.ui.init(back)
        end
    end
    methods(Test)
        %T2.1 2_2 left move false
        %T2.1.1.1 left move false because of edge
        function unit_2_2test_left1(testCase)
            matrix = [1,1,2,2;1,1,3,4;6,5,3,4;6,5,7,9;8,10,0,0];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_2)
            testCase.press(testCase.ui.left_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move2_2.get_row(),[1,2])
            testCase.verifyEqual(testCase.ui.move2_2.get_column(),[1,2])
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.1.1.2 left move false because of no empty space
        function unit_2_2test_left2(testCase)
            matrix = [3 1 1 4 ; 3 1 1 4;5 2 2 6;5 8 9 6;7 0 0 10];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_2)
            testCase.press(testCase.ui.left_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move2_2.get_row(),[1,2])
            testCase.verifyEqual(testCase.ui.move2_2.get_column(),[2,3])
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.1.1.3
        %left move success
        function unit_2_2test_left3(testCase)
            matrix = [0,1,1,6;0,1,1,6;5,2,2,4;5,3,9,4;7,3,10,8];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_2)
            testCase.press(testCase.ui.left_move)
            testCase.verifyEqual(testCase.ui.move2_2.get_row(),[1,2])
            testCase.verifyEqual(testCase.ui.move2_2.get_column(),[1,2])
            testCase.verifyEqual(testCase.ui.score_board.Text,'1')
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),[1,1,0,6;1,1,0,6;5,2,2,4;5,3,9,4;7,3,10,8])
            close all force;
        end
        %T2.1.2.1 
        % up move false because of edge
        function unit_2_2test_up1(testCase)
            matrix = [1,1,2,2;1,1,3,4;6,5,3,4;6,5,7,9;8,10,0,0];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_2)
            testCase.press(testCase.ui.up_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move2_2.get_row(),[1,2])
            testCase.verifyEqual(testCase.ui.move2_2.get_column(),[1,2])
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.1.2.2 
        % up move false because of no emtpy space
        function unit_2_2test_up2(testCase)
            matrix = [6,2,2,5;6,1,1,5;4,1,1,3;4,9,7,3;8,0,0,10];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_2)
            testCase.press(testCase.ui.up_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move2_2.get_row(),[2,3])
            testCase.verifyEqual(testCase.ui.move2_2.get_column(),[2,3])
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.1.2.3 
        % up move successfully
        function unit_2_2test_up3(testCase)
            matrix = [6,0,0,5;6,1,1,5;4,1,1,3;4,9,7,3;8,2,2,10];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_2)
            testCase.press(testCase.ui.up_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),[6,1,1,5;6,1,1,5;4,0,0,3;4,9,7,3;8,2,2,10])
            testCase.verifyEqual(testCase.ui.move2_2.get_row(),[1,2])
            testCase.verifyEqual(testCase.ui.move2_2.get_column(),[2,3])
            testCase.verifyEqual(testCase.ui.score_board.Text,'1')
            close all force;
        end
        %T2.1.3.1 right move false because of edge
        function unit_2_2test_right1(testCase)
            matrix = [3 4 1 1 ; 3 4 1 1;5 2 2 6;5 8 9 6;7 0 0 10];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_2)
            testCase.press(testCase.ui.right_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move2_2.get_row(),[1,2])
            testCase.verifyEqual(testCase.ui.move2_2.get_column(),[3,4])
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.1.3.2 right move false because of no empty space
        function unit_2_2test_right2(testCase)
            matrix = [3 1 1 4 ; 3 1 1 4;5 2 2 6;5 8 9 6;7 0 0 10];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_2)
            testCase.press(testCase.ui.right_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move2_2.get_row(),[1,2])
            testCase.verifyEqual(testCase.ui.move2_2.get_column(),[2,3])
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.1.3.3 right move successfully
        function unit_2_2test_right3(testCase)
            matrix = [3 1 1 0 ; 3 1 1 0;5 4 7 6;5 4 9 6;8 2 2 10];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_2)
            testCase.press(testCase.ui.right_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),[3 0 1 1 ; 3 0 1 1;5 4 7 6;5 4 9 6;8 2 2 10])
            testCase.verifyEqual(testCase.ui.move2_2.get_row(),[1,2])
            testCase.verifyEqual(testCase.ui.move2_2.get_column(),[3,4])
            testCase.verifyEqual(testCase.ui.score_board.Text,'1')
            close all force;
        end
        %T2.1.4.1
        function unit_2_2test_down1(testCase)
            matrix = [5,2,2,6;5,4,3,6;7,4,3,9;1,1,8,0;1,1,10,0];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_2)
            testCase.press(testCase.ui.down_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move2_2.get_row(),[4,5])
            testCase.verifyEqual(testCase.ui.move2_2.get_column(),[1,2])
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.1.4.2
        function unit_2_2test_down2(testCase)
            matrix = [3 1 1 4 ; 3 1 1 4;5 2 2 6;5 8 9 6;7 0 0 10];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_2)
            testCase.press(testCase.ui.down_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move2_2.get_row(),[1,2])
            testCase.verifyEqual(testCase.ui.move2_2.get_column(),[2,3])
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.1.4.3
        function unit_2_2test_down3(testCase)
            matrix = [3 1 1 4 ; 3 1 1 4;5 0 0 6;5 8 9 6;7 2 2 10];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_2)
            testCase.press(testCase.ui.down_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),[3 0 0 4 ; 3 1 1 4;5 1 1 6;5 8 9 6;7 2 2 10])
            testCase.verifyEqual(testCase.ui.move2_2.get_row(),[2,3])
            testCase.verifyEqual(testCase.ui.move2_2.get_column(),[2,3])
            testCase.verifyEqual(testCase.ui.score_board.Text,'1')
            close all force;
        end
        %T2.1 2_1 left move false
        %T2.2.1.1 left move false because of edge
        function unit_2_1test_left1(testCase)
            matrix = [2,2,8,10;1,1,5,6;1,1,5,6;4,7,9,3;4,0,0,3];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_1)
            testCase.press(testCase.ui.left_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move2_1.get_row(),1)
            testCase.verifyEqual(testCase.ui.move2_1.get_column(),[1,2])
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.2.1.2 left move false because of no empty space
        function unit_2_1test_left2(testCase)
            matrix = [8,2,2,10;1,1,5,6;1,1,5,6;4,7,9,3;4,0,0,3];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_1)
            testCase.press(testCase.ui.left_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move2_1.get_row(),1)
            testCase.verifyEqual(testCase.ui.move2_1.get_column(),[2,3])
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.2.1.3
        %left move success
        function unit_2_1test_left3(testCase)
            matrix = [0,2,2,10;1,1,5,6;1,1,5,6;4,7,9,3;4,8,0,3];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_1)
            testCase.press(testCase.ui.left_move)
            testCase.verifyEqual(testCase.ui.move2_1.get_row(),1)
            testCase.verifyEqual(testCase.ui.move2_1.get_column(),[1,2])
            testCase.verifyEqual(testCase.ui.score_board.Text,'1')
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),[2,2,0,10;1,1,5,6;1,1,5,6;4,7,9,3;4,8,0,3])
            close all force;
        end
        %T2.2.2.1 
        % up move false because of edge
        function unit_2_1test_up1(testCase)
            matrix = [6,2,2,5;6,1,1,5;4,1,1,3;4,9,7,3;8,0,0,10];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_1)
            testCase.press(testCase.ui.up_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move2_1.get_row(),1)
            testCase.verifyEqual(testCase.ui.move2_1.get_column(),[2,3])
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.2.2.2 
        % up move false because of no emtpy space
        function unit_2_1test_up2(testCase)
            matrix = [5,7,9,6;5,2,2,6;4,1,1,3;4,1,1,3;8,0,0,10];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_1)
            testCase.press(testCase.ui.up_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move2_1.get_row(),2)
            testCase.verifyEqual(testCase.ui.move2_1.get_column(),[2,3])
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.2.2.3 
        % up move successfully
        function unit_2_1test_up3(testCase)
            matrix = [5,0,0,6;5,2,2,6;4,1,1,3;4,1,1,3;8,7,9,10];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_1)
            testCase.press(testCase.ui.up_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),[5,2,2,6;5,0,0,6;4,1,1,3;4,1,1,3;8,7,9,10])
            testCase.verifyEqual(testCase.ui.move2_1.get_row(),1)
            testCase.verifyEqual(testCase.ui.move2_1.get_column(),[2,3])
            testCase.verifyEqual(testCase.ui.score_board.Text,'1')
            close all force;
        end
        %T2.2.3.1 right move false because of edge
        function unit_2_1test_right1(testCase)
            matrix = [8,10,2,2;1,1,5,6;1,1,5,6;4,7,9,3;4,0,0,3];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_1)
            testCase.press(testCase.ui.right_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move2_1.get_row(),1)
            testCase.verifyEqual(testCase.ui.move2_1.get_column(),[3,4])
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.2.3.2 right move false because of no empty space
        function unit_2_1test_right2(testCase)
            matrix = [2,2,8,10;1,1,5,6;1,1,5,6;4,7,9,3;4,0,0,3];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_1)
            testCase.press(testCase.ui.right_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move2_1.get_row(),1)
            testCase.verifyEqual(testCase.ui.move2_1.get_column(),[1,2])
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.2.3.3 right move successfully
        function unit_2_1test_right3(testCase)
            matrix = [2,2,0,10;1,1,5,6;1,1,5,6;4,7,9,3;4,8,0,3];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_1)
            testCase.press(testCase.ui.right_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),[0,2,2,10;1,1,5,6;1,1,5,6;4,7,9,3;4,8,0,3])
            testCase.verifyEqual(testCase.ui.move2_1.get_row(),1)
            testCase.verifyEqual(testCase.ui.move2_1.get_column(),[2,3])
            testCase.verifyEqual(testCase.ui.score_board.Text,'1')
            close all force;
        end
        %T2.2.4.1
        function unit_2_1test_down1(testCase)
            matrix = [0,1,1,0;4,1,1,3;4,9,7,3;5,8,10,6;5,2,2,6];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_1)
            testCase.press(testCase.ui.down_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move2_1.get_row(),5)
            testCase.verifyEqual(testCase.ui.move2_1.get_column(),[2,3])
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.2.4.2
        function unit_2_1test_down2(testCase)
            matrix = [0,1,1,0;4,1,1,3;4,9,7,3;5,2,2,6;5,8,10,6];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_1)
            testCase.press(testCase.ui.down_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move2_1.get_row(),4)
            testCase.verifyEqual(testCase.ui.move2_1.get_column(),[2,3])
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.2.4.3
        function unit_2_1test_down3(testCase)
            matrix = [8,1,1,10;4,1,1,3;4,9,7,3;5,2,2,6;5,0,0,6];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_1)
            testCase.press(testCase.ui.down_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),[8,1,1,10;4,1,1,3;4,9,7,3;5,0,0,6;5,2,2,6])
            testCase.verifyEqual(testCase.ui.move2_1.get_row(),5)
            testCase.verifyEqual(testCase.ui.move2_1.get_column(),[2,3])
            testCase.verifyEqual(testCase.ui.score_board.Text,'1')
            close all force;
        end
        %T2.3.1 2_2 left move false
        %T2.3.1.1 left move false because of edge
        function unit_1_2test_left1(testCase)
            matrix = [3,1,1,4;3,1,1,4;5,2,2,6;5,7,8,6;9,0,0,10];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_2_0)
            testCase.press(testCase.ui.left_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_row(),[1,2])
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_column(),1)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.3.1.2 left move false because of no empty space
        function unit_1_2test_left2(testCase)
            matrix = [4,1,1,3;4,1,1,3;5,2,2,6;5,7,8,6;9,0,0,10];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_2_0)
            testCase.press(testCase.ui.left_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_row(),[1,2])
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_column(),4)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.3.1.3
        %left move success
        function unit_1_2test_left3(testCase)
            matrix = [1,1,0,3;1,1,0,3;2,2,6,5;4,9,6,5;4,10,7,8];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_2_0)
            testCase.press(testCase.ui.left_move)
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_row(),[1,2])
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_column(),3)
            testCase.verifyEqual(testCase.ui.score_board.Text,'1')
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),[1,1,3,0;1,1,3,0;2,2,6,5;4,9,6,5;4,10,7,8])
            close all force;
        end
        %T2.3.2.1 
        % up move false because of edge
        function unit_1_2test_up1(testCase)
            matrix = [3,1,1,4;3,1,1,4;5,2,2,6;5,7,8,6;9,0,0,10];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_2_0)
            testCase.press(testCase.ui.up_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_row(),[1,2])
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_column(),1)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.3.2.2 
        % up move false because of no emtpy space
        function unit_1_2test_up2(testCase)
            matrix = [5,1,1,4;5,1,1,4;3,2,2,6;3,7,8,6;9,0,0,10];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_2_0)
            testCase.press(testCase.ui.up_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_row(),[3,4])
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_column(),1)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.3.2.3 
        % up move successfully
        function unit_1_2test_up3(testCase)
            matrix = [0,1,1,6;0,1,1,6;3,2,2,9;3,5,4,10;7,5,4,8];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_2_0)
            testCase.press(testCase.ui.up_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),[0,1,1,6;3,1,1,6;3,2,2,9;0,5,4,10;7,5,4,8])
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_row(),[2,3])
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_column(),1)
            testCase.verifyEqual(testCase.ui.score_board.Text,'1')
            close all force;
        end
        %T2.3.3.1 right move false because of edge
        function unit_1_2test_right1(testCase)
            matrix = [4,1,1,3;4,1,1,3;5,2,2,6;5,7,8,6;9,0,0,10];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_2_0)
            testCase.press(testCase.ui.right_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_row(),[1,2])
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_column(),4)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.3.3.2 right move false because of no empty space
        function unit_1_2test_right2(testCase)
            matrix = [3 1 1 4 ; 3 1 1 4;5 2 2 6;5 8 9 6;7 0 0 10];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_2_0)
            testCase.press(testCase.ui.right_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_row(),[1,2])
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_column(),1)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.3.3.3 right move successfully
        function unit_1_2test_right3(testCase)
            matrix = [3,0,1,1;3,0,1,1;2,2,6,5;4,9,6,5;4,10,7,8];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_2_0)
            testCase.press(testCase.ui.right_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),[0,3,1,1;0,3,1,1;2,2,6,5;4,9,6,5;4,10,7,8])
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_row(),[1,2])
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_column(),2)
            testCase.verifyEqual(testCase.ui.score_board.Text,'1')
            close all force;
        end
        %T2.3.4.1
        function unit_1_2test_down1(testCase)
            matrix = [7,8,9,10;5,2,2,4;5,1,1,4;3,1,1,6;3,0,0,6];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_2_0)
            testCase.press(testCase.ui.down_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_row(),[4,5])
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_column(),1)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.3.4.2
        function unit_1_2test_down2(testCase)
            matrix = [7,8,9,10;3,2,2,4;3,1,1,4;5,1,1,6;5,0,0,6];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_2_0)
            testCase.press(testCase.ui.down_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_row(),[2,3])
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_column(),1)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.3.4.3
        function unit_1_2test_down3(testCase)
            matrix = [5,8,9,10;5,2,2,4;3,1,1,4;3,1,1,6;0,7,0,6];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_2_0)
            testCase.press(testCase.ui.down_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),[5,8,9,10;5,2,2,4;0,1,1,4;3,1,1,6;3,7,0,6])
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_row(),[4,5])
            testCase.verifyEqual(testCase.ui.move_1_2_0.get_column(),1)
            testCase.verifyEqual(testCase.ui.score_board.Text,'1')
            close all force;
        end
        %T2.4.1 2_2 left move false
        %T2.4.1.1 left move false because of edge
        function unit_1_1test_left1(testCase)
            matrix = [7,8,9,10;3,2,2,4;3,1,1,4;5,1,1,6;5,0,0,6];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_1_0)
            testCase.press(testCase.ui.left_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_row(),1)
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_column(),1)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.4.1.2 left move false because of no empty space
        function unit_1_1test_left2(testCase)
            matrix = [8,7,9,10;3,2,2,4;3,1,1,4;5,1,1,6;5,0,0,6];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_1_0)
            testCase.press(testCase.ui.left_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_row(),1)
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_column(),2)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.4.1.3
        %left move success
        function unit_1_1test_left3(testCase)
            matrix = [0,7,9,10;3,2,2,4;3,1,1,4;5,1,1,6;5,8,0,6];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_1_0)
            testCase.press(testCase.ui.left_move)
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_row(),1)
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_column(),1)
            testCase.verifyEqual(testCase.ui.score_board.Text,'1')
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),[7,0,9,10;3,2,2,4;3,1,1,4;5,1,1,6;5,8,0,6])
            close all force;
        end
        %T2.4.2.1 
        % up move false because of edge
        function unit_1_1test_up1(testCase)
            matrix = [7,8,9,10;3,2,2,4;3,1,1,4;5,1,1,6;5,0,0,6];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_1_0)
            testCase.press(testCase.ui.up_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_row(),1)
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_column(),1)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.4.2.2 
        % up move false because of no emtpy space
        function unit_1_1test_up2(testCase)
            matrix = [10,9,8,0;5,7,0,6;5,2,2,6;1,1,4,3;1,1,4,3];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_1_0)
            testCase.press(testCase.ui.up_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_row(),2)
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_column(),2)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.4.2.3 
        % up move successfully
        function unit_1_1test_up3(testCase)
            matrix = [10,0,8,9;5,7,0,6;5,2,2,6;1,1,4,3;1,1,4,3];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_1_0)
            testCase.press(testCase.ui.up_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),[10,7,8,9;5,0,0,6;5,2,2,6;1,1,4,3;1,1,4,3])
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_row(),1)
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_column(),2)
            testCase.verifyEqual(testCase.ui.score_board.Text,'1')
            close all force;
        end
        %T2.4.3.1 right move false because of edge
        function unit_1_1test_right1(testCase)
            matrix = [10,9,8,7;5,0,0,6;5,2,2,6;1,1,4,3;1,1,4,3];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_1_0)
            testCase.press(testCase.ui.right_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_row(),1)
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_column(),4)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.4.3.2 right move false because of no empty space
        function unit_1_1test_right2(testCase)
            matrix = [10,9,8,0;5,0,7,6;5,2,2,6;1,1,4,3;1,1,4,3];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_1_0)
            testCase.press(testCase.ui.right_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_row(),2)
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_column(),3)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.4.3.3 right move successfully
        function unit_1_1test_right3(testCase)
            matrix = [10,9,8,0;5,7,0,6;5,2,2,6;1,1,4,3;1,1,4,3];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_1_0)
            testCase.press(testCase.ui.right_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),[10,9,8,0;5,0,7,6;5,2,2,6;1,1,4,3;1,1,4,3])
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_row(),2)
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_column(),3)
            testCase.verifyEqual(testCase.ui.score_board.Text,'1')
            close all force;
        end
        %T2.4.4.1
        function unit_1_1test_down1(testCase)
            matrix = [3 1 1 4 ; 3 1 1 4;5 2 2 6;5 8 9 6;7 0 0 10];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_1_0)
            testCase.press(testCase.ui.down_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_row(),5)
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_column(),1)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.4.4.2
        function unit_1_1test_down2(testCase)
            matrix = [10,9,8,0;5,7,0,6;5,2,2,6;1,1,4,3;1,1,4,3];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_1_0)
            testCase.press(testCase.ui.down_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_row(),2)
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_column(),2)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.4.4.3
        function unit_1_1test_down3(testCase)
            matrix = [10,7,8,9;5,0,0,6;5,2,2,6;1,1,4,3;1,1,4,3];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess1_1_0)
            testCase.press(testCase.ui.down_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),[10,0,8,9;5,7,0,6;5,2,2,6;1,1,4,3;1,1,4,3])
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_row(),2)
            testCase.verifyEqual(testCase.ui.move_1_1_0.get_column(),2)
            testCase.verifyEqual(testCase.ui.score_board.Text,'1')
            close all force;
        end
        %T2.5.1 check_win
        function win_test1(testCase)
            matrix = [7,0,0,8;4,9,10,3;4,2,2,3;5,1,1,6;5,1,1,6];
            testCase.start(matrix,0)
            testCase.verifyEqual(testCase.ui.score_board.Text,'Win!')
            close all force;
        end
        %T2.5.2 check_win
        function win_test2(testCase)
            matrix = [7,2,2,8;4,9,10,3;4,1,1,3;5,1,1,6;5,0,0,6];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_2)
            testCase.press(testCase.ui.down_move)
            testCase.verifyEqual(testCase.ui.score_board.Text,'Win!')
            close all force;
        end
        %T2.6.1
        function putting_chess2_2_test1(testCase)
            testCase.start1()
            testCase.press(testCase.ui.B1)
            testCase.press(testCase.ui.Button_2)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[0 1 1 0 ;0 1 1 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.Button)
            testCase.verifyEqual(testCase.ui.Label.Text,'请选择操作按键')
            testCase.press(testCase.ui.B1)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),zeros(5,4))
            testCase.press(testCase.ui.B7)
            testCase.press(testCase.ui.Button_2)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[0 7 0 0 ;0 0 0 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.B1)
            testCase.press(testCase.ui.Button)
            testCase.verifyEqual(testCase.ui.Label.Text,'无效操作')
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[0 7 0 0 ;0 0 0 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.B7)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),zeros(5,4))
            testCase.press(testCase.ui.B7)
            testCase.press(testCase.ui.Button_5)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[0 0 0 0 ;7 0 0 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.B1)
            testCase.press(testCase.ui.Button)
            testCase.verifyEqual(testCase.ui.Label.Text,'无效操作')
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[0 0 0 0 ;7 0 0 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.B7)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),zeros(5,4))
            testCase.press(testCase.ui.B7)
            testCase.press(testCase.ui.Button_6)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[0 0 0 0 ;0 7 0 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.B1)
            testCase.press(testCase.ui.Button)
            testCase.verifyEqual(testCase.ui.Label.Text,'无效操作')
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[0 0 0 0 ;0 7 0 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.B7)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),zeros(5,4))
            close all force
        end
        %T2.7
        function putting_chess2_1_test2(testCase)
            testCase.start1()
            testCase.press(testCase.ui.B1)
            testCase.press(testCase.ui.Button_2)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[0 1 1 0 ;0 1 1 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.B2)
            testCase.press(testCase.ui.Button_2)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[0 1 1 0 ;0 1 1 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.Button)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[0 1 1 0 ;0 1 1 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.verifyEqual(testCase.ui.Label.Text,'无效操作')
            testCase.press(testCase.ui.B1)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),zeros(5,4))
            testCase.press(testCase.ui.B2)
            testCase.press(testCase.ui.Button_2)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[0 2 2 0 ;0 0 0 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            close all force
        end
        %T2.8
        function putting_chess1_2_test2(testCase)
            testCase.start1()
            testCase.press(testCase.ui.B3)
            testCase.press(testCase.ui.Button)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[3 0 0 0 ;3 0 0 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.B3)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),zeros(5,4))
            testCase.press(testCase.ui.B7)
            testCase.press(testCase.ui.Button_5)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[0 0 0 0 ;7 0 0 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.B3)
            testCase.press(testCase.ui.Button)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[0 0 0 0 ;7 0 0 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.verifyEqual(testCase.ui.Label.Text,'无效操作')
            close all force
        end
        %T2.9.1
        function finish_chessboard1(testCase)
            testCase.start1()
            testCase.press(testCase.ui.B1)
            testCase.press(testCase.ui.Button)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 0 0 ;1 1 0 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.play)
            testCase.verifyEqual(testCase.ui.Label.Text,'未完成所有按钮的初始化')
            testCase.press(testCase.ui.B2)
            testCase.press(testCase.ui.Button_9)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 0 0 ;1 1 0 0 ;2 2 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.play)
            testCase.verifyEqual(testCase.ui.Label.Text,'未完成所有按钮的初始化')
            testCase.press(testCase.ui.B3)
            testCase.press(testCase.ui.Button_3)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 0 ;1 1 3 0 ;2 2 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.play)
            testCase.verifyEqual(testCase.ui.Label.Text,'未完成所有按钮的初始化')
            testCase.press(testCase.ui.B4)
            testCase.press(testCase.ui.Button_4)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 4 ;1 1 3 4 ;2 2 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.play)
            testCase.verifyEqual(testCase.ui.Label.Text,'未完成所有按钮的初始化')
            testCase.press(testCase.ui.B5)
            testCase.press(testCase.ui.Button_13)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 4 ;1 1 3 4 ;2 2 0 0 ; 5 0 0 0; 5 0 0 0])
            testCase.press(testCase.ui.play)
            testCase.verifyEqual(testCase.ui.Label.Text,'未完成所有按钮的初始化')
            testCase.press(testCase.ui.B6)
            testCase.press(testCase.ui.Button_14)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 4 ;1 1 3 4 ;2 2 0 0 ; 5 6 0 0; 5 6 0 0])
            testCase.press(testCase.ui.play)
            testCase.verifyEqual(testCase.ui.Label.Text,'未完成所有按钮的初始化')
            testCase.press(testCase.ui.B7)
            testCase.press(testCase.ui.Button_11)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 4 ;1 1 3 4 ;2 2 7 0 ; 5 6 0 0; 5 6 0 0])
            testCase.press(testCase.ui.play)
            testCase.verifyEqual(testCase.ui.Label.Text,'未完成所有按钮的初始化')
            testCase.press(testCase.ui.B8)
            testCase.press(testCase.ui.Button_12)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 4 ;1 1 3 4 ;2 2 7 8 ; 5 6 0 0; 5 6 0 0])
            testCase.press(testCase.ui.play)
            testCase.verifyEqual(testCase.ui.Label.Text,'未完成所有按钮的初始化')
            testCase.press(testCase.ui.B9)
            testCase.press(testCase.ui.Button_15)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 4 ;1 1 3 4 ;2 2 7 8 ; 5 6 9 0; 5 6 0 0])
            testCase.press(testCase.ui.play)
            testCase.verifyEqual(testCase.ui.Label.Text,'未完成所有按钮的初始化')
            testCase.press(testCase.ui.B10)
            testCase.press(testCase.ui.Button_16)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 4 ;1 1 3 4 ;2 2 7 8 ; 5 6 9 10; 5 6 0 0])
            testCase.press(testCase.ui.Button_21)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),zeros(5,4))
            pause(5)
            close all force
        end
        %T2.9.2
        function finish_chessboard2(testCase)
            testCase.start1()
            testCase.press(testCase.ui.B1)
            testCase.press(testCase.ui.Button)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 0 0 ;1 1 0 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.play)
            testCase.verifyEqual(testCase.ui.Label.Text,'未完成所有按钮的初始化')
            testCase.press(testCase.ui.B2)
            testCase.press(testCase.ui.Button_9)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 0 0 ;1 1 0 0 ;2 2 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.play)
            testCase.verifyEqual(testCase.ui.Label.Text,'未完成所有按钮的初始化')
            testCase.press(testCase.ui.B3)
            testCase.press(testCase.ui.Button_3)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 0 ;1 1 3 0 ;2 2 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.play)
            testCase.verifyEqual(testCase.ui.Label.Text,'未完成所有按钮的初始化')
            testCase.press(testCase.ui.B4)
            testCase.press(testCase.ui.Button_4)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 4 ;1 1 3 4 ;2 2 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.play)
            testCase.verifyEqual(testCase.ui.Label.Text,'未完成所有按钮的初始化')
            testCase.press(testCase.ui.B5)
            testCase.press(testCase.ui.Button_13)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 4 ;1 1 3 4 ;2 2 0 0 ; 5 0 0 0; 5 0 0 0])
            testCase.press(testCase.ui.play)
            testCase.verifyEqual(testCase.ui.Label.Text,'未完成所有按钮的初始化')
            testCase.press(testCase.ui.B6)
            testCase.press(testCase.ui.Button_14)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 4 ;1 1 3 4 ;2 2 0 0 ; 5 6 0 0; 5 6 0 0])
            testCase.press(testCase.ui.play)
            testCase.verifyEqual(testCase.ui.Label.Text,'未完成所有按钮的初始化')
            testCase.press(testCase.ui.B7)
            testCase.press(testCase.ui.Button_11)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 4 ;1 1 3 4 ;2 2 7 0 ; 5 6 0 0; 5 6 0 0])
            testCase.press(testCase.ui.play)
            testCase.verifyEqual(testCase.ui.Label.Text,'未完成所有按钮的初始化')
            testCase.press(testCase.ui.B8)
            testCase.press(testCase.ui.Button_12)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 4 ;1 1 3 4 ;2 2 7 8 ; 5 6 0 0; 5 6 0 0])
            testCase.press(testCase.ui.play)
            testCase.verifyEqual(testCase.ui.Label.Text,'未完成所有按钮的初始化')
            testCase.press(testCase.ui.B9)
            testCase.press(testCase.ui.Button_15)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 4 ;1 1 3 4 ;2 2 7 8 ; 5 6 9 0; 5 6 0 0])
            testCase.press(testCase.ui.play)
            testCase.verifyEqual(testCase.ui.Label.Text,'未完成所有按钮的初始化')
            testCase.press(testCase.ui.B10)
            testCase.press(testCase.ui.Button_16)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 4 ;1 1 3 4 ;2 2 7 8 ; 5 6 9 10; 5 6 0 0])
            testCase.press(testCase.ui.play)
            pause(5)
            close all force
        end
        %T2.10.1
        function chessboard_rule1(testCase)
            testCase.start1()
            testCase.press(testCase.ui.B1)
            testCase.verifyEqual(testCase.ui.B1.Value,true)
            testCase.verifyEqual(testCase.ui.operating_button,1)
            testCase.press(testCase.ui.B2)
            testCase.verifyEqual(testCase.ui.B1.Value,false)
            testCase.verifyEqual(testCase.ui.B2.Value,true)
            testCase.verifyEqual(testCase.ui.operating_button,2)
            close all force
        end
        %T2.10.2
        function chessboard_rule2(testCase)
            testCase.start1()
            testCase.press(testCase.ui.B1)
            testCase.verifyEqual(testCase.ui.B1.Value,true)
            testCase.verifyEqual(testCase.ui.operating_button,1)
            testCase.press(testCase.ui.Button)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 0 0 ;1 1 0 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.verifyEqual(testCase.ui.B1.Value,true)
            testCase.verifyEqual(testCase.ui.operating_button,0)
            testCase.press(testCase.ui.B2)
            testCase.verifyEqual(testCase.ui.B2.Value,true)
            testCase.verifyEqual(testCase.ui.operating_button,2)
            testCase.press(testCase.ui.B1)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),zeros(5,4))
            testCase.verifyEqual(testCase.ui.operating_button,0)
            testCase.verifyEqual(testCase.ui.B1.Value,false)
            testCase.verifyEqual(testCase.ui.B2.Value,false)
            close all force
        end
        %T2.11
        function back_test(testCase)
            matrix = [10,7,8,9;5,0,0,6;5,2,2,6;1,1,4,3;1,1,4,3];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.back)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            testCase.press(testCase.ui.chess1_1_0)
            testCase.press(testCase.ui.down_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),[10,0,8,9;5,7,0,6;5,2,2,6;1,1,4,3;1,1,4,3])
            testCase.verifyEqual(testCase.ui.score_board.Text,'1')
            testCase.press(testCase.ui.back)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.12
        function reset_test(testCase)
            matrix = [10,7,8,9;5,0,0,6;5,2,2,6;1,1,4,3;1,1,4,3];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.back)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            testCase.press(testCase.ui.chess1_1_0)
            testCase.press(testCase.ui.down_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),[10,0,8,9;5,7,0,6;5,2,2,6;1,1,4,3;1,1,4,3])
            testCase.verifyEqual(testCase.ui.score_board.Text,'1')
            testCase.press(testCase.ui.chess1_1_3)
            testCase.press(testCase.ui.right_move)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),[0,10,8,9;5,7,0,6;5,2,2,6;1,1,4,3;1,1,4,3])
            testCase.verifyEqual(testCase.ui.score_board.Text,'2')
            testCase.press(testCase.ui.reset)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.13
        function next_level_test(testCase)
            matrix = [10,7,8,9;5,0,0,6;5,2,2,6;1,1,4,3;1,1,4,3];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.Button)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),testCase.ui.board.mat1)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            testCase.press(testCase.ui.Button)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),testCase.ui.board.mat2)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            testCase.press(testCase.ui.Button)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),testCase.ui.board.mat3)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            testCase.press(testCase.ui.Button)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),testCase.ui.board.mat4)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            testCase.press(testCase.ui.Button)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),testCase.ui.board.mat4)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            close all force;
        end
        %T2.14
        function choose_one_chess(testCase)
            matrix = [10,7,8,9;5,0,0,6;5,2,2,6;1,1,4,3;1,1,4,3];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.chess2_2)
            testCase.verifyEqual(testCase.ui.operating_chess_number,1)
            testCase.press(testCase.ui.chess2_1)
            testCase.verifyEqual(testCase.ui.operating_chess_number,2)
            testCase.press(testCase.ui.chess1_2_0)
            testCase.verifyEqual(testCase.ui.operating_chess_number,3)
            testCase.press(testCase.ui.chess1_2_1)
            testCase.verifyEqual(testCase.ui.operating_chess_number,4)
            close all force;
        end

        
    end
end

