classdef unitTest < matlab.unittest.TestCase

    methods(TestClassSetup)
        % Shared setup for the entire test class
    end
    
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

            timeSpeed = 0.1;
            tc.clock = Clock(tc.ui, timeSpeed, tc.ticket, tc.database, tc.account, 0);
            tc.account.setClock(tc.clock);

            tc.consult = Consult(tc.database, structArray, tc.ui);

            tc.ui.constructor(tc.database, tc.consult, tc.clock, tc.ticket, tc.account); 
        end
    end

    methods(Test)
        %Database.m
        %T1.1.1.1
        %database.getData()
        function test_1_1_1_1(tc)
            myans = tc.database.getData(1, 1);
            tc.verifyEqual(myans, {'苏州北'});
            close all force;
        end

        %T1.1.1.2
        %database.getData()
        function test_1_1_1_2(tc)
            myans = tc.database.getData(1, 2);
            tc.verifyEqual(myans, {'D11'});
            close all force;
        end

        %T1.1.1.3
        %database.getData()
        function test_1_1_1_3(tc)
            myans = tc.database.getData(1, 3);
            tc.verifyEqual(myans, -1);
            close all force;
        end

        %T1.1.1.4
        %database.getData()
        function test_1_1_1_4(tc)
            myans = tc.database.getData(1, 4);
            tc.verifyEqual(myans, 603);
            close all force;
        end

        %T1.1.1.5
        %database.getData()
        function test_1_1_1_5(tc)
            myans = tc.database.getData(1, 5);
            tc.verifyEqual(myans, 0);
            close all force;
        end

        %Ticket.m
        %T1.2.1.1
        %ticket.setTableInfo()
        function test_1_2_1_1(tc)
            tc.ticket.setTableInfo(1,1,1211,0);
            tc.verifyEqual(tc.ticket.getTableInfo(1,1), 1211);
            close all force;
        end
        
        %T1.2.1.2
        %ticket.setTableInfo()
        function test_1_2_1_2(tc)
            tc.ticket.setTableInfo(1,1,1212,1);
            tc.verifyEqual(tc.ticket.getTableInfo(1,1), 1212);
            close all force;
        end
        
        %T1.2.2.1
        %ticket.getTableInfo()
        function test_1_2_2_1(tc)
            tc.account.login(200);
            myans = tc.ticket.getTableInfo(1,2);
            tc.verifyEqual(myans, 0);
            close all force;
        end
        
        %T1.2.3.1
        %ticket.getTicket()
        function test_1_2_3_1(tc)
            myans = tc.ticket.getTicket(1,1);
            tc.verifyEqual(myans, 2);
            close all force;
        end

        %T1.2.4.1
        %ticket.setTicket()
        function test_1_2_4_1(tc)
            tc.ticket.setTicket(1,1,5);
            myans = tc.ticket.getTicket(1,1);
            tc.verifyEqual(myans, 5);
            tc.ticket.setTicket(1,1,2);
            close all force;
        end

        %T1.2.5.1
        %ticket.getTableRownum()
        function test_1_2_5_1(tc)
            tc.ticket.information = table;
            myans = tc.ticket.getTableRownum();
            tc.verifyEqual(myans, 0);
            close all force;
        end

        %T1.2.6.1
        %ticket.getTableColnum()
        function test_1_2_6_1(tc)
            tc.ticket.information = table;
            myans = tc.ticket.getTableColnum();
            tc.verifyEqual(myans, 0);
            close all force;
        end

        %T1.2.7.1
        %ticket.saveInfo()
        function test_1_2_7_1(tc)
            tc.ticket.setTableInfo(1,1,5,0);
            tc.ticket.setTicket(1,1,5);
            tc.ticket.saveInfo();
            read1 = readtable('account.csv');
            read2 = readtable('ticket.csv');
            myans1 = read1.(1)(1);
            myans2 = read2.(1)(1);
            tc.verifyEqual(myans1, 5);
            tc.verifyEqual(myans2, 5);
            tc.ticket.setTableInfo(1,1,0,0);
            tc.ticket.setTicket(1,1,2);
            tc.ticket.saveInfo();
            close all force;
        end

        %Consult.m
        %T1.3.1.1
        %consult.setIndex()
        function test_1_3_1_1(tc)
            tc.consult.setIndex(5);
            tc.verifyEqual(tc.consult.index, 5);
            close all force;
        end

        %T1.3.2.1
        %consult.sorting()
        function test_1_3_2_1(tc)
            myobj = ConsultResult();
            testArray = repmat(myobj,[1,30]);
            testArray(1).interval_time = 60;
            testArray(1).departure_time = 30;
            testArray(1).arrival_time = 90;
            testArray(2).interval_time = 30;
            testArray(2).departure_time = 30;
            testArray(2).arrival_time = 60;
            myans = tc.consult.sorting('最少耗时', testArray);
            tc.verifyEqual(myans(1).interval_time, 30);
            tc.verifyEqual(myans(2).interval_time, 60);
            close all force;
        end
        
        
        %T1.3.2.2
        %consult.sorting()
        function test_1_3_2_2(tc)
            myobj = ConsultResult();
            testArray = repmat(myobj,[1,30]);
            testArray(1).departure_time = 30;
            testArray(1).arrival_time = 90;
            testArray(2).departure_time = 30;
            testArray(2).arrival_time = 60;
            myans = tc.consult.sorting('最早到时', testArray);
            tc.verifyEqual(myans(1).arrival_time, 60);
            tc.verifyEqual(myans(2).arrival_time, 90);
            close all force;
        end
         
        
        %T1.3.2.3
        %consult.sorting()
        function test_1_3_2_3(tc)
            myobj = ConsultResult();
            testArray = repmat(myobj,[1,30]);
            testArray(1).price = 6;
            testArray(1).departure_time = 30;
            testArray(1).arrival_time = 90;
            testArray(2).price = 3;
            testArray(2).departure_time = 30;
            testArray(2).arrival_time = 60;
            myans = tc.consult.sorting('最小价格', testArray);
            tc.verifyEqual(myans(1).price, 3);
            tc.verifyEqual(myans(2).price, 6);
            close all force;
        end

        %T1.3.3.1
        %consult.refreshArray()
        function test_1_3_3_1(tc)
            myobj = ConsultResult();
            testArray = repmat(myobj,[1,30]);
            testArray(1).price = 6;
            tc.consult.array = testArray;
            tc.consult.refreshArray();
            tc.verifyEqual(tc.consult.array(1).price, 0);
            close all force;
        end

        %T1.3.4.1
        %consult.search()
        function test_1_3_4_1(tc)
            nowtime = 1;
            depart_station = '上海虹桥';
            arr_station = '南京南';
            ret = tc.consult.search(nowtime, depart_station, arr_station, datetime('today'));
            myans = tc.consult.sorting('最少耗时', ret);
            tc.verifyEqual(myans(1).train_id1{1}(1), 'G');
            myans = tc.consult.sorting('最小价格', ret);
            tc.verifyEqual(myans(1).train_id1{1}(1), 'D');
            close all force;
        end

        %T1.3.4.2
        %consult.search()
        function test_1_3_4_2(tc)
            nowtime = 1;
            depart_station = '上海虹桥';
            arr_station = '溧阳';
            d = datetime('today');
            ret = tc.consult.search(nowtime, depart_station, arr_station, d);
            myans = tc.consult.sorting('最少耗时', ret);
            tc.verifyEqual(myans(1).train_id1{1}(1), 'G');
            tc.verifyEqual(myans(1).whether_transfer, true);
            myans = tc.consult.sorting('最小价格', ret);
            tc.verifyEqual(myans(1).train_id1{1}(1), 'D');
            tc.verifyEqual(myans(1).whether_transfer, true);
            close all force;
        end

        %T1.3.4.3
        %consult.search()
        function test_1_3_4_3(tc)
            nowtime = 1;
            depart_station = '溧阳';
            arr_station = '上海虹桥';
            ret = tc.consult.search(nowtime, depart_station, arr_station, datetime('today'));
            myans = tc.consult.sorting('最少耗时', ret);
            for i = 1:30
                if strcmp(myans(i).train_id2{1}(1), 'G')
                    success = 1;
                    break;
                end
            end
            tc.verifyEqual(success, 1);
            close all force;
        end

        %Clock.m
        %updateTrainIdGraph() ,checkTicket() ,setTable(), timerFunction()
        %are in functional test because they are impossible to verifyequal.
        %T1.4.1.1
        %pauseClock()
        function test_1_4_1_1(tc)
            start(tc.clock.clk);
            tc.clock.pauseClock();
            tc.verifyEqual(tc.clock.running, 0);
            delete(tc.clock.clk);
            close all force;
        end

        %T1.4.1.2
        %pauseClock()
        function test_1_4_1_2(tc)
            tc.clock.running = 0;
            tc.clock.pauseClock();
            tc.verifyEqual(tc.clock.running, 0);
            delete(tc.clock.clk);
            close all force;
        end
        
        %T1.4.2.1
        %startClock()
        function test_1_4_2_1(tc)
            tc.clock.running = 0;
            tc.clock.startClock();
            tc.verifyEqual(tc.clock.running, 1);
            tc.clock.pauseClock();
            delete(tc.clock.clk);
            close all force;
        end

        %T1.4.2.2
        %startClock()
        function test_1_4_2_2(tc)
            start(tc.clock.clk);
            tc.clock.startClock();
            tc.verifyEqual(tc.clock.running, 1);
            tc.clock.pauseClock();
            delete(tc.clock.clk);
            close all force;
        end
        
        %Account.m
        %T1.5.1.1
        %setClock()
        function test_1_5_1_1(tc)
            a = timer;
            tc.account.setClock(a);
            tc.verifyEqual(tc.account.clock, a);
            close all force;
        end
        
        %T1.5.2.1
        %logout()
        function test_1_5_2_1(tc)
            tc.account.logout();
            tc.verifyEqual(tc.account.logInAccountId, -1);
            close all force;
        end
        
        %T1.5.3.1
        %login()
        function test_1_5_3_1(tc)
            tc.account.login(201);
            tc.verifyEqual(tc.account.logInAccountId, 201);
            close all force;
        end
        
        %T1.5.3.2
        %login()
        function test_1_5_3_2(tc)
            tc.account.login(201);
            tc.account.logout();
            tc.account.login(202);
            tc.account.logout();
            tc.account.login(201);
            tc.verifyEqual(tc.account.logInAccountId, 201);
            close all force;
        end

        %T1.5.4.1
        %ticketLeft()
        function test_1_5_4_1(tc)
            myobj = ConsultResult();
            myArray = repmat(myobj,[1,30]);
            myArray(1).price = 0;
            myArray(1).departure_time = 2;
            myans = tc.account.ticketLeft(myArray(1), 1);
            tc.verifyEqual(myans, 0);
            close all force;
        end

        %T1.5.4.2
        %ticketLeft()
        function test_1_5_4_2(tc)
            myobj = ConsultResult();
            myArray = repmat(myobj,[1,30]);
            myArray(1).price = 1;
            myArray(1).departure_time = 0;
            myans = tc.account.ticketLeft(myArray(1), 1);
            tc.verifyEqual(myans, 0);
            close all force;
        end 
        
        %T1.5.4.3
        %ticketLeft()
        function test_1_5_4_3(tc)
            myArray = tc.consult.search(0, '苏州北', '常州北', datetime('today'));
            myArray = tc.consult.sorting('最早到时', myArray);
            myans = tc.account.ticketLeft(myArray(1), 1);
            tc.verifyEqual(myans, tc.ticket.getTicket(1,1));
            close all force;
        end 
        
        %T1.5.4.4
        %ticketLeft()
        function test_1_5_4_4(tc)
            myArray = tc.consult.search(0, '苏州北', '南京南', datetime('today'));
            myArray = tc.consult.sorting('最早到时', myArray);
            myans = tc.account.ticketLeft(myArray(1), 1);
            tc.verifyEqual(myans, tc.ticket.getTicket(1,1));
            close all force;
        end 

        %T1.5.4.5
        %ticketLeft()
        function test_1_5_4_5(tc)
            myArray = tc.consult.search(0, '苏州北', '湖州', datetime('today'));
            myArray = tc.consult.sorting('最早到时', myArray);
            myans = tc.account.ticketLeft(myArray(1), 1);
            tc.verifyEqual(myans, tc.ticket.getTicket(1,1));
            tc.verifyEqual(myans, tc.ticket.getTicket(67,1));
            close all force;
        end 
        
        %T1.5.5.1
        %tryBuyTicket()
        function test_1_5_5_1(tc)
            tc.account.login(200);
            myArray = tc.consult.search(0, '苏州北', '常州北', datetime('today'));
            myArray = tc.consult.sorting('最早到时', myArray);
            myans = tc.account.tryBuyTicket(myArray(1), 1);
            tc.verifyEqual(myans, 1);
            close all force;
        end 
        
        %T1.5.5.2
        %tryBuyTicket()
        function test_1_5_5_2(tc)
            tc.account.login(200);
            myArray = tc.consult.search(0, '苏州北', '南京南', datetime('today'));
            myArray = tc.consult.sorting('最早到时', myArray);
            myans = tc.account.tryBuyTicket(myArray(1), 1);
            tc.verifyEqual(myans, 1);
            close all force;
        end 

        %T1.5.5.3
        %tryBuyTicket()
        function test_1_5_5_3(tc)
            tc.account.login(200);
            myArray = tc.consult.search(0, '苏州北', '湖州', datetime('today'));
            myArray = tc.consult.sorting('最早到时', myArray);
            myans = tc.account.tryBuyTicket(myArray(1), 1);
            tc.verifyEqual(myans, 1);
            close all force;
        end 
        
        %T1.5.6.1
        %buyTicket()
        function test_1_5_6_1(tc)
            tc.account.login(200);
            tc.account.logout();
            myArray = tc.consult.search(0, '苏州北', '湖州', datetime('today'));
            myArray = tc.consult.sorting('最早到时', myArray);
            myans = tc.account.buyTicket(myArray(1), 1);
            tc.verifyEqual(myans, 0);
            close all force;
        end 

        %T1.5.6.2
        %buyTicket()
        function test_1_5_6_2(tc)
            tc.account.login(200);
            myArray = tc.consult.search(0, '苏州北', '湖州', datetime('today'));
            myArray = tc.consult.sorting('最早到时', myArray);
            tc.account.buyTicket(myArray(1), 1);
            tc.account.buyTicket(myArray(1), 1);
            myans = tc.account.buyTicket(myArray(1), 1);
            tc.verifyEqual(myans, 0);
            close all force;
        end 

        %T1.5.6.3
        %buyTicket()
        function test_1_5_6_3(tc)
            tc.account.login(200);
            myArray = tc.consult.search(0, '苏州北', '湖州', datetime('today'));
            myArray = tc.consult.sorting('最早到时', myArray);
            tc.account.buyTicket(myArray(1), 1);
            tc.account.logout();
            tc.account.login(201);
            tc.account.buyTicket(myArray(1), 1);
            tc.account.logout();
            tc.account.login(202);
            myans = tc.account.buyTicket(myArray(1), 1);
            tc.verifyEqual(myans, 0);
            close all force;
        end 
        
        %T1.5.7.1
        %consultTicket()
        function test_1_5_7_1(tc)
            tc.account.login(200);
            myans = tc.account.consultTicket(1);
            tc.verifyEqual(myans, 200);
            close all force;
        end

        %T1.5.8.1
        %tryCancelTicket()
        function test_1_5_8_1(tc)
            tc.account.login(200);
            tc.account.logout();
            myans = tc.account.tryCancelTicket();
            tc.verifyEqual(myans, 0);
            close all force;
        end

        %T1.5.8.2
        %tryCancelTicket()
        function test_1_5_8_2(tc)
            tc.account.login(200);
            myans = tc.account.tryCancelTicket();
            tc.verifyEqual(myans, 0);
            close all force;
        end

        %T1.5.8.3
        %tryCancelTicket()
        function test_1_5_8_3(tc)
            tc.clock.save_time = 1;
            tc.account.login(200);
            myArray = tc.consult.search(0, '苏州北', '湖州', datetime('today'));
            myArray = tc.consult.sorting('最早到时', myArray);
            tc.account.buyTicket(myArray(1), 1);
            myans = tc.account.tryCancelTicket();
            tc.verifyEqual(myans, 1);
            close all force;
        end

        %T1.5.8.4
        %tryCancelTicket()
        function test_1_5_8_4(tc)
            tc.clock.save_time = 1;
            tc.account.login(200);
            myArray = tc.consult.search(0, '苏州北', '常州北', datetime('today'));
            myArray = tc.consult.sorting('最早到时', myArray);
            tc.account.buyTicket(myArray(1), 1);
            myans = tc.account.tryCancelTicket();
            tc.verifyEqual(myans, 1);
            close all force;
        end

        %T1.5.8.5
        %tryCancelTicket()
        function test_1_5_8_5(tc)
            tc.clock.save_time = 1;
            tc.account.login(200);
            myArray = tc.consult.search(0, '苏州北', '南京南', datetime('today'));
            myArray = tc.consult.sorting('最早到时', myArray);
            tc.account.buyTicket(myArray(1), 1);
            myans = tc.account.tryCancelTicket();
            tc.verifyEqual(myans, 1);
            close all force;
        end

        %UI
        %T1.6.1.1
        %convertSeatQuality()
        function test_1_6_1_1(tc)
            myans = tc.ui.convertSeatQuality('一等座');
            tc.verifyEqual(myans, 1);
            close all force;
        end

        %T1.6.1.2
        %convertSeatQuality()
        function test_1_6_1_2(tc)
            myans = tc.ui.convertSeatQuality('二等座');
            tc.verifyEqual(myans, 2);
            close all force;
        end
    end

end