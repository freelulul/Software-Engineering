classdef define_back
    %DEFINT_BACK 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        ui
    end
    
    methods
            function obj = define_back(front)
                %DEFINT_BACK 构造此类的实例
                %   此处显示详细说明
                obj.ui = front;
            end
            
            function lock_func(obj,button_number)
                switch(button_number)
                    case 1
                        obj.ui.Button.Value = 0;
                        obj.ui.Button.Enable = false;
                        obj.ui.Button.Text = num2str(obj.ui.operating_button);
                    case 2
                        obj.ui.Button_2.Value = 0;
                        obj.ui.Button_2.Enable = false;
                        obj.ui.Button_2.Text = num2str(obj.ui.operating_button);
                    case 3
                        obj.ui.Button_3.Value = 0;
                        obj.ui.Button_3.Enable = false; 
                        obj.ui.Button_3.Text = num2str(obj.ui.operating_button);
                    case 4
                        obj.ui.Button_4.Value = 0;
                        obj.ui.Button_4.Enable = false; 
                        obj.ui.Button_4.Text = num2str(obj.ui.operating_button);
                    case 5
                        obj.ui.Button_5.Value = 0;
                        obj.ui.Button_5.Enable = false; 
                        obj.ui.Button_5.Text = num2str(obj.ui.operating_button);
                    case 6
                        obj.ui.Button_6.Value = 0;
                        obj.ui.Button_6.Enable = false; 
                        obj.ui.Button_6.Text = num2str(obj.ui.operating_button);
                    case 7
                        obj.ui.Button_7.Value = 0;
                        obj.ui.Button_7.Enable = false; 
                        obj.ui.Button_7.Text = num2str(obj.ui.operating_button);
                    case 8
                        obj.ui.Button_8.Value = 0;
                        obj.ui.Button_8.Enable = false; 
                        obj.ui.Button_8.Text = num2str(obj.ui.operating_button);
                    case 9
                        obj.ui.Button_9.Value = 0;
                        obj.ui.Button_9.Enable = false; 
                        obj.ui.Button_9.Text = num2str(obj.ui.operating_button);
                    case 10
                        obj.ui.Button_10.Value = 0;
                        obj.ui.Button_10.Enable = false; 
                        obj.ui.Button_10.Text = num2str(obj.ui.operating_button);
                    case 11
                        obj.ui.Button_11.Value = 0;
                        obj.ui.Button_11.Enable = false; 
                        obj.ui.Button_11.Text = num2str(obj.ui.operating_button);
                    case 12
                        obj.ui.Button_12.Value = 0;
                        obj.ui.Button_12.Enable = false; 
                        obj.ui.Button_12.Text = num2str(obj.ui.operating_button);
                    case 13
                        obj.ui.Button_13.Value = 0;
                        obj.ui.Button_13.Enable = false; 
                        obj.ui.Button_13.Text = num2str(obj.ui.operating_button);
                    case 14
                        obj.ui.Button_14.Value = 0;
                        obj.ui.Button_14.Enable = false; 
                        obj.ui.Button_14.Text = num2str(obj.ui.operating_button);
                    case 15
                        obj.ui.Button_15.Value = 0;
                        obj.ui.Button_15.Enable = false; 
                        obj.ui.Button_15.Text = num2str(obj.ui.operating_button);
                    case 16
                        obj.ui.Button_16.Value = 0;
                        obj.ui.Button_16.Enable = false; 
                        obj.ui.Button_16.Text = num2str(obj.ui.operating_button);
                    case 17
                        obj.ui.Button_17.Value = 0;
                        obj.ui.Button_17.Enable = false; 
                        obj.ui.Button_17.Text = num2str(obj.ui.operating_button);
                    case 18
                        obj.ui.Button_18.Value = 0;
                        obj.ui.Button_18.Enable = false; 
                        obj.ui.Button_18.Text = num2str(obj.ui.operating_button);
                    case 19
                        obj.ui.Button_19.Value = 0;
                        obj.ui.Button_19.Enable = false; 
                        obj.ui.Button_19.Text = num2str(obj.ui.operating_button);
                    case 20
                        obj.ui.Button_20.Value = 0;
                        obj.ui.Button_20.Enable = false; 
                        obj.ui.Button_20.Text = num2str(obj.ui.operating_button);
    
                end
            end
    
            function release_func(obj,button_number)
                switch(button_number)
                    case 1
                        obj.ui.Button.Value = 0;
                        obj.ui.Button.Enable = true;
                        obj.ui.Button.Text = '';
                    case 2
                        obj.ui.Button_2.Value = 0;
                        obj.ui.Button_2.Enable = true;   
                        obj.ui.Button_2.Text = '';
                    case 3
                        obj.ui.Button_3.Value = 0;
                        obj.ui.Button_3.Enable = true; 
                        obj.ui.Button_3.Text = '';
                    case 4
                        obj.ui.Button_4.Value = 0;
                        obj.ui.Button_4.Enable = true; 
                        obj.ui.Button_4.Text = '';
                    case 5
                        obj.ui.Button_5.Value = 0;
                        obj.ui.Button_5.Enable = true; 
                        obj.ui.Button_5.Text = '';
                    case 6
                        obj.ui.Button_6.Value = 0;
                        obj.ui.Button_6.Enable = true; 
                        obj.ui.Button_6.Text = '';
                    case 7
                        obj.ui.Button_7.Value = 0;
                        obj.ui.Button_7.Enable = true; 
                        obj.ui.Button_7.Text = '';
                    case 8
                        obj.ui.Button_8.Value = 0;
                        obj.ui.Button_8.Enable = true; 
                        obj.ui.Button_8.Text = '';
                    case 9
                        obj.ui.Button_9.Value = 0;
                        obj.ui.Button_9.Enable = true; 
                        obj.ui.Button_9.Text = '';
                    case 10
                        obj.ui.Button_10.Value = 0;
                        obj.ui.Button_10.Enable = true; 
                        obj.ui.Button_10.Text = '';
                    case 11
                        obj.ui.Button_11.Value = 0;
                        obj.ui.Button_11.Enable = true; 
                        obj.ui.Button_11.Text = '';
                    case 12
                        obj.ui.Button_12.Value = 0;
                        obj.ui.Button_12.Enable = true; 
                        obj.ui.Button_12.Text = '';
                    case 13
                        obj.ui.Button_13.Value = 0;
                        obj.ui.Button_13.Enable = true; 
                        obj.ui.Button_13.Text = '';
                    case 14
                        obj.ui.Button_14.Value = 0;
                        obj.ui.Button_14.Enable = true; 
                        obj.ui.Button_14.Text = '';
                    case 15
                        obj.ui.Button_15.Value = 0;
                        obj.ui.Button_15.Enable = true; 
                        obj.ui.Button_15.Text = '';
                    case 16
                        obj.ui.Button_16.Value = 0;
                        obj.ui.Button_16.Enable = true; 
                        obj.ui.Button_16.Text = '';
                    case 17
                        obj.ui.Button_17.Value = 0;
                        obj.ui.Button_17.Enable = true; 
                        obj.ui.Button_17.Text = '';
                    case 18
                        obj.ui.Button_18.Value = 0;
                        obj.ui.Button_18.Enable = true; 
                        obj.ui.Button_18.Text = '';
                    case 19
                        obj.ui.Button_19.Value = 0;
                        obj.ui.Button_19.Enable = true; 
                        obj.ui.Button_19.Text = '';
                    case 20
                        obj.ui.Button_20.Value = 0;
                        obj.ui.Button_20.Enable = true; 
                        obj.ui.Button_20.Text = '';
    
                end
            end
    
            function invalid_operation(obj,button_number)
                        obj.ui.Label.Text = '无效操作'; 
                        obj.release_func(button_number)
                    end
            
            function put_chess(obj,button_number,row,col)
                switch (obj.ui.operating_button) 
                    case 0 
                        obj.ui.Label.Text = '请选择操作按键'; 
                        obj.release_func(button_number)
                    case 1
                        switch(obj.ui.chessboard.put_chess(1,row,col)) 
                            case 1 
                                obj.invalid_operation(button_number)
                                obj.ui.B1.Value = 0;
                            case 2
                                obj.ui.B1_space = [button_number button_number+1 button_number+4 button_number+5];
                               for i = 1:4
                                 obj.lock_func(obj.ui.B1_space(i))
                               end
                               obj.ui.Label.Text = '按钮放置'; 
                               obj.ui.B1_put = true;
                            case 3
                               obj.invalid_operation(button_number)
                               obj.ui.B1.Value = 0;
                        end
                    case 2
                        switch(obj.ui.chessboard.put_chess(2,row,col)) 
                            case 1 
                               obj.invalid_operation(button_number)
                               obj.ui.B2.Value = 0;
                            case 2
                                obj.ui.B2_space = [button_number button_number+1];
                                for i = 1:2
                                    obj.lock_func(obj.ui.B2_space(i))
                                end
                               obj.ui.Label.Text = '按钮放置'; 
                               obj.ui.B2_put = true;
                            case 3
                               obj.invalid_operation(button_number)
                               obj.ui.B2.Value = 0;
                        end
                        
                    case 3
                        switch(obj.ui.chessboard.put_chess(3,row,col)) 
                            case 1 
                                obj.invalid_operation(button_number)
                                obj.ui.B3.Value = 0;
                            case 2
                                obj.ui.B3_space = [button_number button_number+4];
                                for i = 1:2
                                    obj.lock_func(obj.ui.B3_space(i))
                                end 
                               obj.ui.Label.Text = '按钮放置'; 
                               obj.ui.B3_put = true;
                            case 3
                                obj.invalid_operation(button_number)
                                obj.ui.B3.Value = 0;
                        end
        
                    case 4
                        switch(obj.ui.chessboard.put_chess(4,row,col)) 
                            case 1 
                                obj.invalid_operation(button_number)
                                obj.ui.B4.Value = 0;
                            case 2
                                obj.ui.B4_space = [button_number button_number+4];
                                for i = 1:2
                                    obj.lock_func(obj.ui.B4_space(i))
                                end
                                obj.ui.Label.Text = '按钮放置'; 
                                obj.ui.B4_put = true;
                            case 3
                                obj.invalid_operation(button_number)
                                obj.ui.B4.Value = 0;
                        end
                        
                    case 5
                        switch(obj.ui.chessboard.put_chess(5,row,col)) 
                            case 1 
                                obj.invalid_operation(button_number)
                                obj.ui.B5.Value = 0;
                            case 2
                                obj.ui.B5_space = [button_number button_number+4];
                                for i = 1:2
                                    obj.lock_func(obj.ui.B5_space(i))
                                end
                               obj.ui.Label.Text = '按钮放置'; 
                               obj.ui.B5_put = true;
                            case 3
                                obj.invalid_operation(button_number)
                                obj.ui.B5.Value = 0;
                        end
                    case 6
                        switch(obj.ui.chessboard.put_chess(6,row,col)) 
                            case 1 
                               obj.invalid_operation(button_number)
                               obj.ui.B6.Value = 0;
                            case 2
                                obj.ui.B6_space = [button_number button_number+4];
                                for i = 1:2
                                    obj.lock_func(obj.ui.B6_space(i))
                                end
                               obj.ui.Label.Text = '按钮放置'; 
                               obj.ui.B6_put = true;
                            case 3
                               obj.invalid_operation(button_number)
                               obj.ui.B6.Value = 0;
                        end
                    case 7
                        switch(obj.ui.chessboard.put_chess(7,row,col)) 
                            case 1 
                                obj.invalid_operation(button_number)
                                obj.ui.B7.Value = 0;
                            case 2
                                obj.ui.B7_space = button_number;
                                obj.lock_func(obj.ui.B7_space)
                                obj.ui.Label.Text = '按钮放置'; 
                                obj.ui.B7_put = true;
                            case 3
                                obj.invalid_operation(button_number)
                                obj.ui.B7.Value = 0;
                        end
                    case 8
                        switch(obj.ui.chessboard.put_chess(8,row,col)) 
                            case 1 
                                obj.invalid_operation(button_number)
                                obj.ui.B8.Value = 0;
                            case 2
                                obj.ui.B8_space = button_number;
                                obj.lock_func(obj.ui.B8_space)
                                obj.ui.Label.Text = '按钮放置'; 
                                obj.ui.B8_put = true;
                            case 3
                                obj.invalid_operation(button_number)
                                obj.ui.B8.Value = 0;
                        end
                    case 9
                        switch(obj.ui.chessboard.put_chess(9,row,col)) 
                            case 1 
                                obj.invalid_operation(button_number)
                                obj.ui.B9.Value = 0;
                            case 2
                                obj.ui.B9_space = button_number;
                                obj.lock_func(obj.ui.B9_space)
                                obj.ui.Label.Text = '按钮放置'; 
                                obj.ui.B9_put = true;
                            case 3
                                obj.invalid_operation(button_number)
                                obj.ui.B9.Value = 0;
                        end
                    case 10
                        switch(obj.ui.chessboard.put_chess(10,row,col)) 
                            case 1 
                                obj.invalid_operation(button_number)
                                obj.ui.B9.Value = 0;
                            case 2
                                obj.ui.B10_space = button_number;
                                obj.lock_func(obj.ui.B10_space)
                                obj.ui.Label.Text = '按钮放置'; 
                                obj.ui.B10_put = true;
                            case 3
                                obj.invalid_operation(button_number)
                                obj.ui.B9.Value = 0;
                        end
        
                end
            end

        function release_button2_2(obj,button,number)
            if button
                    for i = 1:4
                        obj.release_func(button(i))
                    end
                    obj.ui.operating_button = 0;
                    obj.ui.chessboard.release_chess(number)
            end

        end
        function release_button2_1(obj,button,number)
            if button
                    for i = 1:2
                        obj.release_func(button(i))
                    end
                    obj.ui.operating_button = 0;
                    obj.ui.chessboard.release_chess(number)
                    
            end

        end

        function release_button1_1(obj,button,number)
            if button
                    obj.release_func(button)
                    obj.ui.operating_button = 0;
                    obj.ui.chessboard.release_chess(number)
            end

        end
        
        function release_chess(obj,button_number)
            switch(button_number)
                case 1
                    obj.ui.B1.Value = 0;
                case 2
                    obj.ui.B2.Value = 0;
                case 3 
                    obj.ui.B3.Value = 0;
                case 4
                    obj.ui.B4.Value = 0;
                case 5
                    obj.ui.B5.Value = 0;
                case 6 
                    obj.ui.B6.Value = 0;
                case 7
                    obj.ui.B7.Value = 0;
                case 8
                    obj.ui.B8.Value = 0;
                case 9 
                    obj.ui.B9.Value = 0;
                case 10
                    obj.ui.B10.Value = 0;
            end
        end

    end

end