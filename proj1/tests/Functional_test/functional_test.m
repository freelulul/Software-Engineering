classdef functional_test < matlab.uitest.TestCase

    properties
        view
        console
        left_ele
        right_ele
        left_panel
        right_panel
        out_panel
        controller
    end

    methods
        function call_back(tc,~,~)
            tc.controller.lookup();
        end

        function closeAPP(tc)
            delete(tc.view);
            stop(tc.console);
            delete(tc.console);
            close all force;
        end
    end

    methods(TestMethodSetup)
        function launchApp(tc)
            addpath("../../src");
            tc.view = UI();
            tc.left_ele = elevator();
            tc.right_ele = elevator();
            tc.left_panel = inner_panel();
            tc.right_panel = inner_panel();
            tc.out_panel = outer_panel();
            tc.controller = controler(tc.view,tc.left_ele,tc.right_ele,tc.left_panel,tc.right_panel,tc.out_panel);
            tc.view.controler = tc.controller;
            % Timer
            tc.console = timer("TimerFcn",@tc.call_back);
            tc.console.Period = 0.05;
            tc.console.ExecutionMode = "fixedRate";

            tc.addTeardown(@tc.closeAPP);
        end
    end

    methods(Test)
        % T3.1.1
        function request_direction3_1_1(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.first_Button);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T3.1.2
        function request_direction3_1_2(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.second_Button_down);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T3.1.3
        function request_direction3_1_3(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.second_Button_up);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T3.1.4
        function request_direction3_1_4(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.third_Button);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T3.1.5
        function request_direction3_1_5(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.first_Button);
            pause(0.2);
            tc.press(tc.view.second_Button_down);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T3.1.6
        function request_direction3_1_6(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.first_Button);
            pause(0.2);
            tc.press(tc.view.second_Button_up);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T3.1.7
        function request_direction3_1_7(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.first_Button);
            pause(0.2);
            tc.press(tc.view.third_Button);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T3.1.8
        function request_direction3_1_8(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.second_Button_up);
            pause(0.2);
            tc.press(tc.view.second_Button_down);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T3.1.9
        function request_direction3_1_9(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.third_Button);
            pause(0.2);
            tc.press(tc.view.second_Button_down);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T3.1.10
        function request_direction3_1_10(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.second_Button_up);
            pause(0.2);
            tc.press(tc.view.third_Button);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T3.1.11
        function request_direction3_1_11(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.first_Button);
            pause(0.2);
            tc.press(tc.view.second_Button_up);
            pause(0.2);
            tc.press(tc.view.second_Button_down);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T3.1.12
        function request_direction3_1_12(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.first_Button);
            pause(0.2);
            tc.press(tc.view.third_Button);
            pause(0.2);
            tc.press(tc.view.second_Button_down);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T3.1.13
        function request_direction3_1_13(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.first_Button);
            pause(0.2);
            tc.press(tc.view.second_Button_up);
            pause(0.2);
            tc.press(tc.view.third_Button);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T3.1.14
        function request_direction3_1_14(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.third_Button);
            pause(0.2);
            tc.press(tc.view.second_Button_up);
            pause(0.2);
            tc.press(tc.view.second_Button_down);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T3.1.15
        function request_direction3_1_15(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.first_Button);
            pause(0.2);
            tc.press(tc.view.second_Button_up);
            pause(0.2);
            tc.press(tc.view.second_Button_down);
            pause(0.2);
            tc.press(tc.view.third_Button);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        
        % T3.2.1
        function request_target3_2_1(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.left_call_1);
            pause(0.2);
            tc.press(tc.view.right_call_1);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T3.2.2
        function request_target3_2_2(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.left_call_2);
            pause(0.2);
            tc.press(tc.view.right_call_2);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T3.2.3
        function request_target3_2_3(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.left_call_3);
            pause(0.2);
            tc.press(tc.view.right_call_3);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T3.2.4
        function request_target3_2_4(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.left_call_1);
            pause(0.2);
            tc.press(tc.view.right_call_1);
            pause(0.2);
            tc.press(tc.view.left_call_2);
            pause(0.2);
            tc.press(tc.view.right_call_2);
            pause(0.2);
            tc.press(tc.view.left_call_3);
            pause(0.2);
            tc.press(tc.view.right_call_3);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T3.2.5
        function request_target3_2_5(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.left_call_1);
            pause(0.2);
            tc.press(tc.view.second_Button_down);
            pause(0.2);
            tc.press(tc.view.second_Button_up);
            pause(0.2);
            tc.press(tc.view.right_call_1);
            pause(0.2);
            tc.press(tc.view.right_call_3);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end

        % T3.3.1
        function open_f3_3_1(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.left_open);
            pause(0.2);
            tc.press(tc.view.right_open);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end

        % T3.4.1
        function open_closef3_4_1(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.left_open);
            pause(0.2);
            tc.press(tc.view.right_open);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                if tc.controller.left_ele.current_state == 5
                    tc.press(tc.view.left_close);
                end
                if tc.controller.right_ele.current_state == 5
                    tc.press(tc.view.right_close);
                end
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end

        % T3.5.1
        function cancel3_5_1(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.left_call_1);
            pause(0.2);
            tc.press(tc.view.left_call_2);
            pause(0.2);
            tc.press(tc.view.left_call_3);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                if tc.controller.left_ele.current_state == 5
                    tc.press(tc.view.left_call_3);
                    pause(0.1);
                    tc.press(tc.view.left_call_3);
                    pause(2);
                    tc.press(tc.view.left_call_2);
                    pause(0.1);
                    tc.press(tc.view.left_call_2);
                end
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T3.5.2
        function cancel3_5_2(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.third_Button);
            pause(0.2);
            tc.press(tc.view.left_call_2);
            pause(0.2);
            tc.press(tc.view.left_call_1);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                if tc.controller.left_ele.current_state == 5 && tc.controller.left_ele.current_floor == 2
                    tc.press(tc.view.left_call_1);
                    pause(0.1);
                    tc.press(tc.view.left_call_1);
                    pause(2);
                    break;
                end
                pause(0.2);
            end
            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end

    end
end