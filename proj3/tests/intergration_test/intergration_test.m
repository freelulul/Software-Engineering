classdef intergration_test < matlab.uitest.TestCase

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

        function intergration(tc)
            pause(7);
            tc.press(tc.ui.frontPageMine);
            pause(3);
            tc.press(tc.ui.login);
            pause(3);
            tc.press(tc.ui.MyTicket);
            pause(2);
            tc.press(tc.ui.Button_13);
            pause(2);
            tc.press(tc.ui.Button_12);
            pause(3);
            tc.press(tc.ui.Button);
            pause(7);
            tc.press(tc.ui.Buy_Button_1);
            pause(19);
            tc.press(tc.ui.Button_15);
            pause(2);
            tc.press(tc.ui.Button);
            pause(7);
            tc.press(tc.ui.Buy_Button_1);
            pause(5);
            tc.press(tc.ui.buyAssure);
            pause(3);
            tc.press(tc.ui.successButton);

            pause(15);
            tc.press(tc.ui.frontPageMine);
            pause(2);
            tc.press(tc.ui.MyTicket);
            pause(6);
            tc.press(tc.ui.tryCancelTicket);
            pause(2);
            tc.press(tc.ui.cancelTicket);
            pause(2);
            tc.press(tc.ui.successButton);
            pause(1);
            %tc.press(tc.ui.Button_12);
            tc.press(tc.ui.Button);
            
            pause(7);
            tc.press(tc.ui.Buy_Button_1);
            pause(5);
            tc.press(tc.ui.buyAssure);
            pause(2);
            tc.press(tc.ui.successButton);


            pause(2);
            tc.press(tc.ui.frontPageMine);
            pause(2);
            tc.press(tc.ui.MyTicket);
            pause(2);
            tc.press(tc.ui.RescheduleButton);
            pause(3);
            tc.press(tc.ui.Button_re_search);
            pause(3);
            tc.press(tc.ui.Buy_Button_6);
            pause(2);
            tc.press(tc.ui.buyAssure_2);
            pause(2);
            tc.press(tc.ui.successButton);
            pause(2);
            tc.press(tc.ui.frontPageMine);
            pause(2);
            tc.press(tc.ui.MyTicket);
            pause(2);
            tc.press(tc.ui.ticketBackToMine);

            pause(2);
            tc.ui.EditField_3.Value = 100;
            pause(1);
            tc.press(tc.ui.setTimeSpeed);
            pause(3);
            tc.ui.EditField_3.Value = 10;
            pause(1);
            tc.press(tc.ui.setTimeSpeed);
            pause(30);
            tc.press(tc.ui.MyTicket);
            pause(1);
            tc.clock.time = 1430; 
            pause(1);
            tc.ui.EditField_3.Value = 1;
            pause(1);
            tc.press(tc.ui.setTimeSpeed);
            pause(1);
            tc.press(tc.ui.Button_13);
            pause(3);
            
            tc.press(tc.ui.Button_12);
            pause(2);
            tc.press(tc.ui.Button);
            pause(2);
            tc.press(tc.ui.Buy_Button_1);
            pause(2);
            tc.press(tc.ui.buyAssure);
            pause(2);
            tc.press(tc.ui.successButton);
            pause(2);
            tc.press(tc.ui.frontPageMine);
            pause(2);
            tc.press(tc.ui.MyTicket);
            pause(2);
            tc.ui.boardButton.Value = 0;
            pause(3);
            tc.press(tc.ui.ticketBackToMine);
            pause(2);
            tc.ui.EditField_3.Value = 100;
            pause(1);
            tc.press(tc.ui.setTimeSpeed);
            pause(8);
            tc.press(tc.ui.timeStop);
            pause(10);
            tc.press(tc.ui.MyTicket);
            pause(1);
            tc.press(tc.ui.tryCancelTicket);
            pause(2);
            tc.press(tc.ui.cancelTicket);
            pause(2);
            tc.press(tc.ui.successButton);
            pause(1);

            stop(tc.clock.clk);
            stop(tc.clock.clk_table);
            delete(tc.clock.clk);
            delete(tc.clock.clk_table);
            close all force;
        end
    end

end