classdef history_backend
    %HISTORY_BACKEND 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        ui
    end
    
    methods
        function obj = history_backend(front)
            %HISTORY_BACKEND 构造此类的实例
            %   此处显示详细说明
            obj.ui = front;
        end
        
        function update(obj)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            filename = 'history.csv';
            data = readtable(filename);
            
            row0 = data{1,2};%自定义
            row1 = data{2,2};
            row2 = data{3,2};
            row3 = data{4,2};
            row4 = data{5,2};
            obj.ui.Label.Text = obj.check_data(row1);
            obj.ui.Label_2.Text = obj.check_data(row2);
            obj.ui.Label_3.Text = obj.check_data(row3);
            obj.ui.Label_4.Text = obj.check_data(row4);
            obj.ui.Label_5.Text = obj.check_data(row0);
        end

        function result = check_data(obj,data)
            result = num2str(data);
            if data > 9000
                result = '暂无记录';
            end
        end
    end
end

