classdef elevator < handle

    properties
        ui;
        % Velocity
        v,a;
        % Open timer
        tim;
        % Open time
        open_tim;
        % Current floor
        current_floor;
        % Current state,
        % 0->stop;1->up;2->down;3->opening;4->closing;5->open_MAX
        current_state;
    end

    methods
        function obj = elevator()
             obj.a = 0;
             obj.v = 0;
             obj.tim = 0;
             obj.open_tim = 5;
             obj.current_floor = 1;
             obj.current_state = 0;
        end

        function open(obj,side,floor,delta_t)
            open_gap = 2;
            if side == 0
                % Opening
                if floor == 1
                    % Update the door position
                    obj.ui.l_l_1.Position(1) = obj.ui.l_l_1.Position(1) - open_gap * delta_t;
                    obj.ui.l_r_1.Position(1) = obj.ui.l_r_1.Position(1) + open_gap * delta_t;
                elseif floor == 2
                    % Update the door position
                    obj.ui.l_l_2.Position(1) = obj.ui.l_l_2.Position(1) - open_gap * delta_t;
                    obj.ui.l_r_2.Position(1) = obj.ui.l_r_2.Position(1) + open_gap * delta_t;
                elseif floor == 3
                    % Update the door position
                    obj.ui.l_l_3.Position(1) = obj.ui.l_l_3.Position(1) - open_gap * delta_t;
                    obj.ui.l_r_3.Position(1) = obj.ui.l_r_3.Position(1) + open_gap * delta_t;
                end

            elseif side == 1
                % Opening
                if floor == 1 
                    % Update the door position
                    obj.ui.r_l_1.Position(1) = obj.ui.r_l_1.Position(1) - open_gap * delta_t;
                    obj.ui.r_r_1.Position(1) = obj.ui.r_r_1.Position(1) + open_gap * delta_t;
                elseif floor == 2
                    % Update the door position
                    obj.ui.r_l_2.Position(1) = obj.ui.r_l_2.Position(1) - open_gap * delta_t;
                    obj.ui.r_r_2.Position(1) = obj.ui.r_r_2.Position(1) + open_gap * delta_t;
                elseif floor == 3
                    % Update the door position
                    obj.ui.r_l_3.Position(1) = obj.ui.r_l_3.Position(1) - open_gap * delta_t;
                    obj.ui.r_r_3.Position(1) = obj.ui.r_r_3.Position(1) + open_gap * delta_t;
                end
            end
        end

        function close(obj,side,floor,delta_t)
            close_gap = 2;
            if side == 0
                % Closing
                if floor == 1
                    obj.left_ele.current_state = 4;
                    % Update the door position
                    obj.ui.l_l_1.Position(1) = obj.ui.l_l_1.Position(1) + close_gap * delta_t;
                    obj.ui.l_r_1.Position(1) = obj.ui.l_r_1.Position(1) - close_gap * delta_t;
                elseif floor == 2
                    obj.left_ele.current_state = 4;
                    % Update the door position
                    obj.ui.l_l_2.Position(1) = obj.ui.l_l_2.Position(1) + close_gap * delta_t;
                    obj.ui.l_r_2.Position(1) = obj.ui.l_r_2.Position(1) - close_gap * delta_t;
                elseif floor == 3
                    obj.left_ele.current_state = 4;
                    % Update the door position
                    obj.ui.l_l_3.Position(1) = obj.ui.l_l_3.Position(1) + close_gap * delta_t;
                    obj.ui.l_r_3.Position(1) = obj.ui.l_r_3.Position(1) - close_gap * delta_t;
                end
            elseif side == 1
                % Closing
                if floor == 1
                    obj.right_ele.current_state = 4;
                    % Update the door position
                    obj.ui.r_l_1.Position(1) = obj.ui.r_l_1.Position(1) + close_gap * delta_t;
                    obj.ui.r_r_1.Position(1) = obj.ui.r_r_1.Position(1) - close_gap * delta_t;
                elseif floor == 2
                    obj.right_ele.current_state = 4;
                    % Update the door position
                    obj.ui.r_l_2.Position(1) = obj.ui.r_l_2.Position(1) + close_gap * delta_t;
                    obj.ui.r_r_2.Position(1) = obj.ui.r_r_2.Position(1) - close_gap * delta_t;
                elseif floor == 3
                    obj.right_ele.current_state = 4;
                    % Update the door position
                    obj.ui.r_l_3.Position(1) = obj.ui.r_l_3.Position(1) + close_gap * delta_t;
                    obj.ui.r_r_3.Position(1) = obj.ui.r_r_3.Position(1) - close_gap * delta_t;
                end
            end
        end

        function move_up(obj,side,delta_t)
            % Continue move
            if side == 0
                % Update position
                if obj.ui.inner_left_showcase.Position(2) == 352
                    obj.ui.inner_left_showcase.Position(2) = obj.ui.inner_left_showcase.Position(2) + obj.v * delta_t + 1/2 * obj.a * delta_t * delta_t;
                elseif obj.ui.inner_left_showcase.Position(2) + obj.v * delta_t + 1/2 * obj.a * delta_t * delta_t >= 467
                    obj.ui.inner_left_showcase.Position(2) = 467;
                elseif obj.ui.inner_left_showcase.Position(2) > 352
                    obj.ui.inner_left_showcase.Position(2) = obj.ui.inner_left_showcase.Position(2) + obj.v * delta_t + 1/2 * obj.a * delta_t * delta_t;
                elseif obj.ui.inner_left_showcase.Position(2) + obj.v * delta_t + 1/2 * obj.a * delta_t * delta_t >= 352
                    obj.ui.inner_left_showcase.Position(2) = 352;
                else
                    obj.ui.inner_left_showcase.Position(2) = obj.ui.inner_left_showcase.Position(2) + obj.v * delta_t + 1/2 * obj.a * delta_t * delta_t;
                end

            elseif side == 1
                % Update position
                if obj.ui.inner_right_showcase.Position(2) == 352
                    obj.ui.inner_right_showcase.Position(2) = obj.ui.inner_right_showcase.Position(2) + obj.v * delta_t + 1/2 * obj.a * delta_t * delta_t;
                elseif obj.ui.inner_right_showcase.Position(2) + obj.v * delta_t + 1/2 * obj.a * delta_t * delta_t >= 467
                    obj.ui.inner_right_showcase.Position(2) = 467;
                elseif obj.ui.inner_right_showcase.Position(2) > 352
                    obj.ui.inner_right_showcase.Position(2) = obj.ui.inner_right_showcase.Position(2) + obj.v * delta_t + 1/2 * obj.a * delta_t * delta_t;
                elseif obj.ui.inner_right_showcase.Position(2) + obj.v * delta_t + 1/2 * obj.a * delta_t * delta_t >= 352
                    obj.ui.inner_right_showcase.Position(2) = 352;
                else
                    obj.ui.inner_right_showcase.Position(2) = obj.ui.inner_right_showcase.Position(2) + obj.v * delta_t + 1/2 * obj.a * delta_t * delta_t;
                end
            end
        end

        function move_down(obj,side,delta_t)
            % Assess whether go on moving
            
            % Continue move
            if side == 0
                % Set a
                obj.a = -2;
                % Update position
                if obj.ui.inner_left_showcase.Position(2) == 352
                    obj.ui.inner_left_showcase.Position(2) = obj.ui.inner_left_showcase.Position(2) + obj.v * delta_t + 1/2 * obj.a * delta_t * delta_t;
                elseif obj.ui.inner_left_showcase.Position(2) + obj.v * delta_t + 1/2 * obj.a * delta_t * delta_t <= 236
                    obj.ui.inner_left_showcase.Position(2) = 236;
                elseif obj.ui.inner_left_showcase.Position(2) < 352
                    obj.ui.inner_left_showcase.Position(2) = obj.ui.inner_left_showcase.Position(2) + obj.v * delta_t + 1/2 * obj.a * delta_t * delta_t;
                elseif obj.ui.inner_left_showcase.Position(2) + obj.v * delta_t + 1/2 * obj.a * delta_t * delta_t <= 352
                    obj.ui.inner_left_showcase.Position(2) = 352;
                else
                    obj.ui.inner_left_showcase.Position(2) = obj.ui.inner_left_showcase.Position(2) + obj.v * delta_t + 1/2 * obj.a * delta_t * delta_t;
                end
            elseif side == 1
                % Update position
                if obj.ui.inner_right_showcase.Position(2) == 352
                    obj.ui.inner_right_showcase.Position(2) = obj.ui.inner_right_showcase.Position(2) + obj.v * delta_t + 1/2 * obj.a * delta_t * delta_t;
                elseif obj.ui.inner_right_showcase.Position(2) + obj.v * delta_t + 1/2 * obj.a * delta_t * delta_t <= 236
                    obj.ui.inner_right_showcase.Position(2) = 236;
                elseif obj.ui.inner_right_showcase.Position(2) < 352
                    obj.ui.inner_right_showcase.Position(2) = obj.ui.inner_right_showcase.Position(2) + obj.v * delta_t + 1/2 * obj.a * delta_t * delta_t;
                elseif obj.ui.inner_right_showcase.Position(2) + obj.v * delta_t + 1/2 * obj.a * delta_t * delta_t <= 352
                    obj.ui.inner_right_showcase.Position(2) = 352;
                else
                    obj.ui.inner_right_showcase.Position(2) = obj.ui.inner_right_showcase.Position(2) + obj.v * delta_t + 1/2 * obj.a * delta_t * delta_t;
                end
            end
        end

    end
end