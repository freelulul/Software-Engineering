classdef functionalTest_multi < matlab.uitest.TestCase

    properties
        ui
        database
        ticket
        account
        clock
        consult

        ui1
        account1
        consult1
        clock1
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

            tc.ui1 = view();
            tc.account1 = Account(tc.ticket, tc.database);
            tc.consult1 = Consult(tc.database, structArray, tc.ui);
            tc.clock1 = Clock(tc.ui1, timeSpeed, tc.ticket, tc.database, tc.account1, 1);
            tc.account1.setClock(tc.clock1);
            tc.ui1.constructor(tc.database, tc.consult1, tc.clock1, tc.ticket, tc.account1); 
        end 
    end

    methods(Test)
        % Test methods

        function multiTest(tc)
            
            pause(7);
            tc.press(tc.ui.frontPageMine);
            tc.press(tc.ui.login);
            tc.press(tc.ui.Button_12);
            tc.press(tc.ui.Button);
            tc.press(tc.ui.Buy_Button_1);
            tc.press(tc.ui.buyAssure);
            tc.press(tc.ui.successButton);

            pause(5);
            tc.press(tc.ui1.frontPageMine);
            tc.ui1.accountId.Value = 114515;
            tc.press(tc.ui1.login);
            tc.press(tc.ui1.Button_12);
            tc.press(tc.ui1.Button);
            pause(5);
            tc.press(tc.ui.frontPageMine);
            tc.press(tc.ui.logout);
            tc.ui.accountId.Value = 114516;
            tc.press(tc.ui.login);
            tc.press(tc.ui.Button_12);
            tc.press(tc.ui.Button);
            tc.press(tc.ui.Buy_Button_1);
            tc.press(tc.ui.buyAssure);
            tc.press(tc.ui.successButton);

            pause(5);
            tc.press(tc.ui1.Buy_Button_1);
            tc.press(tc.ui1.buyAssure);
            pause(5);
            
            tc.clock.time = 1430;
            tc.ui.EditField_3.Value = 100;
            pause(1);
            tc.press(tc.ui.setTimeSpeed);
            pause(1);
            
            tc.clock1.time = 1430;
            tc.ui1.EditField_3.Value = 100;
            pause(1);
            tc.press(tc.ui1.setTimeSpeed);
            pause(1);

            tc.clock.delete_timer();
            tc.clock1.delete_timer();
            tc.ticket.saveInfo();
            close all force;
        end
    end

end