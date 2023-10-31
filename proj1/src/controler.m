classdef controler < handle

    properties
        ui;
        sig_list;
        hold_list;
        left_ele,right_ele;
        left_inner_p,right_inner_p;
        outer_panel;
        delta_t;
        flush timer;
    end

    methods
        function obj = controler(Ui,le,re,lp,rp,op)
            obj.ui = Ui;
            obj.left_ele = le;
            obj.right_ele = re;
            obj.left_inner_p = lp;
            obj.right_inner_p = rp;
            obj.outer_panel = op;
            obj.delta_t = 1;
            % 0 -> no sig, 1 -> have sig
            obj.sig_list = [0,0,0,0,0,0,0,0,0,0,0,0,0,0];
            % 0 -> left hold, 1 -> right hold, -1 no hold
            obj.hold_list = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
        end

        % Get front_end data
        function scheduler(obj,signal)
            obj.sig_list(signal) = 1;
        end

        % Assess which elevator will respond to instruction, (Schedule!!!!!!!!!)
        % 0 repre left_ele, 1 repre right_ele
        % 1 repre up, 2 repre down
        function tar_direction = dispatch(obj,instr)
            % Initialize variables
            if instr == 1
                po = 467;
            elseif instr == 2 || instr == 3
                po = 352;
            elseif instr == 4
                po = 236;
            end

            tar_direction = [-1,-1];
            state = [obj.left_ele.current_state,obj.right_ele.current_state];
            floor = [obj.left_ele.current_floor,obj.right_ele.current_floor];
            position = [obj.ui.inner_left_showcase.Position(2),obj.ui.inner_right_showcase.Position(2)];

            if obj.hold_list(instr) == 0
                if instr == 3 && obj.hold_list(1) == 0 && position(1) >= 352%%%
                    tar_direction = [-1,-1];
                    return;
                elseif instr == 2 && obj.hold_list(4) == 0 && position(1) <= 352%%%
                    tar_direction = [-1,-1];
                    return;
                end
                % Need to go down 
                if po < position(1)
                    tar_direction = [0,2];
                    return;
                % Need to go up
                elseif po > position(1)
                    tar_direction = [0,1];
                    return;
                end
            elseif obj.hold_list(instr) == 1
                if instr == 3 && obj.hold_list(1) == 1 && position(2) >= 352%%%
                    tar_direction = [-1,-1];
                    return;
                elseif instr == 2 && obj.hold_list(4) == 1 && position(2) <= 352%%%
                    tar_direction = [-1,-1];
                    return;
                end
                % Need to go down 
                if po < position(2)
                    tar_direction = [1,2];
                    return;
                % Need to go up
                elseif po > position(2)
                    tar_direction = [1,1];
                    return;
                end
            end
            
            % If both are idle, schedule a near elevator
            if state == [0,0]
               % Left is near than right
               if abs(po-position(1)) <= abs(po-position(2))
                    obj.hold_list(instr) = 0;
                    % Need to go down 
                    if po < position(1)
                        tar_direction = [0,2];
                        return;
                    % Need to go up
                    elseif po > position(1)
                        tar_direction = [0,1];
                        return;
                    end
                % Right is near than left
               else
                    obj.hold_list(instr) = 1;
                    % Need to go down 
                    if po < position(2)
                        tar_direction = [1,2];
                        return;
                    % Need to go up
                    elseif po > position(2)
                        tar_direction = [1,1];
                        return;
                    end
                end
            % Left is idle, right is running
            elseif state == [0,1] | state == [0,2] | state == [0,3] | state == [0,4] | state == [0,5]
                if instr == 1
                    if obj.hold_list(3) ~= 1%%%
                        tar_direction = [1,1];
                        obj.hold_list(instr) = 1;
                        return;
                    elseif position(1) == 467
                        obj.hold_list(instr) = 0;
                        return;
                    elseif obj.hold_list(4) ~= 0 && obj.hold_list(2) ~= 0 && obj.hold_list(3) ~= 0           
                        tar_direction = [0,1];
                        obj.hold_list(instr) = 0;
                        return;
                    end
                elseif instr == 2
                    if position(2) < 352 && state(2) == 0 && obj.hold_list(3) ~= 1
                        tar_direction = [1,1];
                        obj.hold_list(instr) = 1;
                        return;
                    elseif position(2) == 236 && state(2) ~= 2 && obj.hold_list(3) ~= 1%%%
                        tar_direction = [1,1];
                        obj.hold_list(instr) = 1;
                        return;
                    elseif position(2) > 352 && state(2) == 2 && obj.hold_list(3) ~= 1 && obj.hold_list(4) ~= 1
                        tar_direction = [1,2];
                        obj.hold_list(instr) = 1;
                        return;
                    elseif position(1) == 467 && state(2) ~= 1 && obj.hold_list(4) == 1 && obj.hold_list(2) ~= 0%%%
                        tar_direction = [1,2];
                        obj.hold_list(instr) = 1;
                        return;
                    elseif position(1) == 352
                        obj.hold_list(instr) = 0;
                        return;
                    else     
                        obj.hold_list(instr) = 0;
                        if floor(1) == 1          
                            tar_direction = [0,1];
                            return;
                        elseif floor(1) == 3
                            tar_direction = [0,2];
                            return;
                        end
                    end
                elseif instr == 3
                    if position(2) > 352 && state(2) == 2 && obj.hold_list(2) ~= 1
                        tar_direction = [1,2];
                        obj.hold_list(instr) = 1;
                        return;
                    elseif position(2) == 467 && state(2) ~= 1 && obj.hold_list(2) ~= 1%%%
                        tar_direction = [1,2];
                        obj.hold_list(instr) = 1;
                        return;
                    elseif position(2) < 352 && state(2) == 1 && obj.hold_list(1) ~= 1 && obj.hold_list(2) ~= 1
                        tar_direction = [1,1];
                        obj.hold_list(instr) = 1;
                        return;
                    elseif position(2) <= 352 && state(2) ~= 2 && (~(obj.hold_list(1) == 1 && obj.hold_list(2) == 1)) && (~(obj.hold_list(2) == 1 && obj.hold_list(4) == 1))%%%
                        tar_direction = [1,1];
                        obj.hold_list(instr) = 0;
                        return;
                    elseif position(1) == 352
                        obj.hold_list(instr) = 0;
                        return;
                    else                  
                        obj.hold_list(instr) = 0;
                        if floor(1) == 1          
                            tar_direction = [0,1];
                            return;
                        elseif floor(1) == 3
                            tar_direction = [0,2];
                            return;
                        end
                    end
                elseif instr == 4
                    if obj.hold_list(2) ~= 1%%%
                        tar_direction = [1,2];
                        obj.hold_list(instr) = 1;
                        return;
                    elseif obj.hold_list(2) == 1 && position(2) >= 352 && state(2) ~= 1%%%
                        tar_direction = [1,2];
                        obj.hold_list(instr) = 1;
                        return;
                    elseif position(1) == 236
                        obj.hold_list(instr) = 0;
                        return;
                    elseif obj.hold_list(1) ~= 0 && obj.hold_list(2) ~= 0 && obj.hold_list(3) ~= 0
                        tar_direction = [0,2];
                        obj.hold_list(instr) = 0;
                        return;
                    end
                end
            % Right is idle, left is running
            elseif state == [1,0] | state == [2,0] | state == [3,0] | state == [4,0] | state == [5,0]
                if instr == 1
                    if obj.hold_list(3) ~= 0%%%
                        tar_direction = [0,1];
                        obj.hold_list(instr) = 0;
                        return;
                    elseif obj.hold_list(3) == 0 && position(1) <= 352 && state(1) ~= 2%%%
                        tar_direction = [0,1];
                        obj.hold_list(instr) = 0;
                        return;
                    elseif position(2) == 467
                        obj.hold_list(instr) = 1;
                        return;
                    elseif obj.hold_list(4) ~= 1 && obj.hold_list(2) ~= 1 && obj.hold_list(3) ~= 1                    
                        tar_direction = [1,1];
                        obj.hold_list(instr) = 1;
                        return;
                    end
                elseif instr == 2
                    if position(1) < 352 && state(1) == 1 && obj.hold_list(3) ~= 0
                        tar_direction = [0,1];
                        obj.hold_list(instr) = 0;
                        return;
                    elseif position(1) == 236 && state(1) ~= 2 && obj.hold_list(3) ~= 0 %%%
                        tar_direction = [0,1];
                        obj.hold_list(instr) = 0;
                        return;
                    elseif position(1) > 352 && state(1) == 2 && obj.hold_list(3) ~= 0 && obj.hold_list(4) ~= 0
                        tar_direction = [0,2];
                        obj.hold_list(instr) = 0;
                        return;
                    elseif position(2) == 467 && state(1) ~= 1 && obj.hold_list(4) == 0 && obj.hold_list(2) ~= 1%%%
                        tar_direction = [0,2];
                        obj.hold_list(instr) = 0;
                        return;
                    elseif position(2) == 352
                        obj.hold_list(instr) = 1;
                        return;
                    else        
                        obj.hold_list(instr) = 1;
                        if floor(2) == 1          
                            tar_direction = [1,1];
                            return;
                        elseif floor(2) == 3
                            tar_direction = [1,2];
                            return;
                        end
                    end
                elseif instr == 3
                    if position(1) > 352 && state(1) == 2 && obj.hold_list(2) ~= 0
                        tar_direction = [0,2];
                        obj.hold_list(instr) = 0;
                        return;
                    elseif position(1) == 467 && state(1) ~= 1 && obj.hold_list(2) ~= 0%%%
                        tar_direction = [0,2];
                        obj.hold_list(instr) = 0;
                        return;
                    elseif position(1) < 352 && state(1) == 1 && obj.hold_list(1) ~= 0 && obj.hold_list(2) ~= 0
                        tar_direction = [0,1];
                        obj.hold_list(instr) = 0;
                        return;
                    elseif position(1) <= 352 && state(1) ~= 2 && (~(obj.hold_list(1) == 0 && obj.hold_list(2) == 0)) && (~(obj.hold_list(2) == 0 && obj.hold_list(4) == 0))%%%
                        tar_direction = [0,1];
                        obj.hold_list(instr) = 0;
                        return;
                    elseif position(2) == 352
                        obj.hold_list(instr) = 1;
                        return;
                    else        
                        obj.hold_list(instr) = 1;
                        if floor(2) == 1        
                            tar_direction = [1,1];
                            return;
                        elseif floor(2) == 3
                            tar_direction = [1,2];
                            return;
                        end
                    end
                elseif instr == 4
                    if obj.hold_list(2) ~= 0%%%
                        tar_direction = [0,2];
                        obj.hold_list(instr) = 0;
                        return;
                    elseif obj.hold_list(2) == 0 && position(1) >= 352 && state(1) ~= 1%%%
                        tar_direction = [0,2];
                        obj.hold_list(instr) = 0;
                        return;
                    elseif position(2) == 236
                        obj.hold_list(instr) = 1;
                        return;
                    elseif obj.hold_list(1) ~= 1 && obj.hold_list(2) ~= 1 && obj.hold_list(3) ~= 1                    
                        tar_direction = [1,2];
                        obj.hold_list(instr) = 1;
                        return;
                    end
                end
            % If both elevator are running
            else
                if instr == 1
                    if (position(2) >= position(1)) & state == [1,1] & obj.hold_list(3) ~= 1
                        tar_direction = [1,1];
                        obj.hold_list(instr) = 1;
                        return;
                    elseif (position(2) < position(1)) & state == [1,1] & obj.hold_list(3) ~= 0
                        tar_direction = [0,1];
                        obj.hold_list(instr) = 0;
                        return;
                    elseif state(2) == 1 && obj.hold_list(3) ~= 1
                        tar_direction = [1,1];
                        obj.hold_list(instr) = 1;
                        return;
                    elseif state(1) == 1 && obj.hold_list(3) ~= 0
                        tar_direction = [0,1];
                        obj.hold_list(instr) = 0;
                        return;
                    else                    
                        tar_direction = [-1,-1];
                        return;
                    end
                elseif instr == 2
                    if position(2) < 352 && state(2) == 1 && obj.hold_list(3) ~= 1
                        tar_direction = [1,1];
                        obj.hold_list(instr) = 1;
                        return;
                    elseif position(2) > 352 && state(2) == 2 && obj.hold_list(3) ~= 1 && obj.hold_list(4) ~= 1
                        tar_direction = [1,2];
                        obj.hold_list(instr) = 1;
                        return;
                    elseif position(1) < 352 && state(1) == 1 && obj.hold_list(3) ~= 0
                        tar_direction = [0,1];
                        obj.hold_list(instr) = 0;
                        return;
                    elseif position(1) > 352 && state(1) == 2 && obj.hold_list(3) ~= 0 && obj.hold_list(4) ~= 0
                        tar_direction = [0,2];
                        obj.hold_list(instr) = 0;
                        return;
                    else          
                        tar_direction = [-1,-1];
                        return;
                    end
                elseif instr == 3
                    if position(2) < 352 && state(2) == 1 && obj.hold_list(1) ~= 1 && obj.hold_list(2) ~= 1
                        tar_direction = [1,1];
                        obj.hold_list(instr) = 1;
                        return;
                    elseif position(2) > 352 && state(2) == 2 && obj.hold_list(2) ~= 1
                        tar_direction = [1,2];
                        obj.hold_list(instr) = 1;
                        return;
                    elseif position(1) < 352 && state(1) == 1 && obj.hold_list(1) ~= 0 && obj.hold_list(2) ~= 0
                        tar_direction = [0,1];
                        obj.hold_list(instr) = 0;
                        return;
                    elseif position(1) > 352 && state(1) == 2 && obj.hold_list(2) ~= 0
                        tar_direction = [0,2];
                        obj.hold_list(instr) = 0;
                        return;
                    else                    
                        tar_direction = [-1,-1];
                        return;
                    end
                elseif instr == 4
                    if (position(2) <= position(1)) & state == [2,2] & obj.hold_list(2) ~= 1
                        tar_direction = [1,2];
                        obj.hold_list(instr) = 1;
                        return;
                    elseif (position(2) > position(1)) & state == [2,2] & obj.hold_list(2) ~= 0
                        tar_direction = [0,2];
                        obj.hold_list(instr) = 0;
                        return;
                    elseif state(2) == 2 && obj.hold_list(2) ~= 1
                        tar_direction = [1,2];
                        obj.hold_list(instr) = 1;
                        return;
                    elseif state(1) == 2 && obj.hold_list(2) ~= 0
                        tar_direction = [0,2];
                        obj.hold_list(instr) = 0;
                        return;
                    else                    
                        tar_direction = [-1,-1];
                        return;
                    end
                end
            end

        end

        % Side = 1 means left, 2 means right
        function tar_direction = dispatch_oneside(obj,instr,side)
            % Initialize variables
            if instr == 1 || instr == 7 || instr == 10
                po = 467;
            elseif instr == 2 || instr == 3 || instr == 8 || instr == 11
                po = 352;
            elseif instr == 4 || instr == 9 || instr == 12
                po = 236;
            end 
            
            tar_direction = [-1,-1];
            state = [obj.left_ele.current_state,obj.right_ele.current_state];
            position = [obj.ui.inner_left_showcase.Position(2),obj.ui.inner_right_showcase.Position(2)];

            if obj.hold_list(instr) == 0 
                % Need to go down 
                if po < position(1)
                    tar_direction = [0,2];
                    return;
                % Need to go up
                elseif po > position(1)
                    tar_direction = [0,1];
                    return;
                end
            elseif obj.hold_list(instr) == 1
                % Need to go down 
                if po < position(2)
                    tar_direction = [1,2];
                    return;
                % Need to go up
                elseif po > position(2)
                    tar_direction = [1,1];
                    return;
                end
            end
            
            if state(side) == 0
                obj.hold_list(instr) = side - 1;
                % Need to go down 
                if po < position(side)
                    tar_direction = [side - 1,2];
                    return;
                % Need to go up
                elseif po > position(side)
                    tar_direction = [side - 1,1];
                    return;
                end
            elseif state(side) == 1
                % Need to go up 
                if position(side) < po
                    tar_direction = [side - 1,1];
                    obj.hold_list(instr) = side - 1;
                    return;
                end
            elseif state(side) == 2
                % Need to go down 
                if position(side) > po
                    tar_direction = [side - 1,2];
                    obj.hold_list(instr) = side - 1;
                    return;
                end
            else 
                tar_direction = [-1,-1];
            end
    
        end
        
        function open(obj,side,floor,delta_t,cause_instr)
            open_gap = 2;
            if side == 0
                % Whether open MAX?
                if obj.ui.l_l_1.Position(1) == -3 || obj.ui.l_l_2.Position(1) == -3 || obj.ui.l_l_3.Position(1) == -3
                    if cause_instr ~= 5
                        obj.left_ele.current_state = 5;
                        return;
                    elseif cause_instr == 5
                        obj.left_ele.current_state = 5;
                        obj.left_ele.tim = obj.left_ele.tim + 0.2;
                        if obj.ui.inner_left_showcase.Position(2) == 236 && obj.hold_list(4) == 0
                            obj.sig_list(4) = 0;
                            obj.hold_list(4) = -1;
                        elseif obj.ui.inner_left_showcase.Position(2) == 352 && obj.hold_list(2) == 0
                            obj.sig_list(2) = 0;
                            obj.hold_list(2) = -1;
                        elseif obj.ui.inner_left_showcase.Position(2) == 352 && obj.hold_list(3) == 0
                            obj.sig_list(3) = 0;
                            obj.hold_list(3) = -1;
                        elseif obj.ui.inner_left_showcase.Position(2) == 467 && obj.hold_list(1) == 0
                            obj.sig_list(1) = 0;
                            obj.hold_list(1) = -1;
                        end
                        if (obj.left_ele.tim >= obj.left_ele.open_tim) || obj.sig_list(6) == 1
                            obj.sig_list(cause_instr) = 0;
                            obj.hold_list(cause_instr) = -1;
                            obj.left_ele.tim = 0;
                            % Close door
                            obj.sig_list(6) = 1;
                        end
                        return;
                    end
                end
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
                % Whether open MAX?
                if obj.ui.r_l_1.Position(1) == 663 || obj.ui.r_l_2.Position(1) == 663 || obj.ui.r_l_3.Position(1) == 663
                    if cause_instr ~= 13
                        obj.right_ele.current_state = 5;
                        return;
                    elseif cause_instr == 13
                        obj.right_ele.current_state = 5;
                        obj.right_ele.tim = obj.right_ele.tim + 0.2;
                        if obj.ui.inner_right_showcase.Position(2) == 236 && obj.hold_list(4) == 1
                            obj.sig_list(4) = 0;
                            obj.hold_list(4) = -1;
                        elseif obj.ui.inner_right_showcase.Position(2) == 352 && obj.hold_list(2) == 1
                            obj.sig_list(2) = 0;
                            obj.hold_list(2) = -1;
                        elseif obj.ui.inner_right_showcase.Position(2) == 352 && obj.hold_list(3) == 1
                            obj.sig_list(3) = 0;
                            obj.hold_list(3) = -1;
                        elseif obj.ui.inner_right_showcase.Position(2) == 467 && obj.hold_list(1) == 1
                            obj.sig_list(1) = 0;
                            obj.hold_list(1) = -1;
                        end
                        if (obj.right_ele.tim >= obj.right_ele.open_tim) || obj.sig_list(14) == 1
                            obj.sig_list(cause_instr) = 0;
                            obj.hold_list(cause_instr) = -1;
                            obj.right_ele.tim = 0;
                            % Close door
                            obj.sig_list(14) = 1;
                        end
                        return;
                    end
                end
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

        function close(obj,side,floor,delta_t,cause_instr)
            close_gap = 2;
            if side == 0
                % Closing
                if floor == 1
                    obj.left_ele.current_state = 4;
                    % Update the door position
                    obj.ui.l_l_1.Position(1) = obj.ui.l_l_1.Position(1) + close_gap * delta_t;
                    obj.ui.l_r_1.Position(1) = obj.ui.l_r_1.Position(1) - close_gap * delta_t;
                    % The condition that left elevator just arrive and complete close door process
                    if obj.left_ele.current_floor == 1 && obj.ui.l_l_1.Position(1) == 43 && obj.left_ele.current_state == 4
                        obj.sig_list(cause_instr) = 0;
                        obj.hold_list(cause_instr) = -1;
                        obj.left_ele.v = 0;
                        obj.left_ele.a = 0;
                        obj.left_ele.current_state = 0;
                    end
                elseif floor == 2
                    obj.left_ele.current_state = 4;
                    % Update the door position
                    obj.ui.l_l_2.Position(1) = obj.ui.l_l_2.Position(1) + close_gap * delta_t;
                    obj.ui.l_r_2.Position(1) = obj.ui.l_r_2.Position(1) - close_gap * delta_t;
                    % The condition that left elevator just arrive and complete close door process
                    if obj.left_ele.current_floor == 2 && obj.ui.l_l_2.Position(1) == 43 && obj.left_ele.current_state == 4
                        obj.sig_list(cause_instr) = 0;
                        obj.hold_list(cause_instr) = -1;
                        obj.left_ele.v = 0;
                        obj.left_ele.a = 0;
                        obj.left_ele.current_state = 0;
                    end
                elseif floor == 3
                    obj.left_ele.current_state = 4;
                    % Update the door position
                    obj.ui.l_l_3.Position(1) = obj.ui.l_l_3.Position(1) + close_gap * delta_t;
                    obj.ui.l_r_3.Position(1) = obj.ui.l_r_3.Position(1) - close_gap * delta_t;
                    % The condition that left elevator just arrive and complete close door process
                    if obj.left_ele.current_floor == 3 && obj.ui.l_l_3.Position(1) == 43 && obj.left_ele.current_state == 4
                        obj.sig_list(cause_instr) = 0;
                        obj.hold_list(cause_instr) = -1;
                        obj.left_ele.v = 0;
                        obj.left_ele.a = 0;
                        obj.left_ele.current_state = 0;
                    end
                end
            elseif side == 1
                % Closing
                if floor == 1
                    obj.right_ele.current_state = 4;
                    % Update the door position
                    obj.ui.r_l_1.Position(1) = obj.ui.r_l_1.Position(1) + close_gap * delta_t;
                    obj.ui.r_r_1.Position(1) = obj.ui.r_r_1.Position(1) - close_gap * delta_t;
                    % The condition that right elevator just arrive and complete close door process
                    if obj.right_ele.current_floor == 1 && obj.ui.r_l_1.Position(1) == 709 && obj.right_ele.current_state == 4
                        obj.sig_list(cause_instr) = 0;
                        obj.hold_list(cause_instr) = -1;
                        obj.right_ele.v = 0;
                        obj.right_ele.a = 0;
                        obj.right_ele.current_state = 0;
                    end
                elseif floor == 2
                    obj.right_ele.current_state = 4;
                    % Update the door position
                    obj.ui.r_l_2.Position(1) = obj.ui.r_l_2.Position(1) + close_gap * delta_t;
                    obj.ui.r_r_2.Position(1) = obj.ui.r_r_2.Position(1) - close_gap * delta_t;
                    % The condition that right elevator just arrive and complete close door process
                    if obj.right_ele.current_floor == 2 && obj.ui.r_l_2.Position(1) == 709 && obj.right_ele.current_state == 4
                        obj.sig_list(cause_instr) = 0;
                        obj.hold_list(cause_instr) = -1;
                        obj.right_ele.v = 0;
                        obj.right_ele.a = 0;
                        obj.right_ele.current_state = 0;
                    end
                elseif floor == 3
                    obj.right_ele.current_state = 4;
                    % Update the door position
                    obj.ui.r_l_3.Position(1) = obj.ui.r_l_3.Position(1) + close_gap * delta_t;
                    obj.ui.r_r_3.Position(1) = obj.ui.r_r_3.Position(1) - close_gap * delta_t;
                    % The condition that right elevator just arrive and complete close door process
                    if obj.right_ele.current_floor == 3 && obj.ui.r_l_3.Position(1) == 709 && obj.right_ele.current_state == 4
                        obj.sig_list(cause_instr) = 0;
                        obj.hold_list(cause_instr) = -1;
                        obj.right_ele.v = 0;
                        obj.right_ele.a = 0;
                        obj.right_ele.current_state = 0;
                    end
                end
            end
        end

        function update_all(obj)
            if obj.sig_list(5) == 0 && obj.sig_list(6) == 0 && obj.sig_list(7) == 0 && obj.sig_list(8) == 0 && obj.sig_list(9) == 0
                obj.left_inner_p.whether_havesig = 0;
            else 
                obj.left_inner_p.whether_havesig = 1;
            end
            if obj.sig_list(10) == 0 && obj.sig_list(11) == 0 && obj.sig_list(12) == 0 && obj.sig_list(13) == 0 && obj.sig_list(14) == 0
                obj.right_inner_p.whether_havesig = 0;
            else
                obj.right_inner_p.whether_havesig = 1;
            end

            % Update button light
            if obj.sig_list(1) == 0
                obj.ui.third_Button.BackgroundColor = [0.96,0.96,0.96];
            end
            if obj.sig_list(2) == 0
                obj.ui.second_Button_up.BackgroundColor = [0.96,0.96,0.96];
            end
            if obj.sig_list(3) == 0
                obj.ui.second_Button_down.BackgroundColor = [0.96,0.96,0.96];
            end
            if obj.sig_list(4) == 0
                obj.ui.first_Button.BackgroundColor = [0.96,0.96,0.96];
            end
            if obj.sig_list(5) == 0
                obj.ui.left_open.BackgroundColor = [0.96,0.96,0.96];
            end
            if obj.sig_list(6) == 0
                obj.ui.left_close.BackgroundColor = [0.96,0.96,0.96];
            end
            if obj.sig_list(7) == 0
                obj.ui.left_call_3.BackgroundColor = [0.96,0.96,0.96];
            end
            if obj.sig_list(8) == 0
                obj.ui.left_call_2.BackgroundColor = [0.96,0.96,0.96];
            end
            if obj.sig_list(9) == 0
                obj.ui.left_call_1.BackgroundColor = [0.96,0.96,0.96];
            end
            if obj.sig_list(10) == 0
                obj.ui.right_call_3.BackgroundColor = [0.96,0.96,0.96];
            end
            if obj.sig_list(11) == 0
                obj.ui.right_call_2.BackgroundColor = [0.96,0.96,0.96];
            end
            if obj.sig_list(12) == 0
                obj.ui.right_call_1.BackgroundColor = [0.96,0.96,0.96];
            end
            if obj.sig_list(13) == 0
                obj.ui.right_open.BackgroundColor = [0.96,0.96,0.96];
            end
            if obj.sig_list(14) == 0
                obj.ui.right_close.BackgroundColor = [0.96,0.96,0.96];
            end

            % Update arrow light
            if obj.left_ele.current_state == 1
                obj.ui.left_ele_up.BackgroundColor = [0.00,1.00,0.00];
                obj.ui.left_ele_down.BackgroundColor = [1.00,1.00,1.00];
            elseif obj.left_ele.current_state == 2
                obj.ui.left_ele_down.BackgroundColor = [0.00,1.00,0.00];
                obj.ui.left_ele_up.BackgroundColor = [1.00,1.00,1.00];
            else
                obj.ui.left_ele_up.BackgroundColor = [1.00,1.00,1.00];
                obj.ui.left_ele_down.BackgroundColor = [1.00,1.00,1.00];
            end

            if obj.right_ele.current_state == 1
                obj.ui.right_ele_up.BackgroundColor = [0.00,1.00,0.00];
                obj.ui.right_ele_down.BackgroundColor = [1.00,1.00,1.00];
            elseif obj.right_ele.current_state == 2
                obj.ui.right_ele_down.BackgroundColor = [0.00,1.00,0.00];
                obj.ui.right_ele_up.BackgroundColor = [1.00,1.00,1.00];
            else
                obj.ui.right_ele_up.BackgroundColor = [1.00,1.00,1.00];
                obj.ui.right_ele_down.BackgroundColor = [1.00,1.00,1.00];
            end

            % Update digit
            % Update all state of back_end of left elevator
            if obj.ui.inner_left_showcase.Position(2) == 467
                obj.left_ele.current_floor = 3;
                obj.ui.left_digit.Text = "3";
                obj.ui.left_third_digit.Text = "3";
                obj.ui.left_second_digit.Text = "3";
                obj.ui.left_first_digit.Text = "3";
            elseif obj.ui.inner_left_showcase.Position(2) == 352
                obj.left_ele.current_floor = 2;
                obj.ui.left_digit.Text = "2";
                obj.ui.left_third_digit.Text = "2";
                obj.ui.left_second_digit.Text = "2";
                obj.ui.left_first_digit.Text = "2";
            elseif obj.ui.inner_left_showcase.Position(2) == 236
                obj.left_ele.current_floor = 1;
                obj.ui.left_digit.Text = "1";
                obj.ui.left_third_digit.Text = "1";
                obj.ui.left_second_digit.Text = "1";
                obj.ui.left_first_digit.Text = "1";
            end
            % Update all state of back_end of right elevator
            if obj.ui.inner_right_showcase.Position(2) == 467
                obj.right_ele.current_floor = 3;
                obj.ui.right_digit.Text = "3";
                obj.ui.right_third_digit.Text = "3";
                obj.ui.right_second_digit.Text = "3";
                obj.ui.right_first_digit.Text = "3";
            elseif obj.ui.inner_right_showcase.Position(2) == 352
                obj.right_ele.current_floor = 2;
                obj.ui.right_digit.Text = "2";
                obj.ui.right_third_digit.Text = "2";
                obj.ui.right_second_digit.Text = "2";
                obj.ui.right_first_digit.Text = "2";
            elseif obj.ui.inner_right_showcase.Position(2) == 236
                obj.right_ele.current_floor = 1;
                obj.ui.right_digit.Text = "1";
                obj.ui.right_third_digit.Text = "1";
                obj.ui.right_second_digit.Text = "1";
                obj.ui.right_first_digit.Text = "1";
            end
        end

        function move_up(obj,side,delta_t)
            % Assess whether go on moving
            
            % Continue move
            if side == 0
                % Set a
                obj.left_ele.a = 2;
                % Update position
                if obj.ui.inner_left_showcase.Position(2) == 352
                    obj.ui.inner_left_showcase.Position(2) = obj.ui.inner_left_showcase.Position(2) + obj.left_ele.v * delta_t + 1/2 * obj.left_ele.a * delta_t * delta_t;
                elseif obj.ui.inner_left_showcase.Position(2) + obj.left_ele.v * delta_t + 1/2 * obj.left_ele.a * delta_t * delta_t >= 467
                    obj.ui.inner_left_showcase.Position(2) = 467;
                    if obj.sig_list(1) == 1 && obj.hold_list(1) == 0
                        obj.left_ele.current_state = 3;
                    elseif obj.sig_list(7) == 1 && obj.hold_list(7) == 0
                        obj.left_ele.current_state = 3;
                    end
                elseif obj.ui.inner_left_showcase.Position(2) > 352
                    obj.ui.inner_left_showcase.Position(2) = obj.ui.inner_left_showcase.Position(2) + obj.left_ele.v * delta_t + 1/2 * obj.left_ele.a * delta_t * delta_t;
                elseif obj.ui.inner_left_showcase.Position(2) + obj.left_ele.v * delta_t + 1/2 * obj.left_ele.a * delta_t * delta_t >= 352
                    obj.ui.inner_left_showcase.Position(2) = 352;
                    if (obj.sig_list(2) == 1 && obj.hold_list(2) == 0)
                        obj.left_ele.current_state = 3;
                    elseif (obj.sig_list(8) == 1 && obj.hold_list(8) == 0)
                        obj.left_ele.current_state = 3;
                    elseif (obj.sig_list(3) == 1 && obj.hold_list(3) == 0) && obj.hold_list(1) ~= 0
                        obj.left_ele.current_state = 3;
                    end
                else
                    obj.ui.inner_left_showcase.Position(2) = obj.ui.inner_left_showcase.Position(2) + obj.left_ele.v * delta_t + 1/2 * obj.left_ele.a * delta_t * delta_t;
                end
                
                % Update velocity
                obj.left_ele.v = obj.left_ele.v + obj.left_ele.a * delta_t;

            elseif side == 1
                % Set a
                obj.right_ele.a = 2;
                % Update position
                if obj.ui.inner_right_showcase.Position(2) == 352
                    obj.ui.inner_right_showcase.Position(2) = obj.ui.inner_right_showcase.Position(2) + obj.right_ele.v * delta_t + 1/2 * obj.right_ele.a * delta_t * delta_t;
                elseif obj.ui.inner_right_showcase.Position(2) + obj.right_ele.v * delta_t + 1/2 * obj.right_ele.a * delta_t * delta_t >= 467
                    obj.ui.inner_right_showcase.Position(2) = 467;
                    if obj.sig_list(1) == 1 && obj.hold_list(1) == 1
                        obj.right_ele.current_state = 3;
                    elseif obj.sig_list(10) == 1 && obj.hold_list(10) == 1
                        obj.right_ele.current_state = 3;
                    end
                elseif obj.ui.inner_right_showcase.Position(2) > 352
                    obj.ui.inner_right_showcase.Position(2) = obj.ui.inner_right_showcase.Position(2) + obj.right_ele.v * delta_t + 1/2 * obj.right_ele.a * delta_t * delta_t;
                elseif obj.ui.inner_right_showcase.Position(2) + obj.right_ele.v * delta_t + 1/2 * obj.right_ele.a * delta_t * delta_t >= 352
                    obj.ui.inner_right_showcase.Position(2) = 352;
                    if (obj.sig_list(2) == 1 && obj.hold_list(2) == 1)
                        obj.right_ele.current_state = 3;
                    elseif (obj.sig_list(11) == 1 && obj.hold_list(11) == 1)
                        obj.right_ele.current_state = 3;
                    elseif (obj.sig_list(3) == 1 && obj.hold_list(3) == 1) && obj.hold_list(1) ~= 1
                        obj.right_ele.current_state = 3;
                    end
                else
                    obj.ui.inner_right_showcase.Position(2) = obj.ui.inner_right_showcase.Position(2) + obj.right_ele.v * delta_t + 1/2 * obj.right_ele.a * delta_t * delta_t;
                end

                % Update velocity
                obj.right_ele.v = obj.right_ele.v + obj.right_ele.a * delta_t;
            end
        end

        function move_down(obj,side,delta_t)
            % Assess whether go on moving
            
            % Continue move
            if side == 0
                % Set a
                obj.left_ele.a = -2;
                % Update position
                if obj.ui.inner_left_showcase.Position(2) == 352
                    obj.ui.inner_left_showcase.Position(2) = obj.ui.inner_left_showcase.Position(2) + obj.left_ele.v * delta_t + 1/2 * obj.left_ele.a * delta_t * delta_t;
                elseif obj.ui.inner_left_showcase.Position(2) + obj.left_ele.v * delta_t + 1/2 * obj.left_ele.a * delta_t * delta_t <= 236
                    obj.ui.inner_left_showcase.Position(2) = 236;
                    if obj.sig_list(4) == 1 && obj.hold_list(4) == 0
                        obj.left_ele.current_state = 3;
                    elseif obj.sig_list(9) == 1 && obj.hold_list(9) == 0
                        obj.left_ele.current_state = 3;
                    end
                elseif obj.ui.inner_left_showcase.Position(2) < 352
                    obj.ui.inner_left_showcase.Position(2) = obj.ui.inner_left_showcase.Position(2) + obj.left_ele.v * delta_t + 1/2 * obj.left_ele.a * delta_t * delta_t;
                elseif obj.ui.inner_left_showcase.Position(2) + obj.left_ele.v * delta_t + 1/2 * obj.left_ele.a * delta_t * delta_t <= 352
                    obj.ui.inner_left_showcase.Position(2) = 352;
                    if (obj.sig_list(3) == 1 && obj.hold_list(3) == 0)
                        obj.left_ele.current_state = 3;
                    elseif (obj.sig_list(8) == 1 && obj.hold_list(8) == 0)
                        obj.left_ele.current_state = 3;
                    elseif (obj.sig_list(2) == 1 && obj.hold_list(2) == 0) && obj.hold_list(4) ~= 0
                        obj.left_ele.current_state = 3;
                    end
                else
                    obj.ui.inner_left_showcase.Position(2) = obj.ui.inner_left_showcase.Position(2) + obj.left_ele.v * delta_t + 1/2 * obj.left_ele.a * delta_t * delta_t;
                end

                % Update velocity
                obj.left_ele.v = obj.left_ele.v + obj.left_ele.a * delta_t;
            elseif side == 1
                % Set a
                obj.right_ele.a = -2;
                % Update position
                if obj.ui.inner_right_showcase.Position(2) == 352
                    obj.ui.inner_right_showcase.Position(2) = obj.ui.inner_right_showcase.Position(2) + obj.right_ele.v * delta_t + 1/2 * obj.right_ele.a * delta_t * delta_t;
                elseif obj.ui.inner_right_showcase.Position(2) + obj.right_ele.v * delta_t + 1/2 * obj.right_ele.a * delta_t * delta_t <= 236
                    obj.ui.inner_right_showcase.Position(2) = 236;
                    if obj.sig_list(4) == 1 && obj.hold_list(4) == 1
                        obj.right_ele.current_state = 3;
                    elseif obj.sig_list(12) == 1 && obj.hold_list(12) == 1
                        obj.right_ele.current_state = 3;
                    end
                elseif obj.ui.inner_right_showcase.Position(2) < 352
                    obj.ui.inner_right_showcase.Position(2) = obj.ui.inner_right_showcase.Position(2) + obj.right_ele.v * delta_t + 1/2 * obj.right_ele.a * delta_t * delta_t;
                elseif obj.ui.inner_right_showcase.Position(2) + obj.right_ele.v * delta_t + 1/2 * obj.right_ele.a * delta_t * delta_t <= 352
                    obj.ui.inner_right_showcase.Position(2) = 352;
                    if (obj.sig_list(3) == 1 && obj.hold_list(3) == 1)
                        obj.right_ele.current_state = 3;
                    elseif (obj.sig_list(11) == 1 && obj.hold_list(11) == 1)
                        obj.right_ele.current_state = 3;
                    elseif (obj.sig_list(2) == 1 && obj.hold_list(2) == 1) && obj.hold_list(4) ~= 1
                        obj.right_ele.current_state = 3;
                    end
                else
                    obj.ui.inner_right_showcase.Position(2) = obj.ui.inner_right_showcase.Position(2) + obj.right_ele.v * delta_t + 1/2 * obj.right_ele.a * delta_t * delta_t;
                end

                % Update velocity
                obj.right_ele.v = obj.right_ele.v + obj.right_ele.a * delta_t;
            end
        end

        function a = open_close_ass(obj,fir,c_position,c_state)
            a = 0;
            if fir == 1
                fl = 3;
                po = 467;
            elseif fir == 2 || fir == 3
                fl = 2;
                po = 352;
            elseif fir == 4
                fl = 1;
                po = 236;
            end

            % Left is in there -open
            if c_position(1) == po && (c_state(1) == 3) && obj.hold_list(fir) == 0
                obj.open(0,fl,obj.delta_t,fir)
                a = 1;
                obj.hold_list(fir) = 0;
                return;
            % Right is in there -open
            elseif c_position(2) == po && (c_state(2) == 3) && obj.hold_list(fir) == 1
                obj.open(1,fl,obj.delta_t,fir)
                a = 1;
                obj.hold_list(fir) = 1;
                return;
            % Left -Max-open
            elseif c_position(1) == po && (c_state(1) == 5) && obj.hold_list(fir) == 0
                if obj.sig_list(6) == 1
                    a = 1;
                    obj.left_ele.tim = 0;
                    obj.left_ele.current_state = 4;
                    return;
                end
                a = 1;
                obj.left_ele.tim = obj.left_ele.tim + 0.2;
                obj.hold_list(fir) = 0;
                if obj.left_ele.tim >= obj.left_ele.open_tim
                    obj.left_ele.current_state = 4;
                    obj.left_ele.tim = 0;
                end
                return;
            % Left -close
            elseif c_position(1) == po && (c_state(1) == 4) && obj.hold_list(fir) == 0
                a = 1;
                obj.hold_list(fir) = 0;
                obj.close(0,fl,obj.delta_t,fir);
                return;
            % Right -Max-open
            elseif c_position(2) == po && (c_state(2) == 5) && obj.hold_list(fir) == 1
                if obj.sig_list(14) == 1
                    a = 1;
                    obj.right_ele.tim = 0;
                    obj.right_ele.current_state = 4;
                    return;
                end
                a = 1;
                obj.right_ele.tim = obj.right_ele.tim + 0.2;
                obj.hold_list(fir) = 1;
                if obj.right_ele.tim >= obj.right_ele.open_tim
                    obj.right_ele.current_state = 4;
                    obj.right_ele.tim = 0;
                end
                return;
            % Right -close
            elseif c_position(2) == po && (c_state(2) == 4) && obj.hold_list(fir) == 1
                a = 1;
                obj.hold_list(fir) = 1;
                obj.close(1,fl,obj.delta_t,fir)
                return;
            % Left is in there -open
            elseif c_position(1) == po && (c_state(1) == 0) && obj.hold_list(fir) == 0
                obj.left_ele.current_state = 3;
                obj.open(0,fl,obj.delta_t,fir)
                a = 1;
                obj.hold_list(fir) = 0;
                return;
            % Right is in there -open
            elseif c_position(2) == po && (c_state(2) == 0) && obj.hold_list(fir) == 1
                obj.right_ele.current_state = 3;
                obj.open(1,fl,obj.delta_t,fir)
                a = 1;
                obj.hold_list(fir) = 1;
                return;
            end
        end

        function a = oneside_open_close_ass(obj,fir,c_position,c_state,side)
            % Side == 1 -> left, == 2 -> right
            a = 0;
            if fir == -1
                return;
            end
            if fir == 7 || fir == 10 || fir == 1
                fl = 3;
                po = 467;
            elseif fir == 8 || fir == 11 || fir == 2 || fir == 3
                fl = 2;
                po = 352;
            elseif fir == 9 || fir == 12 || fir == 4
                fl = 1;
                po = 236;
            end

            % -open
            if c_position(side) == po && (c_state(side) == 3) && obj.hold_list(fir) == side - 1
                a = 1;
                obj.hold_list(fir) = side - 1;
                obj.open(side - 1,fl,obj.delta_t,fir);
                return;
            % -open-Max
            elseif c_position(side) == po && c_state(side) == 5 && obj.hold_list(fir) == side - 1
                a = 1;
                obj.hold_list(fir) = side - 1;
                if side == 1
                    if obj.sig_list(6) == 1
                        a = 1;
                        obj.left_ele.tim = 0;
                        obj.left_ele.current_state = 4;
                        return;
                    end
                    obj.left_ele.tim = obj.left_ele.tim + 0.2;
                    if obj.left_ele.tim >= obj.left_ele.open_tim
                        obj.left_ele.current_state = 4;
                        obj.left_ele.tim = 0;
                    end
                elseif side == 2
                    if obj.sig_list(14) == 1
                        a = 1;
                        obj.right_ele.tim = 0;
                        obj.right_ele.current_state = 4;
                        return;
                    end
                    obj.right_ele.tim = obj.right_ele.tim + 0.2;
                    if obj.right_ele.tim >= obj.right_ele.open_tim
                        obj.right_ele.current_state = 4;
                        obj.right_ele.tim = 0;
                    end
                end
                return;
            % -close
            elseif c_position(side) == po && (c_state(side) == 4 || c_state(side) == 5) && obj.hold_list(fir) == side - 1
                a = 1;
                obj.hold_list(fir) = side - 1;
                obj.close(side - 1,fl,obj.delta_t,fir);
                return;
            % In there -open
            elseif c_position(side) == po && (c_state(side) == 0) && obj.hold_list(fir) == side - 1
                a = 1;
                obj.hold_list(fir) = side - 1;
                if side == 1
                    obj.left_ele.current_state = 3;
                elseif side == 2
                    obj.right_ele.current_state = 3;
                end
                obj.open(side - 1,fl,obj.delta_t,fir);
                return;
            end
        end

        function [a,b] = open_close_asstwotwo(obj,c_position,c_state)
            a = 0;
            b = 0;
            fl = 2;
            po = 352;

            % Set corresponding elevator -> command 2 or 3
            if obj.hold_list(2) == 0
                left_receive = 2;
                right_receive = 3;
            elseif obj.hold_list(2) == 1
                right_receive = 2;
                left_receive = 3;
            end
            if obj.hold_list(3) == 0
                left_receive = 3;
                right_receive = 2;
            elseif obj.hold_list(3) == 1
                right_receive = 3;
                left_receive = 2;
            end
            if left_receive == 2
                obj.hold_list(2) = 0;
            elseif left_receive == 3
                obj.hold_list(3) = 0;
            end
            if right_receive == 2
                obj.hold_list(2) = 1;
            elseif right_receive == 3
                obj.hold_list(3) = 1;
            end

            % Left is in there -open
            if c_position(1) == po && (c_state(1) == 3)
                obj.open(0,fl,obj.delta_t,2)
                a = 1;
            end
            % Right is in there -open
            if c_position(2) == po && (c_state(2) == 3)
                obj.open(1,fl,obj.delta_t,2)
                b = 1;
            end
            % Left -close
            if c_position(1) == po && c_state(1) == 5
                a = 1;
                obj.left_ele.tim = obj.left_ele.tim + 0.2;
                if obj.left_ele.tim >= obj.left_ele.open_tim
                    obj.left_ele.current_state = 4;
                    obj.left_ele.tim = 0;
                end
                if obj.sig_list(6) == 1
                    obj.left_ele.tim = 0;
                    obj.left_ele.current_state = 4;
                end
            elseif c_position(1) == po && c_state(1) == 4
                obj.close(0,fl,obj.delta_t,left_receive)
                a = 1;
            end
            % Right -close
            if c_position(2) == po && c_state(2) == 5
                b = 1;
                obj.right_ele.tim = obj.right_ele.tim + 0.2;
                if obj.right_ele.tim >= obj.right_ele.open_tim
                    obj.right_ele.current_state = 4;
                    obj.right_ele.tim = 0;
                end
                if obj.sig_list(14) == 1
                    obj.right_ele.tim = 0;
                    obj.right_ele.current_state = 4;
                end
            elseif c_position(2) == po && c_state(2) == 4
                obj.close(1,fl,obj.delta_t,right_receive)
                b = 1;
            end
            % Left is in there -open
            if c_position(1) == po && (c_state(1) == 0)
                obj.left_ele.current_state = 3;
                obj.open(0,fl,obj.delta_t,2)
                a = 1;
            end
            % Right is in there -open
            if c_position(2) == po && (c_state(2) == 0)
                obj.right_ele.current_state = 3;
                obj.open(1,fl,obj.delta_t,2)
                b = 1;
            end

            if [a,b] == [0,0]
                tar1 = obj.dispatch_oneside(left_receive,1);
                tar2 = obj.dispatch_oneside(right_receive,2);
                obj.tar_move(tar1);
                obj.tar_move(tar2);
            elseif [a,b] == [0,1]
                tar1 = obj.dispatch_oneside(left_receive,1);
                obj.tar_move(tar1);
            elseif [a,b] == [1,0]
                tar2 = obj.dispatch_oneside(right_receive,2);
                obj.tar_move(tar2);
            end
        end

        function tar_move(obj,tar)
            if tar == [0,1]
                if obj.left_ele.current_state == 3 || obj.left_ele.current_state == 4 || obj.left_ele.current_state == 5
                    return;
                end
                obj.left_ele.current_state = 1;
                obj.move_up(0,obj.delta_t);
            elseif tar == [0,2]
                if obj.left_ele.current_state == 3 || obj.left_ele.current_state == 4 || obj.left_ele.current_state == 5
                    return;
                end
                obj.left_ele.current_state = 2;
                obj.move_down(0,obj.delta_t);
            elseif tar == [1,1]
                if obj.right_ele.current_state == 3 || obj.right_ele.current_state == 4 || obj.right_ele.current_state == 5
                    return;
                end
                obj.right_ele.current_state = 1;
                obj.move_up(1,obj.delta_t);
            elseif tar == [1,2]
                if obj.right_ele.current_state == 3 || obj.right_ele.current_state == 4 || obj.right_ele.current_state == 5
                    return;
                end
                obj.right_ele.current_state = 2;
                obj.move_down(1,obj.delta_t);
            end
        end

        function process_onesig(obj,fir,c_position,c_state)
            see = obj.open_close_ass(fir,c_position,c_state);

            % Schedule one elevator to react
            if see == 0
                tar = obj.dispatch(fir);
                obj.tar_move(tar);
            end
        end

        function process_twosig(obj,fir,sec,c_position,c_state)
            tar1 = [-1,-1];
            tar2 = [-1,-1];
            
            see1 = obj.open_close_ass(fir,c_position,c_state);
            see2 = obj.open_close_ass(sec,c_position,c_state);

            % The condition that one elevator hold two instructions
            if obj.hold_list(fir) == obj.hold_list(sec)
                working = obj.hold_list(fir);
                if working == 0 && (obj.left_ele.current_state == 3 || obj.left_ele.current_state == 4 || obj.left_ele.current_state == 5)
                    return;
                elseif working == 1 && (obj.right_ele.current_state == 3 || obj.right_ele.current_state == 4 || obj.right_ele.current_state == 5)
                    return;
                end
            end
            
            % Schedule one elevator to react
            if see1 == 0
                tar1 = obj.dispatch(fir);
            end
            if see2 == 0
                tar2 = obj.dispatch(sec);
            end

            if tar1 == tar2
                obj.tar_move(tar1);
            else
                obj.tar_move(tar1);
                obj.tar_move(tar2);
            end
        end

        function process_threesig(obj,fir,sec,thi,c_position,c_state)
            tar1 = [-1,-1];
            tar2 = [-1,-1];
            tar3 = [-1,-1];
            
            see1 = obj.open_close_ass(fir,c_position,c_state);
            see2 = obj.open_close_ass(sec,c_position,c_state);
            see3 = obj.open_close_ass(thi,c_position,c_state);

            % The condition that one elevator hold two instructions
            if obj.hold_list(fir) == obj.hold_list(sec)
                working = obj.hold_list(fir);
                if working == 0 && (obj.left_ele.current_state == 3 || obj.left_ele.current_state == 4 || obj.left_ele.current_state == 5)
                    if see3 == 0 && (~(obj.left_ele.current_floor == 3 && sec == 3 && thi == 4 && fir == 1))
                        tar3 = obj.dispatch_oneside(thi,2);
                        obj.tar_move(tar3);
                    end
                    return;
                elseif working == 1 && (obj.right_ele.current_state == 3 || obj.right_ele.current_state == 4 || obj.right_ele.current_state == 5)
                    if see3 == 0 && (~(obj.right_ele.current_floor == 3 && sec == 3 && thi == 4 && fir == 1))
                        tar3 = obj.dispatch_oneside(thi,1);
                        obj.tar_move(tar3);
                    end
                    return;
                end
            elseif obj.hold_list(sec) == obj.hold_list(thi)
                working = obj.hold_list(sec);
                if working == 0 && (obj.left_ele.current_state == 3 || obj.left_ele.current_state == 4 || obj.left_ele.current_state == 5)
                    if see1 == 0 && (~(obj.left_ele.current_floor == 1 && sec == 2 && thi == 4 && fir == 1))
                        tar1 = obj.dispatch_oneside(fir,2);
                        obj.tar_move(tar1);
                    end
                    return;
                elseif working == 1 && (obj.right_ele.current_state == 3 || obj.right_ele.current_state == 4 || obj.right_ele.current_state == 5)
                    if see1 == 0 && (~(obj.right_ele.current_floor == 1 && sec == 2 && thi == 4 && fir == 1))
                        tar1 = obj.dispatch_oneside(fir,1);
                        obj.tar_move(tar1);
                    end
                    return;
                end
            elseif obj.hold_list(fir) == obj.hold_list(thi)
                working = obj.hold_list(thi);
                if working == 0 && (obj.left_ele.current_state == 3 || obj.left_ele.current_state == 4 || obj.left_ele.current_state == 5)
                    if see2 == 0
                        tar2 = obj.dispatch_oneside(sec,2);
                        obj.tar_move(tar2);
                    end
                    return;
                elseif working == 1 && (obj.right_ele.current_state == 3 || obj.right_ele.current_state == 4 || obj.right_ele.current_state == 5)
                    if see2 == 0
                        tar2 = obj.dispatch_oneside(sec,1);
                        obj.tar_move(tar2);
                    end
                    return;
                end
            end
            
            % Schedule one elevator to react
            if see1 == 0
                tar1 = obj.dispatch(fir);
            end
            if see2 == 0
                tar2 = obj.dispatch(sec);
            end
            if see3 == 0
                tar3 = obj.dispatch(thi);
            end

            if (tar1 == tar2) & (tar2 == tar3)
                obj.tar_move(tar1);
            elseif (tar1 == tar2)
                obj.tar_move(tar2);
                obj.tar_move(tar3);
            elseif (tar2 == tar3)
                obj.tar_move(tar1);
                obj.tar_move(tar3);
            elseif (tar1 == tar3)
                obj.tar_move(tar1);
                obj.tar_move(tar2);
            else
                obj.tar_move(tar1);
                obj.tar_move(tar2);
                obj.tar_move(tar3);
            end
        end

        function inner_processone(obj,fir,c_position,c_state,side)
            see = obj.oneside_open_close_ass(fir,c_position,c_state,side);
            if side == 1
                if obj.ui.inner_left_showcase.Position(2) == 467 && fir == 7 && obj.sig_list(1) == 1 && obj.hold_list(1) ~= 1
                    obj.sig_list(1) = 0;
                    obj.hold_list(1) = -1;

                    obj.sig_list(5) = 1;
                    obj.hold_list(5) = 0;
                elseif obj.ui.inner_left_showcase.Position(2) == 352 && fir == 8 && obj.sig_list(2) == 1 && obj.hold_list(2) ~= 1
                    obj.sig_list(2) = 0;
                    obj.hold_list(2) = -1;

                    obj.sig_list(5) = 1;
                    obj.hold_list(5) = 0;
                elseif obj.ui.inner_left_showcase.Position(2) == 352 && fir == 8 && obj.sig_list(3) == 1 && obj.hold_list(3) ~= 1
                    obj.sig_list(3) = 0;
                    obj.hold_list(3) = -1;

                    obj.sig_list(5) = 1;
                    obj.hold_list(5) = 0;
                elseif obj.ui.inner_left_showcase.Position(2) == 236 && fir == 9 && obj.sig_list(4) == 1 && obj.hold_list(4) ~= 1
                    obj.sig_list(4) = 0;
                    obj.hold_list(4) = -1;

                    obj.sig_list(5) = 1;
                    obj.hold_list(5) = 0;
                end
            elseif side == 2
                if obj.ui.inner_right_showcase.Position(2) == 467 && fir == 10 && obj.sig_list(1) == 1 && obj.hold_list(1) ~= 0
                    obj.sig_list(1) = 0;
                    obj.hold_list(1) = -1;

                    obj.sig_list(13) = 1;
                    obj.hold_list(13) = 1;
                elseif obj.ui.inner_right_showcase.Position(2) == 352 && fir == 11 && obj.sig_list(2) == 1 && obj.hold_list(2) ~= 0
                    obj.sig_list(2) = 0;
                    obj.hold_list(2) = -1;

                    obj.sig_list(13) = 1;
                    obj.hold_list(13) = 1;
                elseif obj.ui.inner_right_showcase.Position(2) == 352 && fir == 11 && obj.sig_list(3) == 1 && obj.hold_list(3) ~= 0
                    obj.sig_list(3) = 0;
                    obj.hold_list(3) = -1;

                    obj.sig_list(13) = 1;
                    obj.hold_list(13) = 1;
                elseif obj.ui.inner_right_showcase.Position(2) == 236 && fir == 12 && obj.sig_list(4) == 1 && obj.hold_list(4) ~= 0
                    obj.sig_list(4) = 0;
                    obj.hold_list(4) = -1;

                    obj.sig_list(13) = 1;
                    obj.hold_list(13) = 1;
                end
            end

            % Schedule one elevator to react
            if see == 0
                tar = obj.dispatch_oneside(fir,side);
                % Assess outer interact
                if tar ~= [-1,-1]
                    if side == 1
                        % Hold list maintain
                        if c_position(side) < 352 && obj.left_ele.current_state == 1
                            if fir == 7 && obj.sig_list(2) == 1 && obj.hold_list(2) ~= 1
                                obj.hold_list(2) = side - 1;
                            end
                            if fir == 8 && obj.sig_list(2) == 1 && obj.hold_list(2) ~= 1
                                obj.hold_list(2) = side - 1;
                            end
                            if fir == 8 && obj.sig_list(3) == 1 && obj.hold_list(3) ~= 1
                                obj.hold_list(3) = side - 1;
                            end
                        elseif c_position(side) < 352 && obj.left_ele.current_state == 2
                            if fir == 9 && obj.sig_list(4) == 1 && obj.hold_list(4) ~= 1
                                obj.hold_list(4) = side - 1;
                            end
                        elseif c_position(side) > 352 && obj.left_ele.current_state == 1
                            if fir == 7 && obj.sig_list(1) == 1 && obj.hold_list(1) ~= 1
                                obj.hold_list(1) = side - 1;
                            end
                        elseif c_position(side) > 352 && obj.left_ele.current_state == 2
                            if fir == 9 && obj.sig_list(3) == 1 && obj.hold_list(3) ~= 1
                                obj.hold_list(3) = side - 1;
                            end
                            if fir == 8 && obj.sig_list(2) == 1 && obj.hold_list(2) ~= 1
                                obj.hold_list(2) = side - 1;
                            end
                            if fir == 8 && obj.sig_list(3) == 1 && obj.hold_list(3) ~= 1
                                obj.hold_list(3) = side - 1;
                            end
                        end
                        if obj.ui.inner_left_showcase.Position(2) == 352 && fir == 7 && obj.sig_list(2) == 1 && obj.hold_list(2) ~= 1
                            obj.left_ele.v = 0;obj.left_ele.a = 0;
                            if obj.left_ele.current_state == 5 || obj.left_ele.current_state == 4
                                obj.left_ele.current_state = 4;
                                obj.close(0,2,obj.delta_t,2);
                            else
                                obj.left_ele.current_state = 3;
                                obj.open(0,2,obj.delta_t,2);
                            end
                        elseif obj.ui.inner_left_showcase.Position(2) == 352 && fir == 9 && obj.sig_list(3) == 1 && obj.hold_list(3) ~= 1
                            obj.left_ele.v = 0;obj.left_ele.a = 0;
                            if obj.left_ele.current_state == 5 || obj.left_ele.current_state == 4
                                obj.left_ele.current_state = 4;
                                obj.close(0,2,obj.delta_t,3);
                            else
                                obj.left_ele.current_state = 3;
                                obj.open(0,2,obj.delta_t,3);
                            end
                        else
                            obj.tar_move(tar);
                        end
                    elseif side == 2
                        % Hold list maintain
                        if c_position(side) < 352 && obj.right_ele.current_state == 1
                            if fir == 10 && obj.sig_list(2) == 1 && obj.hold_list(2) ~= 0
                                obj.hold_list(2) = side - 1;
                            end
                            if fir == 11 && obj.sig_list(2) == 1 && obj.hold_list(2) ~= 0
                                obj.hold_list(2) = side - 1;
                            end
                            if fir == 11 && obj.sig_list(3) == 1 && obj.hold_list(3) ~= 0
                                obj.hold_list(3) = side - 1;
                            end
                        elseif c_position(side) < 352 && obj.right_ele.current_state == 2
                            if fir == 12 && obj.sig_list(4) == 1 && obj.hold_list(4) ~= 0
                                obj.hold_list(4) = side - 1;
                            end
                        elseif c_position(side) > 352 && obj.right_ele.current_state == 1
                            if fir == 10 && obj.sig_list(1) == 1 && obj.hold_list(1) ~= 0
                                obj.hold_list(1) = side - 1;
                            end
                        elseif c_position(side) > 352 && obj.right_ele.current_state == 2
                            if fir == 12 && obj.sig_list(3) == 1 && obj.hold_list(3) ~= 0
                                obj.hold_list(3) = side - 1;
                            end
                            if fir == 11 && obj.sig_list(2) == 1 && obj.hold_list(2) ~= 0
                                obj.hold_list(2) = side - 1;
                            end
                            if fir == 11 && obj.sig_list(3) == 1 && obj.hold_list(3) ~= 0
                                obj.hold_list(3) = side - 1;
                            end
                        end
                        if obj.ui.inner_right_showcase.Position(2) == 352 && fir == 10 && obj.sig_list(2) == 1 && obj.hold_list(2) ~= 0
                            obj.right_ele.v = 0;obj.right_ele.a = 0;
                            if obj.right_ele.current_state == 5 || obj.right_ele.current_state == 4
                                obj.right_ele.current_state = 4;
                                obj.close(1,2,obj.delta_t,2);
                            else
                                obj.right_ele.current_state = 3;
                                obj.open(1,2,obj.delta_t,2);
                            end
                        elseif obj.ui.inner_right_showcase.Position(2) == 352 && fir == 12 && obj.sig_list(3) == 1 && obj.hold_list(3) ~= 0
                            obj.right_ele.v = 0;obj.right_ele.a = 0;
                            if obj.right_ele.current_state == 5 || obj.right_ele.current_state == 4
                                obj.right_ele.current_state = 4;
                                obj.close(1,2,obj.delta_t,3);
                            else
                                obj.right_ele.current_state = 3;
                                obj.open(1,2,obj.delta_t,3);
                            end
                        else
                            obj.tar_move(tar);
                        end
                    end
                end

            end
        end

        function ans = ass_leftget(obj)
            ans = 0;
            for i = 1:4
                if obj.hold_list(i) == 0
                    ans = 1;return;
                end
            end
        end

        function ans = ass_rightget(obj)
            ans = 0;
            for i = 1:4
                if obj.hold_list(i) == 1
                    ans = 1;return;
                end
            end
        end

        % 1 -> inner set type, 2 -> outer set type
        function com = priority_instr(obj,instr_set,set_type,c_position,c_state,side)
            com = -1;
            % Inner prioritize
            if set_type == 1
                if (c_state(side) == 0 || c_state(side) == 3 || c_state(side) == 4 || c_state(side) == 5) && c_position(side) == 236
                    if instr_set(1) == 1 && side == 1
                        com = 9;return;
                    elseif instr_set(1) == 1 && side == 2
                        com = 12;return;
                    elseif instr_set(2) == 1 && side == 1
                        com = 8;return;
                    elseif instr_set(2) == 1 && side == 2
                        com = 11;return;
                    elseif instr_set(3) == 1 && side == 1
                        com = 7;return;
                    elseif instr_set(3) == 1 && side == 2
                        com = 10;return;
                    end
                elseif (c_state(side) == 0 || c_state(side) == 3 || c_state(side) == 4 || c_state(side) == 5) && c_position(side) == 352
                    if instr_set(2) == 1 && side == 1
                        com = 8;return;
                    elseif instr_set(2) == 1 && side == 2
                        com = 11;return;
                    elseif instr_set(1) == 1 && side == 1
                        com = 9;return;
                    elseif instr_set(1) == 1 && side == 2
                        com = 12;return;
                    elseif instr_set(3) == 1 && side == 1
                        com = 7;return;
                    elseif instr_set(3) == 1 && side == 2
                        com = 10;return;
                    end
                elseif (c_state(side) == 0 || c_state(side) == 3 || c_state(side) == 4 || c_state(side) == 5) && c_position(side) == 467
                    if instr_set(3) == 1 && side == 1
                        com = 7;return;
                    elseif instr_set(3) == 1 && side == 2
                        com = 10;return;
                    elseif instr_set(2) == 1 && side == 1
                        com = 8;return;
                    elseif instr_set(2) == 1 && side == 2
                        com = 11;return;
                    elseif instr_set(1) == 1 && side == 1
                        com = 9;return;
                    elseif instr_set(1) == 1 && side == 2
                        com = 12;return;
                    end
                elseif c_state(side) == 1 && c_position(side) > 352
                    if instr_set(3) == 1 && side == 1
                        com = 7;return;
                    elseif instr_set(3) == 1 && side == 2
                        com = 10;return;
                    end
                elseif c_state(side) == 1 && c_position(side) <= 352
                    if instr_set(2) == 1 && side == 1
                        com = 8;return;
                    elseif instr_set(2) == 1 && side == 2
                        com = 11;return;
                    elseif instr_set(3) == 1 && side == 1
                        com = 7;return;
                    elseif instr_set(3) == 1 && side == 2
                        com = 10;return;
                    end
                elseif c_state(side) == 2 && c_position(side) >= 352
                    if instr_set(2) == 1 && side == 1
                        com = 8;return;
                    elseif instr_set(2) == 1 && side == 2
                        com = 11;return;
                    elseif instr_set(1) == 1 && side == 1
                        com = 9;return;
                    elseif instr_set(1) == 1 && side == 2
                        com = 12;return;
                    end
                elseif c_state(side) == 2 && c_position(side) < 352
                    if instr_set(1) == 1 && side == 1
                        com = 9;return;
                    elseif instr_set(1) == 1 && side == 2
                        com = 12;return;
                    end
                end
            % Outer prioritize
            elseif set_type == 2
                out_handlable = [0,0,0,0];
                out_hold = [0,0,0,0];
                hold_num = 0;
                for i = 1:4
                    if instr_set(i) == 1 && obj.hold_list(i) == (side - 1)
                        out_hold(i) = i;
                        hold_num = hold_num + 1;
                    elseif instr_set(i) == 1 && obj.hold_list(i) == -1
                        out_handlable(i) = 1;
                    end
                end
                if hold_num == 1
                    for i = 1:4
                        if out_hold(i) ~= 0
                            com = i;return;
                        end
                    end
                elseif hold_num == 2 && out_hold(2) ~= 0
                    com = 2;return;
                elseif hold_num == 2 && out_hold(3) ~= 0
                    com = 2;return;
                end
                if (c_state(side) == 0 || c_state(side) == 3 || c_state(side) == 4 || c_state(side) == 5) && c_position(side) == 236
                    if out_handlable == [0,0,0,0]
                        return;
                    elseif out_handlable == [0,0,0,1]
                        com = 4;return;
                    elseif out_handlable == [0,0,1,0]
                        com = 3;return;
                    elseif out_handlable == [0,1,0,0]
                        com = 2;return;
                    elseif out_handlable == [1,0,0,0]
                        com = 1;return;
                    elseif out_handlable == [0,0,1,1]
                        com = 4;return;
                    elseif out_handlable == [0,1,0,1]
                        com = 4;return;
                    elseif out_handlable == [1,0,0,1]
                        com = 4;return;
                    elseif out_handlable == [0,1,1,0]
                        com = 2;return;
                    elseif out_handlable == [1,0,1,0]
                        com = 1;return;
                    elseif out_handlable == [1,1,0,0]
                        com = 2;return;
                    elseif out_handlable == [0,1,1,1]
                        com = 4;return;
                    elseif out_handlable == [1,0,1,1]
                        com = 4;return;
                    elseif out_handlable == [1,1,0,1]
                        com = 4;return;
                    elseif out_handlable == [1,1,1,0]
                        com = 2;return;
                    elseif out_handlable == [1,1,1,1]
                        com = 4;return;
                    end
                elseif (c_state(side) == 0 || c_state(side) == 3 || c_state(side) == 4 || c_state(side) == 5) && c_position(side) == 352
                    if out_handlable == [0,0,0,0]
                        return;
                    elseif out_handlable == [0,0,0,1]
                        com = 4;return;
                    elseif out_handlable == [0,0,1,0]
                        com = 3;return;
                    elseif out_handlable == [0,1,0,0]
                        com = 2;return;
                    elseif out_handlable == [1,0,0,0]
                        com = 1;return;
                    elseif out_handlable == [0,0,1,1]
                        com = 3;return;
                    elseif out_handlable == [0,1,0,1]
                        com = 2;return;
                    elseif out_handlable == [1,0,0,1]
                        com = 4;return;
                    elseif out_handlable == [0,1,1,0]
                        com = 2;return;
                    elseif out_handlable == [1,0,1,0]
                        com = 1;return;
                    elseif out_handlable == [1,1,0,0]
                        com = 2;return;
                    elseif out_handlable == [0,1,1,1]
                        com = 3;return;
                    elseif out_handlable == [1,0,1,1]
                        com = 3;return;
                    elseif out_handlable == [1,1,0,1]
                        com = 2;return;
                    elseif out_handlable == [1,1,1,0]
                        com = 2;return;
                    elseif out_handlable == [1,1,1,1]
                        com = 2;return;
                    end
                elseif (c_state(side) == 0 || c_state(side) == 3 || c_state(side) == 4 || c_state(side) == 5) && c_position(side) == 467
                    if out_handlable == [0,0,0,0]
                        return;
                    elseif out_handlable == [0,0,0,1]
                        com = 4;return;
                    elseif out_handlable == [0,0,1,0]
                        com = 3;return;
                    elseif out_handlable == [0,1,0,0]
                        com = 2;return;
                    elseif out_handlable == [1,0,0,0]
                        com = 1;return;
                    elseif out_handlable == [0,0,1,1]
                        com = 3;return;
                    elseif out_handlable == [0,1,0,1]
                        com = 4;return;
                    elseif out_handlable == [1,0,0,1]
                        com = 1;return;
                    elseif out_handlable == [0,1,1,0]
                        com = 3;return;
                    elseif out_handlable == [1,0,1,0]
                        com = 1;return;
                    elseif out_handlable == [1,1,0,0]
                        com = 1;return;
                    elseif out_handlable == [0,1,1,1]
                        com = 3;return;
                    elseif out_handlable == [1,0,1,1]
                        com = 1;return;
                    elseif out_handlable == [1,1,0,1]
                        com = 1;return;
                    elseif out_handlable == [1,1,1,0]
                        com = 1;return;
                    elseif out_handlable == [1,1,1,1]
                        com = 1;return;
                    end
                elseif c_state(side) == 1 && c_position(side) > 352
                    if out_handlable == [0,0,0,0]
                        return;
                    elseif out_handlable == [0,0,0,1]
                        return;
                    elseif out_handlable == [0,0,1,0]
                        return;
                    elseif out_handlable == [0,1,0,0]
                        return;
                    elseif out_handlable == [1,0,0,0]
                        com = 1;return;
                    elseif out_handlable == [0,0,1,1]
                        return;
                    elseif out_handlable == [0,1,0,1]
                        return;
                    elseif out_handlable == [1,0,0,1]
                        com = 1;return;
                    elseif out_handlable == [0,1,1,0]
                        return;
                    elseif out_handlable == [1,0,1,0]
                        com = 1;return;
                    elseif out_handlable == [1,1,0,0]
                        com = 1;return;
                    elseif out_handlable == [0,1,1,1]
                        return;
                    elseif out_handlable == [1,0,1,1]
                        com = 1;return;
                    elseif out_handlable == [1,1,0,1]
                        com = 1;return;
                    elseif out_handlable == [1,1,1,0]
                        com = 1;return;
                    elseif out_handlable == [1,1,1,1]
                        com = 1;return;
                    end
                elseif c_state(side) == 1 && c_position(side) <= 352
                    if out_handlable == [0,0,0,0]
                        return;
                    elseif out_handlable == [0,0,0,1]
                        return;
                    elseif out_handlable == [0,0,1,0]
                        com = 3;return;
                    elseif out_handlable == [0,1,0,0]
                        com = 2;return;
                    elseif out_handlable == [1,0,0,0]
                        com = 1;return;
                    elseif out_handlable == [0,0,1,1]
                        com = 3;return;
                    elseif out_handlable == [0,1,0,1]
                        com = 2;return;
                    elseif out_handlable == [1,0,0,1]
                        com = 1;return;
                    elseif out_handlable == [0,1,1,0]
                        com = 2;return;
                    elseif out_handlable == [1,0,1,0]
                        com = 1;return;
                    elseif out_handlable == [1,1,0,0]
                        com = 2;return;
                    elseif out_handlable == [0,1,1,1]
                        com = 2;return;
                    elseif out_handlable == [1,0,1,1]
                        com = 1;return;
                    elseif out_handlable == [1,1,0,1]
                        com = 2;return;
                    elseif out_handlable == [1,1,1,0]
                        com = 2;return;
                    elseif out_handlable == [1,1,1,1]
                        com = 2;return;
                    end
                elseif c_state(side) == 2 && c_position(side) >= 352
                    if out_handlable == [0,0,0,0]
                        return;
                    elseif out_handlable == [0,0,0,1]
                        com = 4;return;
                    elseif out_handlable == [0,0,1,0]
                        com = 3;return;
                    elseif out_handlable == [0,1,0,0]
                        com = 2;return;
                    elseif out_handlable == [1,0,0,0]
                        return;
                    elseif out_handlable == [0,0,1,1]
                        com = 3;return;
                    elseif out_handlable == [0,1,0,1]
                        com = 4;return;
                    elseif out_handlable == [1,0,0,1]
                        com = 4;return;
                    elseif out_handlable == [0,1,1,0]
                        com = 3;return;
                    elseif out_handlable == [1,0,1,0]
                        com = 3;return;
                    elseif out_handlable == [1,1,0,0]
                        com = 2;return;
                    elseif out_handlable == [0,1,1,1]
                        com = 3;return;
                    elseif out_handlable == [1,0,1,1]
                        com = 3;return;
                    elseif out_handlable == [1,1,0,1]
                        com = 4;return;
                    elseif out_handlable == [1,1,1,0]
                        com = 3;return;
                    elseif out_handlable == [1,1,1,1]
                        com = 3;return;
                    end
                elseif c_state(side) == 2 && c_position(side) < 352
                    if out_handlable == [0,0,0,0]
                        return;
                    elseif out_handlable == [0,0,0,1]
                        com = 4;return;
                    elseif out_handlable == [0,0,1,0]
                        return;
                    elseif out_handlable == [0,1,0,0]
                        return;
                    elseif out_handlable == [1,0,0,0]
                        return;
                    elseif out_handlable == [0,0,1,1]
                        com = 4;return;
                    elseif out_handlable == [0,1,0,1]
                        com = 4;return;
                    elseif out_handlable == [1,0,0,1]
                        com = 4;return;
                    elseif out_handlable == [0,1,1,0]
                        return;
                    elseif out_handlable == [1,0,1,0]
                        return;
                    elseif out_handlable == [1,1,0,0]
                        return;
                    elseif out_handlable == [0,1,1,1]
                        com = 4;return;
                    elseif out_handlable == [1,0,1,1]
                        com = 4;return;
                    elseif out_handlable == [1,1,0,1]
                        com = 4;return;
                    elseif out_handlable == [1,1,1,0]
                        return;
                    elseif out_handlable == [1,1,1,1]
                        com = 4;return;
                    end
                end
            end
            
        end

        function inner_handle(obj,side,side_siglist,out_sig,c_position,c_state)
            floor_sig = [side_siglist(1),side_siglist(2),side_siglist(3)];
            % Left side
            if side == 0
                % Open assess
                if side_siglist(4) == 1 && c_state(side + 1) == 5
                    obj.open(side,obj.left_ele.current_floor,obj.delta_t,5);
                elseif side_siglist(4) == 1 && (c_state(side + 1) == 0 || c_state(side + 1) == 3 || c_state(side + 1) == 4)
                    obj.hold_list(5) = 0;
                    obj.left_ele.current_state = 3;
                    obj.open(side,obj.left_ele.current_floor,obj.delta_t,5);
                elseif side_siglist(4) == 1 && (c_state(side + 1) == 1 || c_state(side + 1) == 2)
                    obj.sig_list(5) = 0;
                % Open-Max assess
                elseif side_siglist(5) == 1 && c_state(side + 1) == 5
                    obj.hold_list(6) = 0;
                    obj.left_ele.tim = obj.left_ele.tim + 0.2;
                    if obj.left_ele.tim >= obj.left_ele.open_tim
                        obj.left_ele.current_state = 4;
                        obj.left_ele.tim = 0;
                    end
                    if obj.sig_list(6) == 1
                        obj.left_ele.tim = 0;
                        obj.left_ele.current_state = 4;
                        if obj.ui.inner_left_showcase.Position(2) == 236
                            obj.sig_list(9) = 0;
                            obj.hold_list(9) = -1;
                            if obj.hold_list(4) == 0
                                obj.sig_list(4) = 0;
                                obj.hold_list(4) = -1;
                            end
                        elseif obj.ui.inner_left_showcase.Position(2) == 352
                            obj.sig_list(8) = 0;
                            obj.hold_list(8) = -1;
                            if obj.hold_list(2) == 0
                                obj.sig_list(2) = 0;
                                obj.hold_list(2) = -1;
                            end
                            if obj.hold_list(3) == 0
                                obj.sig_list(3) = 0;
                                obj.hold_list(3) = -1;
                            end
                        elseif obj.ui.inner_left_showcase.Position(2) == 467
                            obj.sig_list(7) = 0;
                            obj.hold_list(7) = -1;
                            if obj.hold_list(1) == 0
                                obj.sig_list(1) = 0;
                                obj.hold_list(1) = -1;
                            end
                        end
                    end
                % Close assess
                elseif side_siglist(5) == 1 && c_state(side + 1) == 4
                    obj.hold_list(6) = 0;
                    obj.left_ele.current_state = 4;
                    obj.close(side,obj.left_ele.current_floor,obj.delta_t,6);

                    if obj.ui.inner_left_showcase.Position(2) == 236
                        if obj.sig_list(4) == 1 || obj.sig_list(9) == 1
                            obj.sig_list(4) = 0;
                            obj.hold_list(4) = -1;
                            obj.sig_list(9) = 0;
                            obj.hold_list(9) = -1;
                            obj.sig_list(5) = 1;
                            obj.hold_list(5) = 0;
                            obj.sig_list(6) = 0;
                            obj.hold_list(6) = -1;
                        end
                    elseif obj.ui.inner_left_showcase.Position(2) == 352
                        if obj.hold_list(2) == 0 && obj.hold_list(3) ~= 0
                            if obj.sig_list(2) == 1 || obj.sig_list(8) == 1
                                obj.sig_list(2) = 0;
                                obj.hold_list(2) = -1;
                                obj.sig_list(8) = 0;
                                obj.hold_list(8) = -1;
                                obj.sig_list(5) = 1;
                                obj.hold_list(5) = 0;
                                obj.sig_list(6) = 0;
                                obj.hold_list(6) = -1;
                            end
                        elseif obj.hold_list(2) ~= 0 && obj.hold_list(3) == 0
                            if obj.sig_list(3) == 1 || obj.sig_list(8) == 1
                                obj.sig_list(3) = 0;
                                obj.hold_list(3) = -1;
                                obj.sig_list(8) = 0;
                                obj.hold_list(8) = -1;
                                obj.sig_list(5) = 1;
                                obj.hold_list(5) = 0;
                                obj.sig_list(6) = 0;
                                obj.hold_list(6) = -1;
                            end
                        end
                    elseif obj.ui.inner_left_showcase.Position(2) == 467
                        if obj.sig_list(1) == 1 || obj.sig_list(7) == 1
                            obj.sig_list(1) = 0;
                            obj.hold_list(1) = -1;
                            obj.sig_list(7) = 0;
                            obj.hold_list(7) = -1;
                            obj.sig_list(5) = 1;
                            obj.hold_list(5) = 0;
                            obj.sig_list(6) = 0;
                            obj.hold_list(6) = -1;
                        end
                    end
                elseif side_siglist(5) == 1 && (c_state(side + 1) == 0 || c_state(side + 1) == 1 ||c_state(side + 1) == 2 ||c_state(side + 1) == 3)
                    obj.sig_list(6) = 0;
                % Floor call
                else
                    com = obj.priority_instr(floor_sig,1,c_position,c_state,side + 1);
                    if com ~= -1
                        obj.inner_processone(com,c_position,c_state,side + 1);
                    elseif com == -1
                        obj.left_inner_p.whether_havesig = 0;
                    end
                end
            % Right side
            elseif side == 1
                % Open assess
                if side_siglist(4) == 1 && c_state(side + 1) == 5
                    obj.open(side,obj.right_ele.current_floor,obj.delta_t,13);
                elseif side_siglist(4) == 1 && (c_state(side + 1) == 0 || c_state(side + 1) == 3 || c_state(side + 1) == 4)
                    obj.hold_list(13) = 1;
                    obj.right_ele.current_state = 3;
                    obj.open(side,obj.right_ele.current_floor,obj.delta_t,13);
                elseif side_siglist(4) == 1 && (c_state(side + 1) == 1 || c_state(side + 1) == 2)
                    obj.sig_list(13) = 0;
                % Open-Max assess
                elseif side_siglist(5) == 1 && c_state(side + 1) == 5
                    obj.hold_list(14) = 1;
                    obj.right_ele.tim = obj.right_ele.tim + 0.2;
                    if obj.right_ele.tim >= obj.right_ele.open_tim
                        obj.right_ele.current_state = 4;
                        obj.right_ele.tim = 0;
                    end
                    if obj.sig_list(14) == 1
                        obj.right_ele.tim = 0;
                        obj.right_ele.current_state = 4;
                        if obj.ui.inner_right_showcase.Position(2) == 236
                            obj.sig_list(12) = 0;
                            obj.hold_list(12) = -1;
                            if obj.hold_list(4) == 1
                                obj.sig_list(4) = 0;
                                obj.hold_list(4) = -1;
                            end
                        elseif obj.ui.inner_right_showcase.Position(2) == 352
                            obj.sig_list(11) = 0;
                            obj.hold_list(11) = -1;
                            if obj.hold_list(2) == 1
                                obj.sig_list(2) = 0;
                                obj.hold_list(2) = -1;
                            end
                            if obj.hold_list(3) == 1
                                obj.sig_list(3) = 0;
                                obj.hold_list(3) = -1;
                            end
                        elseif obj.ui.inner_right_showcase.Position(2) == 467
                            obj.sig_list(10) = 0;
                            obj.hold_list(10) = -1;
                            if obj.hold_list(1) == 1
                                obj.sig_list(1) = 0;
                                obj.hold_list(1) = -1;
                            end
                        end
                    end
                % Close assess
                elseif side_siglist(5) == 1 && c_state(side + 1) == 4
                    obj.hold_list(14) = 1;
                    obj.right_ele.current_state = 4;
                    obj.close(side,obj.right_ele.current_floor,obj.delta_t,14);

                    if obj.ui.inner_right_showcase.Position(2) == 236
                        if obj.sig_list(4) == 1 && obj.sig_list(12) == 1
                            obj.sig_list(4) = 0;
                            obj.hold_list(4) = -1;
                            obj.sig_list(12) = 0;
                            obj.hold_list(12) = -1;
                            obj.sig_list(13) = 1;
                            obj.hold_list(13) = 1;
                            obj.sig_list(14) = 0;
                            obj.hold_list(14) = -1;
                        end
                    elseif obj.ui.inner_right_showcase.Position(2) == 352
                        if obj.hold_list(2) == 1 && obj.hold_list(3) ~= 1
                            if obj.sig_list(2) == 1 && obj.sig_list(11) == 1
                                obj.sig_list(2) = 0;
                                obj.hold_list(2) = -1;
                                obj.sig_list(11) = 0;
                                obj.hold_list(11) = -1;
                                obj.sig_list(13) = 1;
                                obj.hold_list(13) = 1;
                                obj.sig_list(14) = 0;
                                obj.hold_list(14) = -1;
                            end
                        elseif obj.hold_list(2) ~= 1 && obj.hold_list(3) == 1
                            if obj.sig_list(3) == 1 && obj.sig_list(11) == 1
                                obj.sig_list(3) = 0;
                                obj.hold_list(3) = -1;
                                obj.sig_list(11) = 0;
                                obj.hold_list(11) = -1;
                                obj.sig_list(13) = 1;
                                obj.hold_list(13) = 1;
                                obj.sig_list(14) = 0;
                                obj.hold_list(14) = -1;
                            end
                        end
                    elseif obj.ui.inner_right_showcase.Position(2) == 467
                        if obj.sig_list(1) == 1 && obj.sig_list(10) == 1
                            obj.sig_list(1) = 0;
                            obj.hold_list(1) = -1;
                            obj.sig_list(10) = 0;
                            obj.hold_list(10) = -1;
                            obj.sig_list(13) = 1;
                            obj.hold_list(13) = 1;
                            obj.sig_list(14) = 0;
                            obj.hold_list(14) = -1;
                        end
                    end
                elseif side_siglist(5) == 1 && (c_state(side + 1) == 0 || c_state(side + 1) == 1 ||c_state(side + 1) == 2 ||c_state(side + 1) == 3)
                    obj.sig_list(14) = 0;
                % Floor call
                else
                    com = obj.priority_instr(floor_sig,1,c_position,c_state,side + 1);
                    if com ~= -1
                        obj.inner_processone(com,c_position,c_state,side + 1);
                    elseif com == -1
                        obj.right_inner_p.whether_havesig = 0;
                    end
                end
            end
        end

        % Let side(1->left,2->right) elevator to handle some outer signal
        function outer_handle_oneside(obj,side,out_sig,c_position,c_state)
            if side == 1
                if (obj.hold_list(1) == 1) || (c_position(2) == 467 && c_state(2) ~= 2) || (c_position(1) == 236 && c_state(2) ~= 2 && obj.hold_list(3) ~= 1)
                    out_sig(1) = 0;
                end
                if (obj.hold_list(2) == 1) || (c_position(2) == 352 && c_position(1) ~= 352 && c_state(2) ~= 2 && obj.hold_list(3) ~= 1 && obj.hold_list(4) ~= 1 && obj.sig_list(12) ~= 1)
                    out_sig(2) = 0;
                end
                if (obj.hold_list(3) == 1) || (c_position(2) == 352 && c_position(1) ~= 352 && c_state(2) ~= 1 && obj.hold_list(1) ~= 1 && obj.hold_list(2) ~= 1 && obj.sig_list(10) ~= 1)
                    out_sig(3) = 0;
                end
                if (obj.hold_list(4) == 1) || (c_position(2) == 236 && c_state(2) ~= 1) || (c_position(1) == 467 && c_state(2) ~= 1 && obj.hold_list(2) ~= 1)
                    out_sig(4) = 0;
                end
            elseif side == 2
                if (obj.hold_list(1) == 0) || (c_position(1) == 467 && c_state(1) ~= 2) || (c_position(2) == 236 && c_state(1) ~= 2 && obj.hold_list(3) ~= 0)
                    out_sig(1) = 0;
                end
                if (obj.hold_list(2) == 0) || (c_position(1) == 352 && c_position(2) ~= 352 && c_state(1) ~= 2 && obj.hold_list(3) ~= 0 && obj.hold_list(4) ~= 0 && obj.sig_list(9) ~= 1)
                    out_sig(2) = 0;
                end
                if (obj.hold_list(3) == 0) || (c_position(1) == 352 && c_position(2) ~= 352 && c_state(1) ~= 1 && obj.hold_list(1) ~= 0 && obj.hold_list(2) ~= 0 && obj.sig_list(7) ~= 1)
                    out_sig(3) = 0;
                end
                if (obj.hold_list(4) == 0) || (c_position(1) == 236 && c_state(1) ~= 1) || (c_position(2) == 467 && c_state(1) ~= 1 && obj.hold_list(2) ~= 0)
                    out_sig(4) = 0;
                end
            end
            com = obj.priority_instr(out_sig,2,c_position,c_state,side);
            see = oneside_open_close_ass(obj,com,c_position,c_state,side);
            if com ~= -1 && see == 0
                tar = obj.dispatch_oneside(com,side);
                obj.tar_move(tar);
            end
        end

        function theone = choose_hold(obj,a,b,side)
            theone = -1;
            if obj.hold_list(a) == side
                theone = b;
                return;
            elseif obj.hold_list(b) == side
                theone = a;
                return;
            end
        end

        function ass_repeat(obj)
            if obj.left_ele.current_state == 5 && (obj.left_ele.tim >= obj.left_ele.open_tim)
                obj.sig_list(5) = 0;
                obj.hold_list(5) = -1;
            end
            if obj.right_ele.current_state == 5 && (obj.right_ele.tim >= obj.right_ele.open_tim)
                obj.sig_list(13) = 0;
                obj.hold_list(13) = -1;
            end
            if obj.left_ele.current_state ~= 5 && obj.sig_list(5) == 1 && obj.sig_list(6) == 1
                obj.sig_list(6) = 0;
                obj.hold_list(6) = -1;
            end
            if obj.right_ele.current_state ~= 5 && obj.sig_list(13) == 1 && obj.sig_list(14) == 1
                obj.sig_list(14) = 0;
                obj.hold_list(14) = -1;
            end
            % Open and close shut
            if obj.ui.inner_left_showcase.Position(2) ~= 236 && obj.ui.inner_left_showcase.Position(2) ~= 352 && obj.ui.inner_left_showcase.Position(2) ~= 467
                obj.sig_list(5) = 0;
                obj.hold_list(5) = -1;
                obj.sig_list(6) = 0;
                obj.hold_list(6) = -1;
            end
            if obj.ui.inner_right_showcase.Position(2) ~= 236 && obj.ui.inner_right_showcase.Position(2) ~= 352 && obj.ui.inner_right_showcase.Position(2) ~= 467
                obj.sig_list(13) = 0;
                obj.hold_list(13) = -1;
                obj.sig_list(14) = 0;
                obj.hold_list(14) = -1;
            end
            % Same target instruction shut
            % Left situation
            if obj.left_ele.current_state == 4
                if obj.ui.inner_left_showcase.Position(2) == 236
                    if obj.sig_list(5) == 1
                        obj.sig_list(4) = 0;
                        obj.hold_list(4) = -1;
                        obj.sig_list(9) = 0;
                        obj.hold_list(9) = -1;
                    elseif (obj.sig_list(4) == 1 && obj.hold_list(4) ~= 1) || obj.sig_list(9) == 1
                        obj.sig_list(4) = 0;
                        obj.hold_list(4) = -1;
                        obj.sig_list(9) = 0;
                        obj.hold_list(9) = -1;
                        if obj.ui.l_l_1.Position(1) == -3
                            obj.left_ele.tim = obj.left_ele.open_tim;
                        end
                        obj.sig_list(5) = 1;
                        obj.hold_list(5) = 0;
                    end
                elseif obj.ui.inner_left_showcase.Position(2) == 352
                    if obj.hold_list(2) ~= 0 && obj.hold_list(3) ~= 0
                        if obj.sig_list(5) == 1
                            obj.sig_list(8) = 0;
                            obj.hold_list(8) = -1;
                        elseif (obj.sig_list(2) == 1 && obj.ui.inner_right_showcase.Position(2) ~= 352 && (~(obj.sig_list(9) == 1 && obj.sig_list(7) == 0))) || obj.sig_list(8) == 1
                            obj.sig_list(2) = 0;
                            obj.hold_list(2) = -1;
                            obj.sig_list(8) = 0;
                            obj.hold_list(8) = -1;
                            if obj.ui.l_l_2.Position(1) == -3
                                obj.left_ele.tim = obj.left_ele.open_tim;
                            end
                            obj.sig_list(5) = 1;
                            obj.hold_list(5) = 0;
                        elseif (obj.sig_list(3) == 1 && obj.ui.inner_right_showcase.Position(2) ~= 352 && (~(obj.sig_list(7) == 1 && obj.sig_list(9) == 0))) || obj.sig_list(8) == 1
                            obj.sig_list(3) = 0;
                            obj.hold_list(3) = -1;
                            obj.sig_list(8) = 0;
                            obj.hold_list(8) = -1;
                            if obj.ui.l_l_2.Position(1) == -3
                                obj.left_ele.tim = obj.left_ele.open_tim;
                            end
                            obj.sig_list(5) = 1;
                            obj.hold_list(5) = 0;
                        end
                        if obj.sig_list(2) == 1 && obj.hold_list(2) ~= 1 && obj.ui.inner_right_showcase.Position(2) == 352
                            obj.sig_list(2) = 0;
                            obj.hold_list(2) = -1;
                            obj.sig_list(8) = 0;
                            obj.hold_list(8) = -1;
                            if obj.ui.l_l_2.Position(1) == -3
                                obj.left_ele.tim = obj.left_ele.open_tim;
                            end
                            obj.sig_list(5) = 1;
                            obj.hold_list(5) = 0;
                        end
                    elseif obj.hold_list(2) == 0 && obj.hold_list(3) ~= 0
                        if obj.sig_list(5) == 1
                            obj.sig_list(2) = 0;
                            obj.hold_list(2) = -1;
                            obj.sig_list(8) = 0;
                            obj.hold_list(8) = -1;
                        elseif obj.sig_list(2) == 1 && obj.sig_list(8) == 1
                            obj.sig_list(2) = 0;
                            obj.hold_list(2) = -1;
                            obj.sig_list(8) = 0;
                            obj.hold_list(8) = -1;
                            if obj.ui.l_l_2.Position(1) == -3
                                obj.left_ele.tim = obj.left_ele.open_tim;
                            end
                            obj.sig_list(5) = 1;
                            obj.hold_list(5) = 0;
                        end
                    elseif obj.hold_list(2) ~= 0 && obj.hold_list(3) == 0
                        if obj.sig_list(5) == 1
                            obj.sig_list(3) = 0;
                            obj.hold_list(3) = -1;
                            obj.sig_list(8) = 0;
                            obj.hold_list(8) = -1;
                        elseif obj.sig_list(3) == 1 && obj.sig_list(8) == 1
                            obj.sig_list(3) = 0;
                            obj.hold_list(3) = -1;
                            obj.sig_list(8) = 0;
                            obj.hold_list(8) = -1;
                            if obj.ui.l_l_2.Position(1) == -3
                                obj.left_ele.tim = obj.left_ele.open_tim;
                            end
                            obj.sig_list(5) = 1;
                            obj.hold_list(5) = 0;
                        end
                    end
                elseif obj.ui.inner_left_showcase.Position(2) == 467
                    if obj.sig_list(5) == 1
                        obj.sig_list(1) = 0;
                        obj.hold_list(1) = -1;
                        obj.sig_list(7) = 0;
                        obj.hold_list(7) = -1;
                    elseif (obj.sig_list(1) == 1 && obj.hold_list(1) ~= 1) || obj.sig_list(7) == 1
                        obj.sig_list(1) = 0;
                        obj.hold_list(1) = -1;
                        obj.sig_list(7) = 0;
                        obj.hold_list(7) = -1;
                        if obj.ui.l_l_3.Position(1) == -3
                            obj.left_ele.tim = obj.left_ele.open_tim;
                        end
                        obj.sig_list(5) = 1;
                        obj.hold_list(5) = 0;
                    end
                end
            elseif obj.left_ele.current_state == 3
                if obj.ui.inner_left_showcase.Position(2) == 236
                    if obj.sig_list(5) == 1
                        obj.sig_list(4) = 0;
                        obj.hold_list(4) = -1;
                        obj.sig_list(9) = 0;
                        obj.hold_list(9) = -1;
                    elseif obj.sig_list(4) == 1 && obj.sig_list(9) == 1 && obj.hold_list(4) ~= 1
                        clear_sig = obj.choose_hold(9,4,0);
                        obj.sig_list(clear_sig) = 0;
                        obj.hold_list(clear_sig) = -1;
                    end
                elseif obj.ui.inner_left_showcase.Position(2) == 352
                    if obj.hold_list(2) ~= 0 && obj.hold_list(3) ~= 0
                        if obj.sig_list(5) == 1
                            obj.sig_list(8) = 0;
                            obj.hold_list(8) = -1;
                        end
                    elseif obj.hold_list(2) == 0 && obj.hold_list(3) ~= 0
                        if obj.sig_list(5) == 1
                            obj.sig_list(2) = 0;
                            obj.hold_list(2) = -1;
                            obj.sig_list(8) = 0;
                            obj.hold_list(8) = -1;
                        elseif obj.sig_list(2) == 1 && obj.sig_list(8) == 1
                            clear_sig = obj.choose_hold(8,2,0);
                            obj.sig_list(clear_sig) = 0;
                            obj.hold_list(clear_sig) = -1;
                        end
                    elseif obj.hold_list(2) ~= 0 && obj.hold_list(3) == 0
                        if obj.sig_list(5) == 1
                            obj.sig_list(3) = 0;
                            obj.hold_list(3) = -1;
                            obj.sig_list(8) = 0;
                            obj.hold_list(8) = -1;
                        elseif obj.sig_list(3) == 1 && obj.sig_list(8) == 1
                            clear_sig = obj.choose_hold(8,3,0);
                            obj.sig_list(clear_sig) = 0;
                            obj.hold_list(clear_sig) = -1;
                        end
                    end
                elseif obj.ui.inner_left_showcase.Position(2) == 467
                    if obj.sig_list(5) == 1
                        obj.sig_list(1) = 0;
                        obj.hold_list(1) = -1;
                        obj.sig_list(7) = 0;
                        obj.hold_list(7) = -1;
                    elseif obj.sig_list(1) == 1 && obj.sig_list(7) == 1 && obj.hold_list(1) ~= 1
                        clear_sig = obj.choose_hold(7,1,0);
                        obj.sig_list(clear_sig) = 0;
                        obj.hold_list(clear_sig) = -1;
                    end
                end
            end
            % Right situation
            if obj.right_ele.current_state == 4
                if obj.ui.inner_right_showcase.Position(2) == 236
                    if obj.sig_list(13) == 1
                        obj.sig_list(4) = 0;
                        obj.hold_list(4) = -1;
                        obj.sig_list(12) = 0;
                        obj.hold_list(12) = -1;
                    elseif (obj.sig_list(4) == 1 && obj.hold_list(4) ~= 0) || obj.sig_list(12) == 1
                        obj.sig_list(4) = 0;
                        obj.hold_list(4) = -1;
                        obj.sig_list(12) = 0;
                        obj.hold_list(12) = -1;
                        if obj.ui.r_l_1.Position(1) == 663
                            obj.right_ele.tim = obj.right_ele.open_tim;
                        end
                        obj.sig_list(13) = 1;
                        obj.hold_list(13) = 1;
                    end
                elseif obj.ui.inner_right_showcase.Position(2) == 352
                    if obj.hold_list(2) ~= 1 && obj.hold_list(3) ~= 1
                        if obj.sig_list(13) == 1
                            obj.sig_list(11) = 0;
                            obj.hold_list(11) = -1;
                        elseif (obj.sig_list(2) == 1 && obj.ui.inner_left_showcase.Position(2) ~= 352 && (~(obj.sig_list(12) == 1 && obj.sig_list(10) == 0))) || obj.sig_list(11) == 1
                            obj.sig_list(2) = 0;
                            obj.hold_list(2) = -1;
                            obj.sig_list(11) = 0;
                            obj.hold_list(11) = -1;
                            if obj.ui.r_l_2.Position(1) == 663
                                obj.right_ele.tim = obj.right_ele.open_tim;
                            end
                            obj.sig_list(13) = 1;
                            obj.hold_list(13) = 0;
                        elseif (obj.sig_list(3) == 1 && obj.ui.inner_left_showcase.Position(2) ~= 352 && (~(obj.sig_list(10) == 1 && obj.sig_list(12) == 0))) || obj.sig_list(11) == 1
                            obj.sig_list(3) = 0;
                            obj.hold_list(3) = -1;
                            obj.sig_list(11) = 0;
                            obj.hold_list(11) = -1;
                            if obj.ui.r_l_2.Position(1) == 663
                                obj.right_ele.tim = obj.right_ele.open_tim;
                            end
                            obj.sig_list(13) = 1;
                            obj.hold_list(13) = 1;
                        end
                        if obj.sig_list(3) == 1 && obj.hold_list(3) ~= 0 && obj.ui.inner_left_showcase.Position(2) == 352
                            obj.sig_list(3) = 0;
                            obj.hold_list(3) = -1;
                            obj.sig_list(11) = 0;
                            obj.hold_list(11) = -1;
                            if obj.ui.r_l_2.Position(1) == 663
                                obj.right_ele.tim = obj.right_ele.open_tim;
                            end
                            obj.sig_list(13) = 1;
                            obj.hold_list(13) = 1;
                        end
                    elseif obj.hold_list(2) == 1 && obj.hold_list(3) ~= 1
                        if obj.sig_list(13) == 1
                            obj.sig_list(2) = 0;
                            obj.hold_list(2) = -1;
                            obj.sig_list(11) = 0;
                            obj.hold_list(11) = -1;
                        elseif obj.sig_list(2) == 1 && obj.sig_list(11) == 1
                            obj.sig_list(2) = 0;
                            obj.hold_list(2) = -1;
                            obj.sig_list(11) = 0;
                            obj.hold_list(11) = -1;
                            if obj.ui.r_l_2.Position(1) == 663
                                obj.right_ele.tim = obj.right_ele.open_tim;
                            end
                            obj.sig_list(13) = 1;
                            obj.hold_list(13) = 1;
                        end
                    elseif obj.hold_list(2) ~= 1 && obj.hold_list(3) == 1
                        if obj.sig_list(13) == 1
                            obj.sig_list(3) = 0;
                            obj.hold_list(3) = -1;
                            obj.sig_list(11) = 0;
                            obj.hold_list(11) = -1;
                        elseif obj.sig_list(3) == 1 && obj.sig_list(11) == 1
                            obj.sig_list(3) = 0;
                            obj.hold_list(3) = -1;
                            obj.sig_list(11) = 0;
                            obj.hold_list(11) = -1;
                            if obj.ui.r_l_2.Position(1) == 663
                                obj.right_ele.tim = obj.right_ele.open_tim;
                            end
                            obj.sig_list(13) = 1;
                            obj.hold_list(13) = 1;
                        end
                    end
                elseif obj.ui.inner_right_showcase.Position(2) == 467
                    if obj.sig_list(13) == 1
                        obj.sig_list(1) = 0;
                        obj.hold_list(1) = -1;
                        obj.sig_list(10) = 0;
                        obj.hold_list(10) = -1;
                    elseif (obj.sig_list(1) == 1 && obj.hold_list(1) ~= 0) || obj.sig_list(10) == 1
                        obj.sig_list(1) = 0;
                        obj.hold_list(1) = -1;
                        obj.sig_list(10) = 0;
                        obj.hold_list(10) = -1;
                        if obj.ui.r_l_3.Position(1) == 663
                            obj.right_ele.tim = obj.right_ele.open_tim;
                        end
                        obj.sig_list(13) = 1;
                        obj.hold_list(13) = 1;
                    end
                end
            elseif obj.right_ele.current_state == 3
                if obj.ui.inner_right_showcase.Position(2) == 236
                    if obj.sig_list(13) == 1
                        obj.sig_list(4) = 0;
                        obj.hold_list(4) = -1;
                        obj.sig_list(12) = 0;
                        obj.hold_list(12) = -1;
                    elseif obj.sig_list(4) == 1 && obj.sig_list(12) == 1 && obj.hold_list(4) ~= 0
                        clear_sig = obj.choose_hold(12,4,1);
                        obj.sig_list(clear_sig) = 0;
                        obj.hold_list(clear_sig) = -1;
                    end
                elseif obj.ui.inner_right_showcase.Position(2) == 352
                    if obj.hold_list(2) ~= 1 && obj.hold_list(3) ~= 1
                        if obj.sig_list(13) == 1
                            obj.sig_list(11) = 0;
                            obj.hold_list(11) = -1;
                        end
                    elseif obj.hold_list(2) == 1 && obj.hold_list(3) ~= 1
                        if obj.sig_list(13) == 1
                            obj.sig_list(2) = 0;
                            obj.hold_list(2) = -1;
                            obj.sig_list(11) = 0;
                            obj.hold_list(11) = -1;
                        elseif obj.sig_list(2) == 1 && obj.sig_list(11) == 1
                            clear_sig = obj.choose_hold(11,2,1);
                            obj.sig_list(clear_sig) = 0;
                            obj.hold_list(clear_sig) = -1;
                        end
                    elseif obj.hold_list(2) ~= 1 && obj.hold_list(3) == 1
                        if obj.sig_list(13) == 1
                            obj.sig_list(3) = 0;
                            obj.hold_list(3) = -1;
                            obj.sig_list(11) = 0;
                            obj.hold_list(11) = -1;
                        elseif obj.sig_list(3) == 1 && obj.sig_list(11) == 1
                            clear_sig = obj.choose_hold(11,3,1);
                            obj.sig_list(clear_sig) = 0;
                            obj.hold_list(clear_sig) = -1;
                        end
                    end
                elseif obj.ui.inner_right_showcase.Position(2) == 467
                    if obj.sig_list(13) == 1
                        obj.sig_list(1) = 0;
                        obj.hold_list(1) = -1;
                        obj.sig_list(10) = 0;
                        obj.hold_list(10) = -1;
                    elseif obj.sig_list(1) == 1 && obj.sig_list(10) == 1 && obj.hold_list(1) ~= 0
                        clear_sig = obj.choose_hold(10,1,1);
                        obj.sig_list(clear_sig) = 0;
                        obj.hold_list(clear_sig) = -1;
                    end
                end
            end
        end

        % Timer function
        function lookup(obj,~,~)
            % When first button down, start system
            if all(obj.sig_list(:) == 0)
                return;
            end

            obj.ass_repeat();

            whether_left_get_outer = obj.ass_leftget();
            whether_right_get_outer = obj.ass_rightget();

            if obj.sig_list(5) == 0 && obj.sig_list(6) == 0 && obj.sig_list(7) == 0 && obj.sig_list(8) == 0 && obj.sig_list(9) == 0
                obj.left_inner_p.whether_havesig = 0;
            else 
                obj.left_inner_p.whether_havesig = 1;
            end
            if obj.sig_list(10) == 0 && obj.sig_list(11) == 0 && obj.sig_list(12) == 0 && obj.sig_list(13) == 0 && obj.sig_list(14) == 0
                obj.right_inner_p.whether_havesig = 0;
            else
                obj.right_inner_p.whether_havesig = 1;
            end

            c_state = [obj.left_ele.current_state,obj.right_ele.current_state];
            c_position = [obj.ui.inner_left_showcase.Position(2),obj.ui.inner_right_showcase.Position(2)];
            % Call 3 down, 2 up, 2 down, 1 up
            outer_sig = [obj.sig_list(1),obj.sig_list(2),obj.sig_list(3),obj.sig_list(4)];
            % Call 1,2,3 open close
            inner_left_sig = [obj.sig_list(9),obj.sig_list(8),obj.sig_list(7),obj.sig_list(5),obj.sig_list(6)];
            inner_right_sig = [obj.sig_list(12),obj.sig_list(11),obj.sig_list(10),obj.sig_list(13),obj.sig_list(14)];

            if whether_left_get_outer == 1
                if (c_position(1) <= 352 && (obj.hold_list(1) == 0 || obj.hold_list(2) == 0 || obj.hold_list(3) == 0) && obj.hold_list(4) ~= 0 && (obj.sig_list(8) == 1 || obj.sig_list(5) == 1 || obj.sig_list(6) == 1))...
                        || (c_position(1) >= 352 && (obj.hold_list(4) == 0 || obj.hold_list(3) == 0 || obj.hold_list(2) == 0) && obj.hold_list(1) ~= 0 && (obj.sig_list(8) == 1 || obj.sig_list(5) == 1 || obj.sig_list(6) == 1))
                    whether_left_get_outer = 0;
                end
            end
            if whether_right_get_outer == 1
                if (c_position(2) <= 352 && (obj.hold_list(1) == 1 || obj.hold_list(2) == 1 || obj.hold_list(3) == 1) && obj.hold_list(4) ~= 1 && (obj.sig_list(11) == 1 || obj.sig_list(13) == 1 || obj.sig_list(14) == 1))...
                        || (c_position(2) >= 352 && (obj.hold_list(4) == 1 || obj.hold_list(3) == 1 || obj.hold_list(2) == 1) && obj.hold_list(1) ~= 1 && obj.sig_list(11) == 1)
                    whether_right_get_outer = 0;
                end
            end

            % If there are some inner signal, prioritize it
            if obj.left_inner_p.whether_havesig && obj.right_inner_p.whether_havesig
                if whether_left_get_outer == 1 && whether_right_get_outer == 1
                    obj.left_inner_p.whether_havesig = 0;obj.right_inner_p.whether_havesig = 0;
                elseif whether_left_get_outer == 1 && whether_right_get_outer == 0
                    obj.inner_handle(1,inner_right_sig,outer_sig,c_position,c_state);

                    % Update state
                    c_state = [obj.left_ele.current_state,obj.right_ele.current_state];
                    c_position = [obj.ui.inner_left_showcase.Position(2),obj.ui.inner_right_showcase.Position(2)];
                    outer_sig = [obj.sig_list(1),obj.sig_list(2),obj.sig_list(3),obj.sig_list(4)];
                    % Update state

                    obj.outer_handle_oneside(1,outer_sig,c_position,c_state);
                elseif whether_left_get_outer == 0 && whether_right_get_outer == 1
                    obj.inner_handle(0,inner_left_sig,outer_sig,c_position,c_state);

                    % Update state
                    c_state = [obj.left_ele.current_state,obj.right_ele.current_state];
                    c_position = [obj.ui.inner_left_showcase.Position(2),obj.ui.inner_right_showcase.Position(2)];
                    outer_sig = [obj.sig_list(1),obj.sig_list(2),obj.sig_list(3),obj.sig_list(4)];
                    % Update state

                    obj.outer_handle_oneside(2,outer_sig,c_position,c_state);
                elseif whether_left_get_outer == 0 && whether_right_get_outer == 0
                    obj.inner_handle(0,inner_left_sig,outer_sig,c_position,c_state);

                    % Update state
                    c_state = [obj.left_ele.current_state,obj.right_ele.current_state];
                    c_position = [obj.ui.inner_left_showcase.Position(2),obj.ui.inner_right_showcase.Position(2)];
                    outer_sig = [obj.sig_list(1),obj.sig_list(2),obj.sig_list(3),obj.sig_list(4)];
                    % Update state

                    obj.inner_handle(1,inner_right_sig,outer_sig,c_position,c_state);
                end
            % Left inner have, right don't have
            elseif obj.left_inner_p.whether_havesig && ~obj.right_inner_p.whether_havesig
                if whether_left_get_outer == 1
                    obj.left_inner_p.whether_havesig = 0;obj.right_inner_p.whether_havesig = 0;
                else
                    obj.inner_handle(0,inner_left_sig,outer_sig,c_position,c_state);

                    % Update state
                    c_state = [obj.left_ele.current_state,obj.right_ele.current_state];
                    c_position = [obj.ui.inner_left_showcase.Position(2),obj.ui.inner_right_showcase.Position(2)];
                    outer_sig = [obj.sig_list(1),obj.sig_list(2),obj.sig_list(3),obj.sig_list(4)];
                    % Update state

                    obj.outer_handle_oneside(2,outer_sig,c_position,c_state);
                end
            % Right inner have, left don't have
            elseif ~obj.left_inner_p.whether_havesig && obj.right_inner_p.whether_havesig
                if whether_right_get_outer == 1
                    obj.left_inner_p.whether_havesig = 0;obj.right_inner_p.whether_havesig = 0;
                else
                    obj.inner_handle(1,inner_right_sig,outer_sig,c_position,c_state);
                    
                    % Update state
                    c_state = [obj.left_ele.current_state,obj.right_ele.current_state];
                    c_position = [obj.ui.inner_left_showcase.Position(2),obj.ui.inner_right_showcase.Position(2)];
                    outer_sig = [obj.sig_list(1),obj.sig_list(2),obj.sig_list(3),obj.sig_list(4)];
                    % Update state

                    obj.outer_handle_oneside(1,outer_sig,c_position,c_state);
                end
            end

            % Update state
            c_state = [obj.left_ele.current_state,obj.right_ele.current_state];
            c_position = [obj.ui.inner_left_showcase.Position(2),obj.ui.inner_right_showcase.Position(2)];
            outer_sig = [obj.sig_list(1),obj.sig_list(2),obj.sig_list(3),obj.sig_list(4)];
            % Update state
            
            if ~obj.left_inner_p.whether_havesig && ~obj.right_inner_p.whether_havesig
                % !!!Condition of outer third floor call
                if outer_sig == [1,0,0,0]
                    obj.process_onesig(1,c_position,c_state);

                % !!!Condition of outer second floor up call
                elseif outer_sig == [0,1,0,0]
                    obj.process_onesig(2,c_position,c_state);

                % !!!Condition of outer second floor down call
                elseif outer_sig == [0,0,1,0]
                    obj.process_onesig(3,c_position,c_state);
                
                % !!!Condition of outer first floor call
                elseif outer_sig == [0,0,0,1]
                    obj.process_onesig(4,c_position,c_state);
                
                % !!!Condition of outer TWO floor call
                elseif outer_sig == [1,1,0,0]
                    obj.process_twosig(1,2,c_position,c_state);
                
                elseif outer_sig == [1,0,1,0]
                    obj.process_twosig(1,3,c_position,c_state);
                
                elseif outer_sig == [1,0,0,1]
                    obj.process_twosig(1,4,c_position,c_state);
                
                elseif outer_sig == [0,1,1,0]
                    obj.open_close_asstwotwo(c_position,c_state);

                elseif outer_sig == [0,1,0,1]
                    obj.process_twosig(2,4,c_position,c_state);
                
                elseif outer_sig == [0,0,1,1]
                    obj.process_twosig(3,4,c_position,c_state);

                % !!!Condition of outer THREE floor call
                elseif outer_sig == [1,1,1,0]
                    obj.process_threesig(1,2,3,c_position,c_state);
                
                elseif outer_sig == [1,1,0,1]
                    obj.process_threesig(1,2,4,c_position,c_state);

                elseif outer_sig == [1,0,1,1]
                    obj.process_threesig(1,3,4,c_position,c_state);
                
                elseif outer_sig == [0,1,1,1]
                    obj.process_threesig(2,3,4,c_position,c_state);

                % !!!Condition of outer FOUR floor call
                elseif outer_sig == [1,1,1,1]
                    hold_outer = [obj.hold_list(1),obj.hold_list(2),obj.hold_list(3),obj.hold_list(4)];
                    running = find(hold_outer ~= -1);
                    if length(running) == 1
                        obj.process_onesig(running(1),c_position,c_state);
                    elseif length(running) == 2
                        obj.process_twosig(running(1),running(2),c_position,c_state);
                    elseif length(running) == 3
                        obj.process_threesig(running(1),running(2),running(3),c_position,c_state);
                    end
                end
            end

            obj.update_all();
        end

        function delete_timer(obj)
            stop(obj.flush);
            delete(obj.flush);
        end

    end
end
