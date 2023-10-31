classdef integration_test < matlab.uitest.TestCase

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
        % T2.1.1
        function dispatch_repeat_test2_1_1(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.second_Button_up);
            pause(0.2);
            tc.press(tc.view.third_Button);
            pause(0.2); 
            tc.press(tc.view.first_Button);
            pause(0.2);
            tc.press(tc.view.left_call_3);
            pause(0.2);
            tc.press(tc.view.left_call_1);
            pause(0.2);
            tc.press(tc.view.right_call_2);
            pause(0.2);
            tc.press(tc.view.right_call_3);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T2.1.2
        function dispatch_repeat_test2_1_2(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.left_open);
            pause(0.2);
            tc.press(tc.view.right_call_3);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T2.1.3
        function dispatch_repeat_test2_1_3(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.left_open);
            pause(0.2);
            tc.press(tc.view.right_call_3);
            pause(0.2);
            tc.press(tc.view.second_Button_up);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end

        % T2.2.1
        function inner_handle_priority2_2_1(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.left_open);
            pause(0.2);
            tc.press(tc.view.left_call_2);
            pause(0.2);
            tc.press(tc.view.left_call_3);
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
        % T2.2.2
        function inner_handle_priority2_2_2(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.left_call_1);
            pause(0.2);
            tc.press(tc.view.left_call_3);
            pause(0.2);
            tc.press(tc.view.second_Button_down);
            pause(0.2);
            tc.press(tc.view.second_Button_up);
            pause(0.2);
            tc.press(tc.view.right_call_3);
            pause(0.2);
            tc.press(tc.view.third_Button);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end

        % T2.3
        function lookup_move_2_3(tc)
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

        % T2.4.1
        function bonus_2_4_1(tc)
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
        % T2.4.2
        function bonus_2_4_2(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.second_Button_down);
            pause(0.2);
            tc.press(tc.view.third_Button);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T2.4.3
        function bonus_2_4_3(tc)
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
        % T2.4.4
        function bonus_2_4_4(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.left_call_2);
            pause(0.2);
            tc.press(tc.view.third_Button);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T2.4.5
        function bonus_2_4_5(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.left_call_3);
            pause(0.2);
            tc.press(tc.view.third_Button);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T2.4.6
        function bonus_2_4_6(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.right_call_2);
            pause(0.2);
            tc.press(tc.view.third_Button);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end
        % T2.4.7
        function bonus_2_4_7(tc)
            expect_ans = [0;0;0;0;0;0;0;0;0;0;0;0;0;0];
            start(tc.console);
            tc.press(tc.view.right_call_3);
            pause(0.2);
            tc.press(tc.view.third_Button);
            pause(0.2);

            while ~(all(tc.controller.sig_list(:) == 0))
                pause(0.2);
            end
            tc.verifyEqual(tc.controller.sig_list(:),expect_ans);
        end

    end
end