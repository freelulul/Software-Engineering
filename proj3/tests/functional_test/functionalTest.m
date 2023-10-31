classdef functionalTest < matlab.uitest.TestCase

    properties
        ui
        database
        ticket
        account
        clock
        consult
    end

    methods(TestMethodSetup)
        % Setup for each test
        function launchApp(tc)
            addpath("../../src/");
            tc.ui = view();
            tc.database = DataBase();
            tc.ticket = Ticket();
            tc.account = Account(tc.ticket, tc.database);

            myobj = ConsultResult();
            structArray = repmat(myobj,[1,30]);

            timeSpeed = 1;
            tc.clock = Clock(tc.ui, timeSpeed, tc.ticket, tc.database, tc.account, 1);
            tc.account.setClock(tc.clock);

            tc.consult = Consult(tc.database, structArray, tc.ui);

            tc.ui.constructor(tc.database, tc.consult, tc.clock, tc.ticket, tc.account); 
        end 
    end

    methods(Test)
        % Test methods

        function cancelTest(tc)
     
            tc.press(tc.ui.frontPageMine);
            tc.press(tc.ui.login);
            tc.press(tc.ui.MyTicket);
            tc.press(tc.ui.Button_12);
            tc.press(tc.ui.Button);
            tc.press(tc.ui.Buy_Button_1);
            tc.press(tc.ui.buyAssure);
            tc.press(tc.ui.successButton);
            for i = 1:90
                if tc.ticket.getTicket(i, 2) == 1
                    success = 0;
                    break;
                end
            end
            tc.verifyEqual(success, 0);
            tc.press(tc.ui.frontPageMine);
            tc.press(tc.ui.MyTicket);
            tc.press(tc.ui.tryCancelTicket);
            tc.press(tc.ui.cancelTicket);
            tc.press(tc.ui.successButton);

            for i = 1:90
                if tc.ticket.getTicket(i, 2) == 2
                    success = 1;
                end
            end
            tc.verifyEqual(success, 1);
            tc.clock.delete_timer();
            close all force;
        end

        function rescheduleTest(tc)
            tc.press(tc.ui.frontPageMine);
            tc.press(tc.ui.login);
            tc.press(tc.ui.MyTicket);
            tc.press(tc.ui.Button_12);
            tc.press(tc.ui.Button);
            tc.press(tc.ui.Buy_Button_1);
            tc.press(tc.ui.buyAssure);
            tc.press(tc.ui.successButton);
            for i = 1:90
                if tc.ticket.getTicket(i, 2) == 1
                    success = 0;
                    break;
                end
            end
            tc.verifyEqual(success, 0);
            tc.press(tc.ui.frontPageMine);
            tc.press(tc.ui.MyTicket);
            tc.press(tc.ui.RescheduleButton);
            tc.press(tc.ui.Button_re_search);
            tc.press(tc.ui.Buy_Button_6);
            tc.press(tc.ui.buyAssure_2);
            tc.press(tc.ui.successButton);
            for i = 1:90
                if tc.ticket.getTicket(i, 2) == 1
                    success = 1;
                    break;
                end
            end
            tc.verifyEqual(success, 1);
            tc.clock.delete_timer();
            close all force;
        end

        function clockTest(tc)
            tc.press(tc.ui.timeStop);
            tc.verifyEqual(tc.clock.running, 0);
            tc.press(tc.ui.timeContinue);
            tc.verifyEqual(tc.clock.running, 1);
            tc.clock.delete_timer();
            close all force;
        end

        function trainStateTest(tc)
            tc.ui.EditField_3.Value = 100;
            tc.press(tc.ui.setTimeSpeed);
            pause(20);
            tc.clock.delete_timer();
            close all force;
        end

        function passDayTest(tc)
            tc.press(tc.ui.frontPageMine);
            tc.press(tc.ui.login);
            tc.press(tc.ui.MyTicket);
            tc.press(tc.ui.Button_12);
            tc.press(tc.ui.Button);
            tc.press(tc.ui.Buy_Button_1);
            tc.press(tc.ui.buyAssure);
            tc.press(tc.ui.successButton);
            for i = 1:90
                if tc.ticket.getTicket(i, 2) == 1
                    success = 0;
                    break;
                end
            end
            tc.verifyEqual(success, 0);
            tc.ui.EditField_3.Value = 100;
            tc.press(tc.ui.setTimeSpeed);
            pause(30);
            success = 1;
            for i = 1:90
                if tc.ticket.getTicket(i, 2) == 1
                    success = 0;
                    break;
                end
            end
            tc.verifyEqual(success, 1);
            tc.clock.delete_timer();
            close all force;
        end

        function boardTest(tc)
            tc.press(tc.ui.frontPageMine);
            tc.press(tc.ui.login);
            tc.press(tc.ui.MyTicket);
            tc.press(tc.ui.Button_12);
            tc.press(tc.ui.Button);
            tc.press(tc.ui.Buy_Button_1);
            tc.press(tc.ui.buyAssure);
            tc.press(tc.ui.successButton);
            success = 0;
            for i = 1:90
                if tc.ticket.getTicket(i, 2) == 1
                    success = 0;
                    break;
                end
            end
            tc.verifyEqual(success, 0);
            tc.ui.EditField_3.Value = 100;
            tc.press(tc.ui.setTimeSpeed);
            pause(10);
            for i = 1:90
                if tc.ticket.getTicket(i, 2) == 1
                    success = 0;
                    break;
                end
            end
            tc.verifyEqual(success, 0);
            pause(20);
            tc.clock.delete_timer();
            tc.ticket.saveInfo();
            close all force;
        end

        function unboardTest(tc)
            tc.press(tc.ui.frontPageMine);
            tc.press(tc.ui.login);
            tc.press(tc.ui.MyTicket);
            tc.press(tc.ui.Button_12);
            tc.press(tc.ui.Button);
            tc.press(tc.ui.Buy_Button_1);
            tc.press(tc.ui.buyAssure);
            tc.press(tc.ui.successButton);
            for i = 1:90
                if tc.ticket.getTicket(i, 2) == 1
                    success = 0;
                    break;
                end
            end
            tc.verifyEqual(success, 0);
            tc.ui.boardButton.Value = 0;
            tc.ui.EditField_3.Value = 100;
            tc.press(tc.ui.setTimeSpeed);
            pause(20);
            success = 1;
            for i = 1:90
                if tc.ticket.getTicket(i, 2) == 1
                    success = 0;
                    break;
                end
            end
            tc.verifyEqual(success, 1);
            pause(10);
            tc.clock.delete_timer();
            tc.ticket.saveInfo();
            close all force;
        end
    end

end