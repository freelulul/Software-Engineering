classdef inner_panel < handle

    properties
        % button
        call1,call2,call3,open,close;
        % Display
        up_button,down_button,digit;
        % State
        whether_havesig;
    end

    methods
        function obj = inner_panel()
            % Instruction
            obj.call1 = 0;
            obj.call2 = 0;
            obj.call3 = 0;
            obj.open = 0;
            obj.close = 0;
            % Display
            obj.up_button = 0;
            obj.down_button = 0;
            obj.digit = 1;
            obj.whether_havesig = 0;
        end

        function inner_access(obj)
            obj.whether_havesig = 1;
        end
    end
end