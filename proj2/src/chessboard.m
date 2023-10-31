classdef chessboard < handle
    %CHESSBOARD 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties(Access = public)
        ui
        ChessBoard   
        mat1 = [3,4,5,0;3,4,5,6;2,2,7,6;8,0,1,1;9,10,1,1]
        mat2 = [2 2 8 6 ; 5 1 1 6 ;5 1 1 3;4 0 0 3;4 10 9 7]
        mat3 = [0 1 1 0 ; 3 1 1 4 ;3 5 6 4 ;7 5 6 8;2 2 9 10]
        mat4 = [3 1 1 4 ; 3 1 1 4 ;7 8 9 10;5 2 2 6;5 0 0 6]
    end
    
    methods(Access = public)
        function init_board(board,matrix)
            %no input
            board.ChessBoard = matrix ;
        end
        function init_ui(board,front)
            board.ui = front;
        end
        function result = get_chessboard(chessboard)
            result = chessboard.ChessBoard;
        end

        function chess_init(board)
            % botton 1
            board.ui.move2_2.init_move(board.ChessBoard,1);  
            board.ui.chess2_2.Layout.Row = board.ui.move2_2.get_row();
            board.ui.chess2_2.Layout.Column = board.ui.move2_2.get_column();
            % botton 2
            board.ui.move2_1.init_move(board.ChessBoard,2);  
            board.ui.chess2_1.Layout.Row = board.ui.move2_1.get_row();
            board.ui.chess2_1.Layout.Column = board.ui.move2_1.get_column();
            % botton 3 
            board.ui.move_1_2_0.init_move(board.ChessBoard,3);
            board.ui.chess1_2_0.Layout.Row = board.ui.move_1_2_0.get_row();
            board.ui.chess1_2_0.Layout.Column = board.ui.move_1_2_0.get_column();
            % botton 4
            board.ui.move_1_2_1.init_move(board.ChessBoard,4);
            board.ui.chess1_2_1.Layout.Row = board.ui.move_1_2_1.get_row();
            board.ui.chess1_2_1.Layout.Column = board.ui.move_1_2_1.get_column();
            % botton 5
            board.ui.move_1_2_2.init_move(board.ChessBoard,5);
            board.ui.chess1_2_2.Layout.Row = board.ui.move_1_2_2.get_row();
            board.ui.chess1_2_2.Layout.Column = board.ui.move_1_2_2.get_column();
            % botton 6
            board.ui.move_1_2_3.init_move(board.ChessBoard,6);
            board.ui.chess1_2_3.Layout.Row = board.ui.move_1_2_3.get_row();
            board.ui.chess1_2_3.Layout.Column = board.ui.move_1_2_3.get_column();
            % botton 7
            board.ui.move_1_1_0.init_move(board.ChessBoard,7);
            board.ui.chess1_1_0.Layout.Row = board.ui.move_1_1_0.get_row();
            board.ui.chess1_1_0.Layout.Column = board.ui.move_1_1_0.get_column();
            % botton 8
            board.ui.move_1_1_1.init_move(board.ChessBoard,8);
            board.ui.chess1_1_1.Layout.Row = board.ui.move_1_1_1.get_row();
            board.ui.chess1_1_1.Layout.Column = board.ui.move_1_1_1.get_column();
            % botton 9
            board.ui.move_1_1_2.init_move(board.ChessBoard,9);
            board.ui.chess1_1_2.Layout.Row = board.ui.move_1_1_2.get_row();
            board.ui.chess1_1_2.Layout.Column = board.ui.move_1_1_2.get_column();
            % botton 10
            board.ui.move_1_1_3.init_move(board.ChessBoard,10);
            board.ui.chess1_1_3.Layout.Row = board.ui.move_1_1_3.get_row();
            board.ui.chess1_1_3.Layout.Column = board.ui.move_1_1_3.get_column();
        end


        function left_update(chessboard,button_number,row,column)
            if button_number == 1
                chessboard.ChessBoard(row(1,1),column(1,2)) = 0;
                chessboard.ChessBoard(row(1,2),column(1,2)) = 0;
                chessboard.ChessBoard(row(1,1),column(1,1)-1) = button_number;
                chessboard.ChessBoard(row(1,2),column(1,1)-1) = button_number;
                return
            elseif button_number == 2
                chessboard.ChessBoard(row,column(1,2)) = 0;
                chessboard.ChessBoard(row,column(1,1)-1) = button_number;
                return
            elseif button_number == 3 || button_number == 4 || button_number == 5 || button_number == 6
                chessboard.ChessBoard(row(1,1),column) = 0;
                chessboard.ChessBoard(row(1,2),column) = 0;
                chessboard.ChessBoard(row(1,1),column-1) = button_number;
                chessboard.ChessBoard(row(1,2),column-1) = button_number;
                return
            elseif button_number == 7 || button_number == 8 || button_number == 9 || button_number == 10  
                chessboard.ChessBoard(row,column) = 0;
                chessboard.ChessBoard(row,column-1) = button_number;
                return
            end
        end
        function right_update(chessboard,button_number,row,column)
            if button_number == 1
                chessboard.ChessBoard(row(1,1),column(1,1)) = 0;
                chessboard.ChessBoard(row(1,2),column(1,1)) = 0;
                chessboard.ChessBoard(row(1,1),column(1,2)+1) = button_number;
                chessboard.ChessBoard(row(1,2),column(1,2)+1) = button_number;
                return
            elseif button_number == 2
                chessboard.ChessBoard(row,column(1,1)) = 0;
                chessboard.ChessBoard(row,column(1,2)+1) = button_number;
                return
            elseif button_number == 3 || button_number == 4 || button_number == 5 || button_number == 6
                chessboard.ChessBoard(row(1,1),column) = 0;
                chessboard.ChessBoard(row(1,2),column) = 0;
                chessboard.ChessBoard(row(1,1),column+1) = button_number;
                chessboard.ChessBoard(row(1,2),column+1) = button_number;
                return
            elseif button_number == 7 || button_number == 8 || button_number == 9 || button_number == 10
                chessboard.ChessBoard(row,column) = 0;
                chessboard.ChessBoard(row,column+1) = button_number;
                return
            end
        end
        function up_update(chessboard,button_number,row,column)
            if button_number == 1
                chessboard.ChessBoard(row(1,2),column(1,1)) = 0;
                chessboard.ChessBoard(row(1,2),column(1,2)) = 0;
                chessboard.ChessBoard(row(1,1)-1,column(1,1)) = button_number;
                chessboard.ChessBoard(row(1,1)-1,column(1,2)) = button_number;
                return
            elseif button_number == 2
                chessboard.ChessBoard(row,column(1,1)) = 0;
                chessboard.ChessBoard(row,column(1,2)) = 0;
                chessboard.ChessBoard(row-1,column(1,1)) = button_number;
                chessboard.ChessBoard(row-1,column(1,2)) = button_number;                
                return
            elseif button_number == 3 || button_number == 4 || button_number == 5 || button_number == 6
                chessboard.ChessBoard(row(1,2),column) = 0;
                chessboard.ChessBoard(row(1,1)-1,column) = button_number;
                return
            elseif button_number == 7 || button_number == 8 || button_number == 9 || button_number == 10
                chessboard.ChessBoard(row,column) = 0;
                chessboard.ChessBoard(row-1,column) = button_number;
                return
            end
        end
        function down_update(chessboard,button_number,row,column)
            if button_number == 1
                chessboard.ChessBoard(row(1,1),column(1,1)) = 0;
                chessboard.ChessBoard(row(1,1),column(1,2)) = 0;
                chessboard.ChessBoard(row(1,2)+1,column(1,1)) = button_number;
                chessboard.ChessBoard(row(1,2)+1,column(1,2)) = button_number;
                return
            elseif button_number == 2
                chessboard.ChessBoard(row,column(1,1)) = 0;
                chessboard.ChessBoard(row,column(1,2)) = 0;
                chessboard.ChessBoard(row+1,column(1,1)) = button_number;
                chessboard.ChessBoard(row+1,column(1,2)) = button_number;                
                return
            elseif button_number == 3 || button_number == 4 || button_number == 5 || button_number == 6
                chessboard.ChessBoard(row(1,1),column) = 0;
                chessboard.ChessBoard(row(1,2)+1,column) = button_number;
                return
            elseif button_number == 7 || button_number == 8 || button_number == 9 || button_number == 10
                chessboard.ChessBoard(row,column) = 0;
                chessboard.ChessBoard(row+1,column) = button_number;
                return
            end
        end
        function result = check_win(chessboard)
            result = false;
            if(chessboard.ChessBoard(5,2) == 1 && chessboard.ChessBoard(5,3) == 1)
                result = true;
            end
        end

        function result = put_chess(chessboard,button_number,row,column)
            % 1 --- no button 
            % 2 --- having space 
            % 3 --- no space
            result = 1;
            if button_number == 1
                %put 2*2 button
                if(row == 5 || column ==  4)
                    result = 3;
                    return
                end
                if chessboard.ChessBoard(row,column) ==0 && chessboard.ChessBoard(row+1,column) == 0 && chessboard.ChessBoard(row,column+1) == 0 && chessboard.ChessBoard(row+1,column+1) == 0
                    chessboard.ChessBoard(row,column) = button_number;
                    chessboard.ChessBoard(row+1,column) = button_number;
                    chessboard.ChessBoard(row,column+1) = button_number;
                    chessboard.ChessBoard(row+1,column+1) = button_number;
                    result = 2;
                    return
                else
                    result = 3;
                    return
                end
            elseif button_number == 2
                %put 1*2 button
                if(column == 4)
                    result = 3;
                    return
                end
                if chessboard.ChessBoard(row,column) ==0 && chessboard.ChessBoard(row,column+1) == 0 
                   chessboard.ChessBoard(row,column) = button_number;
                   chessboard.ChessBoard(row,column+1) = button_number;
                   result = 2;
                   return
                else
                   result = 3;
                   return
                end
            elseif button_number == 3 ||button_number == 4 ||button_number == 5 || button_number ==6 
                %put 2*1 button
                if(row == 5)
                    result = 3;
                    return
                end
                if chessboard.ChessBoard(row,column) ==0 && chessboard.ChessBoard(row+1,column) == 0 
                   chessboard.ChessBoard(row,column) = button_number;
                   chessboard.ChessBoard(row+1,column) = button_number;
                   result = 2;
                   return
                else
                   result = 3;
                   return
                end
            elseif button_number == 7 ||button_number == 8 ||button_number == 9 || button_number == 10
                %put 2*1 button
                if chessboard.ChessBoard(row,column) ==0 
                   chessboard.ChessBoard(row,column) = button_number;
                   result = 2;
                   return
                else
                   result = 3;
                   return
                end
            end
        end

        function  release_chess(chessboard,button_number)
            for i = 1:5
                for m = 1:4
                    if chessboard.ChessBoard(i,m) == button_number
                        chessboard.ChessBoard(i,m) = 0; 
                    end
                end
            end
        end

        function bool = check_chess(chessboard,button_number)
            bool = false;
            for i = 1:5
                for m = 1:4
                    if chessboard.ChessBoard(i,m) == button_number
                        bool = true; 
                    end
                end
            end        
        end
        function nextlevel(board,number)
            switch number
                case 1
                    board.ChessBoard = board.mat1;
                    board.chess_init()
                case 2
                    board.ChessBoard = board.mat2;
                    board.chess_init()
                case 3
                    board.ChessBoard = board.mat3;
                    board.chess_init()
                case 4
                    board.ChessBoard = board.mat4;
                    board.chess_init()
            end
        end
        function create_inf = get_information(board)
            temp = zeros(24,1);
            step = 1;
            for i = 1:5
                for  m= 1:4
                    if board.ChessBoard(i,m) == 0
                        temp(step) = i -1;
                        temp(step) = m -1;
                        step = step +2;
                    end
                end
            end
            row1 = board.ui.move2_2.get_row();
            temp(5) = row1(1)-1;
            col1 = board.ui.move2_2.get_column();
            temp(6) = col1(1)-1;

            row2 = board.ui.move2_1.get_row();
            temp(7) = row2(1)-1;
            col2 = board.ui.move2_1.get_column();
            temp(8) = col2(1)-1;

            row3 = board.ui.move_1_2_0.get_row();
            temp(9) = row3(1)-1;
            col3 = board.ui.move_1_2_0.get_column();
            temp(10) = col3(1)-1;

            row4 = board.ui.move_1_2_1.get_row();
            temp(11) = row4(1)-1;
            col4 = board.ui.move_1_2_1.get_column();
            temp(12) = col4(1)-1;

            row5 = board.ui.move_1_2_2.get_row();
            temp(13) = row5(1)-1;
            col5 = board.ui.move_1_2_2.get_column();
            temp(14) = col5(1)-1;

            row6 = board.ui.move_1_2_3.get_row();
            temp(15) = row6(1)-1;
            col6 = board.ui.move_1_2_3.get_column();
            temp(16) = col6(1)-1;

            row7 = board.ui.move_1_1_0.get_row();
            temp(17) = row7(1)-1;
            col7 = board.ui.move_1_1_0.get_column();
            temp(18) = col7(1)-1;

            row8 = board.ui.move_1_1_1.get_row();
            temp(19) = row8(1)-1;
            col8 = board.ui.move_1_1_1.get_column();
            temp(20) = col8(1)-1;

            row9 = board.ui.move_1_1_2.get_row();
            temp(21) = row9(1)-1;
            col9 = board.ui.move_1_1_2.get_column();
            temp(22) = col9(1)-1;

            row10 = board.ui.move_1_1_3.get_row();
            temp(23) = row10(1)-1;
            col10 = board.ui.move_1_1_3.get_column();
            temp(24) = col10(1)-1;

            create_inf = temp;
        end
    end
end

