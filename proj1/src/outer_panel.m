classdef outer_panel < handle

    properties
        % button
        up_1,up_2,down_2,down_3;
        current_floor;
    end

    methods
        function obj = outer_panel()
            obj.up_1 = 0;
            obj.up_2 = 0;
            obj.down_2 = 0;
            obj.down_3 = 0;
            obj.current_floor = 1;
        end
    end
end