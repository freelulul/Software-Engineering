classdef history < handle
    %HISTORY 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        matrix_list
    end
    
    methods
        function self = history()
            %HISTORY 构造此类的实例
            %   此处显示详细说明
            self.matrix_list = zeros(5,4,1000);
        end
        
        function matrix_replace(list,matrix,index)
            %the init index is 1 which step is 0
            list.matrix_list(:,:,index) = matrix;
        end

        function result = read_matrix(list,index)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            result = list.matrix_list(:,:,index);
        end
    end
end
