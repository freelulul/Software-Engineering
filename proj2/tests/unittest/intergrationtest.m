classdef intergrationtest< matlab.uitest.TestCase
    %INTERGRATIONTEST 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        ui
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
        
        %T3.1.1
        function menu_starttest1(testCase)
            testCase.start2()
            pause(5)
            testCase.ui.DropDown.Value = '关卡1';
            testCase.press(testCase.ui.start)
            pause(2)
            close all force;
        end
        %T3.1.2
        function menu_starttest2(testCase)
            pause(2)
            testCase.start2()
            testCase.ui.DropDown.Value = '关卡2';
            testCase.press(testCase.ui.start)
            pause(2)
            close all force;
        end
        %T3.1.3
        function menu_starttest3(testCase)
            pause(2)
            testCase.start2()
            testCase.ui.DropDown.Value = '关卡3';
            testCase.press(testCase.ui.start)
            pause(2)
            close all force;
        end
        %T3.1.4
        function menu_starttest4(testCase)
            pause(2)
            testCase.start2()
            testCase.ui.DropDown.Value = '关卡4';
            testCase.press(testCase.ui.start)
            pause(2)
            close all force;
        end
        %T3.1.5
        function menu_returntest1(testCase)
            pause(2)
            matrix = [1,1,2,2;1,1,3,4;6,5,3,4;6,5,7,9;8,10,0,0];
            testCase.start(matrix,0)
            testCase.press(testCase.ui.menu)
            pause(2)
            close all force;
        end
        %T3.2.1
        function menu_historytest(testCase)
            pause(2)
            testCase.start2()
            testCase.press(testCase.ui.getHistory)
            pause(2)
            close all force;
        end
        %T3.2.2
        function menu_returntest2(testCase)
            pause(2)
            testCase.start3()
            pause(10)
            testCase.press(testCase.ui.Button)
            pause(2)
            close all force;
        end
        %T3.3.1
        function menu_customizetest(testCase)
            pause(2)
            testCase.start2()
            testCase.press(testCase.ui.define)
            pause(2)
            close all force;
        end
        %T3.3.2
        function menu_returntest3(testCase)
            pause(2)
            testCase.start1()
            testCase.press(testCase.ui.Button_22)
            pause(2)
            close all force;
        end
        %T3.4
        function win_level(testCase)
            matrix = [3,4,5,0;3,4,5,6;2,2,7,6;8,0,1,1;9,10,1,1];
            testCase.start(matrix,1)
            testCase.press(testCase.ui.chess1_2_3)
            testCase.press(testCase.ui.up_move)
            testCase.press(testCase.ui.chess1_1_0)
            testCase.press(testCase.ui.right_move)
            testCase.press(testCase.ui.chess2_1)
            testCase.press(testCase.ui.right_move)
            testCase.press(testCase.ui.chess1_1_1)
            testCase.press(testCase.ui.up_move)
            testCase.press(testCase.ui.chess1_1_2)
            testCase.press(testCase.ui.up_move)
            testCase.press(testCase.ui.chess1_1_3)
            testCase.press(testCase.ui.left_move)
            testCase.press(testCase.ui.chess1_1_3)
            testCase.press(testCase.ui.right_move)
            testCase.press(testCase.ui.chess1_1_3)
            testCase.press(testCase.ui.left_move)
            testCase.press(testCase.ui.chess2_2)
            testCase.press(testCase.ui.left_move)
            testCase.verifyEqual(testCase.ui.score_board.Text,'Win!')
            pause(5)
            close all force;
            testCase.start3()
            pause(10)
            close all force;
        end
        %T3.5
        function reset_move(testCase)
            matrix = [3,4,5,0;3,4,5,6;2,2,7,6;8,0,1,1;9,10,1,1];
            testCase.start(matrix,1)
            testCase.press(testCase.ui.chess1_2_3)
            testCase.press(testCase.ui.up_move)
            testCase.press(testCase.ui.chess1_1_0)
            testCase.press(testCase.ui.right_move)
            testCase.press(testCase.ui.chess2_1)
            testCase.press(testCase.ui.right_move)
            testCase.press(testCase.ui.chess1_1_1)
            testCase.press(testCase.ui.up_move)
            testCase.press(testCase.ui.chess1_1_2)
            testCase.press(testCase.ui.up_move)
            testCase.press(testCase.ui.chess1_1_3)
            testCase.press(testCase.ui.left_move)
            testCase.press(testCase.ui.chess1_1_3)
            testCase.press(testCase.ui.right_move)
            testCase.press(testCase.ui.chess1_1_3)
            testCase.press(testCase.ui.left_move)
            testCase.press(testCase.ui.chess2_2)
            testCase.press(testCase.ui.left_move)
            testCase.verifyEqual(testCase.ui.score_board.Text,'Win!')
            testCase.press(testCase.ui.reset)
            testCase.verifyEqual(testCase.ui.board.get_chessboard(),matrix)
            testCase.verifyEqual(testCase.ui.score_board.Text,'0')
            pause(5)
            close all force;
        end
        %T3.6
        function back_move(testCase)
            matrix = [3,4,5,0;3,4,5,6;2,2,7,6;8,0,1,1;9,10,1,1];
            testCase.start(matrix,1)
            testCase.press(testCase.ui.chess1_2_3)
            testCase.press(testCase.ui.up_move)
            testCase.press(testCase.ui.chess1_1_0)
            testCase.press(testCase.ui.right_move)
            testCase.press(testCase.ui.chess2_1)
            testCase.press(testCase.ui.right_move)
            testCase.press(testCase.ui.chess1_1_1)
            testCase.press(testCase.ui.up_move)
            testCase.press(testCase.ui.chess1_1_2)
            testCase.press(testCase.ui.up_move)
            testCase.press(testCase.ui.chess1_1_3)
            testCase.press(testCase.ui.left_move)
            testCase.press(testCase.ui.chess1_1_3)
            testCase.press(testCase.ui.right_move)
            testCase.press(testCase.ui.chess1_1_3)
            testCase.press(testCase.ui.left_move)
            testCase.press(testCase.ui.chess2_2)
            testCase.press(testCase.ui.left_move)
            testCase.verifyEqual(testCase.ui.score_board.Text,'Win!')
            testCase.press(testCase.ui.back)
            testCase.press(testCase.ui.back)
            testCase.press(testCase.ui.back)
            pause(5)
            close all force;
        end
        %T3.7
        function next_level(testCase)
            matrix = [3,4,5,0;3,4,5,6;2,2,7,6;8,0,1,1;9,10,1,1];
            testCase.start(matrix,1)
            testCase.press(testCase.ui.chess1_2_3)
            testCase.press(testCase.ui.up_move)
            testCase.press(testCase.ui.chess1_1_0)
            testCase.press(testCase.ui.right_move)
            testCase.press(testCase.ui.chess2_1)
            testCase.press(testCase.ui.right_move)
            testCase.press(testCase.ui.chess1_1_1)
            testCase.press(testCase.ui.up_move)
            testCase.press(testCase.ui.chess1_1_2)
            testCase.press(testCase.ui.up_move)
            testCase.press(testCase.ui.chess1_1_3)
            testCase.press(testCase.ui.left_move)
            testCase.press(testCase.ui.chess1_1_3)
            testCase.press(testCase.ui.right_move)
            testCase.press(testCase.ui.chess1_1_3)
            testCase.press(testCase.ui.left_move)
            testCase.press(testCase.ui.chess2_2)
            testCase.press(testCase.ui.left_move)
            testCase.verifyEqual(testCase.ui.score_board.Text,'Win!')
            testCase.press(testCase.ui.Button)
            pause(5)
            testCase.press(testCase.ui.Button)
            pause(5)
            testCase.press(testCase.ui.Button)
            pause(5)
            testCase.press(testCase.ui.chess2_1)
            testCase.press(testCase.ui.down_move)
            testCase.press(testCase.ui.Button)
            pause(5)
            close all force;
        end
        %T3.8
        function ask_for_help(testCase)
            matrix = [3,4,5,0;3,4,5,6;2,2,7,6;8,0,1,1;9,10,1,1];
            testCase.start(matrix,1)
            testCase.press(testCase.ui.Button_2)
            pause(5)
            close all force;
        end
        %T3.9
        function reset_chessboard(testCase)
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
            pause(5)
            testCase.press(testCase.ui.Button_21)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),zeros(5,4))
            pause(5)
            close all force
        end
        %T3.10
        function finish_chessboard(testCase)
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
        %T3.11.1
        function putting_andrelease_test1(testCase)
            testCase.start1()
            testCase.press(testCase.ui.B1)
            testCase.press(testCase.ui.Button_2)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[0 1 1 0 ;0 1 1 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.Button)
            testCase.verifyEqual(testCase.ui.Label.Text,'请选择操作按键')
            pause(2)
            testCase.press(testCase.ui.B1)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),zeros(5,4))
            testCase.press(testCase.ui.B7)
            testCase.press(testCase.ui.Button_2)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[0 7 0 0 ;0 0 0 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.B1)
            testCase.press(testCase.ui.Button)
            testCase.verifyEqual(testCase.ui.Label.Text,'无效操作')
            pause(2)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[0 7 0 0 ;0 0 0 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.B7)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),zeros(5,4))
            testCase.press(testCase.ui.B7)
            testCase.press(testCase.ui.Button_5)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[0 0 0 0 ;7 0 0 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.B1)
            testCase.press(testCase.ui.Button)
            testCase.verifyEqual(testCase.ui.Label.Text,'无效操作')
            pause(2)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[0 0 0 0 ;7 0 0 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.B7)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),zeros(5,4))
            testCase.press(testCase.ui.B7)
            testCase.press(testCase.ui.Button_6)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[0 0 0 0 ;0 7 0 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.B1)
            testCase.press(testCase.ui.Button)
            testCase.verifyEqual(testCase.ui.Label.Text,'无效操作')
            pause(2)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[0 0 0 0 ;0 7 0 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.B7)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),zeros(5,4))
            close all force
        end
        %T3.11.2
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
            pause(2)
            testCase.press(testCase.ui.B1)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),zeros(5,4))
            testCase.press(testCase.ui.B2)
            testCase.press(testCase.ui.Button_2)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[0 2 2 0 ;0 0 0 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            pause(2)
            close all force
        end
        %T3.11.3
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
            pause(2)
            close all force
        end
        %T3.11.4
        function putting_and_releasetest(testCase)
            testCase.start1()
            testCase.press(testCase.ui.B1)
            testCase.press(testCase.ui.Button)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 0 0 ;1 1 0 0 ;0 0 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.B2)
            testCase.press(testCase.ui.Button_9)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 0 0 ;1 1 0 0 ;2 2 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.B3)
            testCase.press(testCase.ui.Button_3)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 0 ;1 1 3 0 ;2 2 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.B4)
            testCase.press(testCase.ui.Button_4)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 4 ;1 1 3 4 ;2 2 0 0 ; 0 0 0 0; 0 0 0 0])
            testCase.press(testCase.ui.B5)
            testCase.press(testCase.ui.Button_13)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 4 ;1 1 3 4 ;2 2 0 0 ; 5 0 0 0; 5 0 0 0])
            testCase.press(testCase.ui.B6)
            testCase.press(testCase.ui.Button_14)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 4 ;1 1 3 4 ;2 2 0 0 ; 5 6 0 0; 5 6 0 0])
            testCase.press(testCase.ui.B7)
            testCase.press(testCase.ui.Button_11)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 4 ;1 1 3 4 ;2 2 7 0 ; 5 6 0 0; 5 6 0 0])
            testCase.press(testCase.ui.B8)
            testCase.press(testCase.ui.Button_12)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 4 ;1 1 3 4 ;2 2 7 8 ; 5 6 0 0; 5 6 0 0])
            testCase.press(testCase.ui.B9)
            testCase.press(testCase.ui.Button_15)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 4 ;1 1 3 4 ;2 2 7 8 ; 5 6 9 0; 5 6 0 0])
            testCase.press(testCase.ui.B10)
            testCase.press(testCase.ui.Button_16)
            testCase.verifyEqual(testCase.ui.chessboard.get_chessboard(),[1 1 3 4 ;1 1 3 4 ;2 2 7 8 ; 5 6 9 10; 5 6 0 0])
            pause(5)
            testCase.press(testCase.ui.B1)
            pause(2)
            testCase.press(testCase.ui.B2)
            pause(2)
            testCase.press(testCase.ui.B3)
            pause(2)
            testCase.press(testCase.ui.B4)
            pause(2)
            testCase.press(testCase.ui.B5)
            pause(2)
            testCase.press(testCase.ui.B6)
            pause(2)
            testCase.press(testCase.ui.B7)
            pause(2)
            testCase.press(testCase.ui.B8)
            pause(2)
            testCase.press(testCase.ui.B9)
            pause(2)
            testCase.press(testCase.ui.B10)
            pause(2)
            close all force;
        end
        %T3.12
        function history_change(testCase)
            matrix = [3,4,5,0;3,4,5,6;2,2,7,6;8,0,1,1;9,10,1,1];
            testCase.start(matrix,1)
            testCase.press(testCase.ui.chess1_2_3)
            testCase.press(testCase.ui.up_move)
            testCase.press(testCase.ui.chess1_1_0)
            testCase.press(testCase.ui.right_move)
            testCase.press(testCase.ui.chess2_1)
            testCase.press(testCase.ui.right_move)
            testCase.press(testCase.ui.chess1_1_1)
            testCase.press(testCase.ui.up_move)
            testCase.press(testCase.ui.chess1_1_2)
            testCase.press(testCase.ui.up_move)
            testCase.press(testCase.ui.chess1_1_3)
            testCase.press(testCase.ui.left_move)
            testCase.press(testCase.ui.chess1_1_3)
            testCase.press(testCase.ui.right_move)
            testCase.press(testCase.ui.chess1_1_3)
            testCase.press(testCase.ui.left_move)
            testCase.press(testCase.ui.chess2_2)
            testCase.press(testCase.ui.left_move)
            testCase.verifyEqual(testCase.ui.score_board.Text,'Win!')
            pause(5)
            close all force;
            testCase.start3()
            pause(10)
            close all force;
            matrix = [3,4,5,0;3,4,5,6;2,2,7,6;8,0,1,1;9,10,1,1];
            testCase.start(matrix,1)
            testCase.press(testCase.ui.chess1_2_3)
            testCase.press(testCase.ui.up_move)
            testCase.press(testCase.ui.chess1_1_0)
            testCase.press(testCase.ui.right_move)
            testCase.press(testCase.ui.chess2_1)
            testCase.press(testCase.ui.right_move)
            testCase.press(testCase.ui.chess1_1_1)
            testCase.press(testCase.ui.up_move)
            testCase.press(testCase.ui.chess1_1_2)
            testCase.press(testCase.ui.up_move)
            testCase.press(testCase.ui.chess1_1_3)
            testCase.press(testCase.ui.left_move)
            testCase.press(testCase.ui.chess2_2)
            testCase.press(testCase.ui.left_move)
            testCase.verifyEqual(testCase.ui.score_board.Text,'Win!')
            pause(5)
            close all force;
            testCase.start3()
            pause(10)
            close all force;
        end
    end
end

