classdef move_1_1 <handle
    %MOVE_1_1 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties(Access = private)
        position_row   %1*1 size
        position_column % 1*1 size
    end
    
    methods(Access = public)
        function init_move(chess,chessboard,botton_num)
            %get the position of the botton
            for i = 1:5 %row
                for t = 1:4 %column
                    if chessboard(i,t) == botton_num
                        chess.position_row = i;
                        chess.position_column = t;
                        return
                    end
                end
            end
            
        end
        
        function output = get_row(chess)
            output = chess.position_row;
        end
        
        function output = get_column(chess)
            output = chess.position_column;
        end


        function result = left_check(chess,chessboard)
            % check 0 around the button
            left = false;
            %left?
            if chess.position_column ~= 1
                if chessboard(chess.position_row,chess.position_column-1) == 0
                    left = true;
                end
            end
            result = left;
        end

        function result = right_check(chess,chessboard)
            % check 0 around the button
            right = false;
            %right
            if chess.position_column ~= 4
                if chessboard(chess.position_row,chess.position_column+1) == 0
                    right = true;
                end
            end
            result = right;
        end

        function result = up_check(chess,chessboard)
            % check 0 around the button
            up = false;
            %up
            if chess.position_row ~= 1
                if chessboard(chess.position_row-1,chess.position_column) == 0
                    up = true;
                end
            end
            result = up;
        end

        function result = down_check(chess,chessboard)
            % check 0 around the button
            down = false;
            %down
            if chess.position_row ~= 5
                if chessboard(chess.position_row+1,chess.position_column) == 0
                    down = true;
                end
            end
            result = down;
        end
        
        function left_move(chess)
            chess.position_column = chess.position_column - 1;
        end

        function right_move(chess)
            chess.position_column = chess.position_column + 1;
        end

        function up_move(chess)
            chess.position_row = chess.position_row -1;
        end

        function down_move(chess)
            chess.position_row = chess.position_row +1;
        end
    end
end

