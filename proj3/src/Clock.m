classdef Clock < handle
    %UNTITLED 此处提供此类的摘要
    %   此处提供详细说明

    properties (SetAccess = public)
        clk
        clk_table
        time
        save_time
        pay_left_time
        lock_assure_count
        ui
        ticket
        database
        account
        running
    end

    methods
        function obj = Clock(ui, timeSpeed, ticket, database, account, aux)
            obj.ui = ui;
            obj.ticket = ticket;
            obj.database = database;
            obj.account = account;
            obj.clk = timer;

            tmp = readtable('savetime.csv');
            obj.time = tmp.(1)(1);
            obj.ui.setTime(obj.time);

            obj.clk.TimerFcn = @(x,y)obj.timerFunction();
            obj.clk.ExecutionMode = 'fixedRate';
            obj.clk.Period = 1/timeSpeed;
            

            obj.clk_table = timer;
            obj.clk_table.TimerFcn = @(x,y)obj.setTable();
            obj.clk_table.ExecutionMode = 'fixedRate';
            obj.clk_table.Period = 3;
            if aux == 1
                start(obj.clk);
                start(obj.clk_table);
            end
            

            obj.running = 1;
            obj.lock_assure_count = 0;
        end
        
        function updateTrainIdGraph(obj)
            for i = 1:90
                if obj.database.getData(i, 3) <= obj.save_time && obj.database.getData(i, 3) ~= -1
                    if strcmp(obj.database.getData(i, 1), '南京南')
                        obj.ui.NanJingNanLabel.Text = obj.database.getData(i, 2);
                        if obj.database.getData(i, 3) == obj.save_time
                            if strcmp(obj.database.getData(i - 1, 1), '溧阳')
                                obj.ui.Li_Nan_Label.Text = ' ';
                            elseif strcmp(obj.database.getData(i - 1, 1), '常州北')
                                obj.ui.Chang_Nan_Label.Text = ' ';
                            end
                        end
                    elseif strcmp(obj.database.getData(i, 1), '杭州东')
                        obj.ui.HangZhouDongLabel.Text = obj.database.getData(i, 2);
                        if obj.database.getData(i, 3) == obj.save_time
                            if strcmp(obj.database.getData(i - 1, 1), '嘉兴南')
                                obj.ui.Jia_Hang_Label.Text = ' ';
                            elseif strcmp(obj.database.getData(i - 1, 1), '湖州')
                                obj.ui.Hu_Hang_Label.Text = ' ';
                            end
                        end
                    end
                end

                if obj.database.getData(i, 3) <= obj.save_time && obj.save_time < obj.database.getData(i, 4) && obj.database.getData(i, 3) ~= -1
                    if strcmp(obj.database.getData(i, 1), '常州北')
                        obj.ui.ChangZhouBeiLabel.Text = obj.database.getData(i, 2);
                        if obj.database.getData(i, 3) == obj.save_time
                            if strcmp(obj.database.getData(i - 1, 1), '南京南')
                                obj.ui.Nan_Chang_Label.Text = ' ';
                            elseif strcmp(obj.database.getData(i - 1, 1), '苏州北')
                                obj.ui.Su_Chang_Label.Text = ' ';
                            end
                        end
                    elseif strcmp(obj.database.getData(i, 1), '苏州北')
                        obj.ui.SuZhouBeiLabel.Text = obj.database.getData(i, 2);
                        if obj.database.getData(i, 3) == obj.save_time
                            if strcmp(obj.database.getData(i - 1, 1), '上海虹桥')
                                obj.ui.Shang_Su_Label.Text = ' ';
                            elseif strcmp(obj.database.getData(i - 1, 1), '常州北')
                                obj.ui.Chang_Su_Label.Text = ' ';
                            end
                        end
                    elseif strcmp(obj.database.getData(i, 1), '上海虹桥')
                        obj.ui.ShangHaiLabel.Text = obj.database.getData(i, 2);
                        if obj.database.getData(i, 3) == obj.save_time
                            if strcmp(obj.database.getData(i - 1, 1), '苏州北')
                                obj.ui.Su_Shang_Label.Text = ' ';
                            elseif strcmp(obj.database.getData(i - 1, 1), '嘉兴南')
                                obj.ui.Jia_Shang_Label.Text = ' ';
                            end
                        end
                    elseif strcmp(obj.database.getData(i, 1), '嘉兴南')
                        obj.ui.JiaXingNanLabel.Text = obj.database.getData(i, 2);
                        if obj.database.getData(i, 3) == obj.save_time
                            if strcmp(obj.database.getData(i - 1, 1), '上海虹桥')
                                obj.ui.Shang_Jia_Label.Text = ' ';
                            elseif strcmp(obj.database.getData(i - 1, 1), '杭州东')
                                obj.ui.Hang_Jia_Label.Text = ' ';
                            end
                        end
                    
                    elseif strcmp(obj.database.getData(i, 1), '湖州')
                        obj.ui.HuZhouLabel.Text = obj.database.getData(i, 2);
                        if obj.database.getData(i, 3) == obj.save_time
                            if strcmp(obj.database.getData(i - 1, 1), '杭州东')
                                obj.ui.Hang_Hu_Label.Text = ' ';
                            elseif strcmp(obj.database.getData(i - 1, 1), '溧阳')
                                obj.ui.Li_Hu_Label.Text = ' ';
                            end
                        end
                    elseif strcmp(obj.database.getData(i, 1), '溧阳')
                        obj.ui.LiYangLabel.Text = obj.database.getData(i, 2);
                        if obj.database.getData(i, 3) == obj.save_time
                            if strcmp(obj.database.getData(i - 1, 1), '南京南')
                                obj.ui.Nan_Li_Label.Text = ' ';
                            elseif strcmp(obj.database.getData(i - 1, 1), '湖州')
                                obj.ui.Hu_Li_Label.Text = ' ';
                            end
                        end
                    end
                end

                if obj.database.getData(i, 4) <= obj.save_time && obj.database.getData(i, 4) ~= -1
                    if obj.save_time < obj.database.getData(i + 1, 3)
                        if strcmp(obj.database.getData(i, 1), '南京南')
                            if obj.database.getData(i, 4) == obj.save_time
                                obj.ui.NanJingNanLabel.Text = ' ';
                            end

                            if strcmp(obj.database.getData(i + 1, 1), '溧阳')
                                obj.ui.Nan_Li_Label.Text = obj.database.getData(i, 2);
                            elseif strcmp(obj.database.getData(i + 1, 1), '常州北')
                                obj.ui.Nan_Chang_Label.Text = obj.database.getData(i, 2);
                            end
                        end

                        if strcmp(obj.database.getData(i, 1), '常州北')
                            if obj.database.getData(i, 4) == obj.save_time
                                obj.ui.ChangZhouBeiLabel.Text = ' ';
                            end
                            
                            if strcmp(obj.database.getData(i + 1, 1), '南京南')
                                obj.ui.Chang_Nan_Label.Text = obj.database.getData(i, 2);
                            elseif strcmp(obj.database.getData(i + 1, 1), '苏州北')
                                obj.ui.Chang_Su_Label.Text = obj.database.getData(i, 2);
                            end
                        end

                        if strcmp(obj.database.getData(i, 1), '苏州北')
                            if obj.database.getData(i, 4) == obj.save_time
                                obj.ui.SuZhouBeiLabel.Text = ' ';
                            end
                            
                            if strcmp(obj.database.getData(i + 1, 1), '上海虹桥')
                                obj.ui.Su_Shang_Label.Text = obj.database.getData(i, 2);
                            elseif strcmp(obj.database.getData(i + 1, 1), '常州北')
                                obj.ui.Su_Chang_Label.Text = obj.database.getData(i, 2);
                            end
                        end

                        if strcmp(obj.database.getData(i, 1), '上海虹桥')
                            if obj.database.getData(i, 4) == obj.save_time
                                obj.ui.ShangHaiLabel.Text = ' ';
                            end
                            
                            if strcmp(obj.database.getData(i + 1, 1), '苏州北')
                                obj.ui.Shang_Su_Label.Text = obj.database.getData(i, 2);
                            elseif strcmp(obj.database.getData(i + 1, 1), '嘉兴南')
                                obj.ui.Shang_Jia_Label.Text = obj.database.getData(i, 2);
                            end
                        end

                        if strcmp(obj.database.getData(i, 1), '嘉兴南')
                            if obj.database.getData(i, 4) == obj.save_time
                                obj.ui.JiaXingNanLabel.Text = ' ';
                            end
                            
                            if strcmp(obj.database.getData(i + 1, 1), '上海虹桥')
                                obj.ui.Jia_Shang_Label.Text = obj.database.getData(i, 2);
                            elseif strcmp(obj.database.getData(i + 1, 1), '杭州东')
                                obj.ui.Jia_Hang_Label.Text = obj.database.getData(i, 2);
                            end
                        end

                        if strcmp(obj.database.getData(i, 1), '杭州东')
                            if obj.database.getData(i, 4) == obj.save_time
                                obj.ui.HangZhouDongLabel.Text = ' ';
                            end
                            
                            if strcmp(obj.database.getData(i + 1, 1), '湖州')
                                obj.ui.Hang_Hu_Label.Text = obj.database.getData(i, 2);
                            elseif strcmp(obj.database.getData(i + 1, 1), '嘉兴南')
                                obj.ui.Hang_Jia_Label.Text = obj.database.getData(i, 2);
                            end
                        end

                        if strcmp(obj.database.getData(i, 1), '湖州')
                            if obj.database.getData(i, 4) == obj.save_time
                                obj.ui.HuZhouLabel.Text = ' ';
                            end
                            
                            if strcmp(obj.database.getData(i + 1, 1), '溧阳')
                                obj.ui.Hu_Li_Label.Text = obj.database.getData(i, 2);
                            elseif strcmp(obj.database.getData(i + 1, 1), '杭州东')
                                obj.ui.Hu_Hang_Label.Text = obj.database.getData(i, 2);
                            end
                        end

                        if strcmp(obj.database.getData(i, 1), '溧阳')
                            if obj.database.getData(i, 4) == obj.save_time
                                obj.ui.LiYangLabel.Text = ' ';
                            end
                            
                            if strcmp(obj.database.getData(i + 1, 1), '南京南')
                                obj.ui.Li_Nan_Label.Text = obj.database.getData(i, 2);
                            elseif strcmp(obj.database.getData(i + 1, 1), '湖州')
                                obj.ui.Li_Hu_Label.Text = obj.database.getData(i, 2);
                            end
                        end
                    end
                end
            end
        end
        
        function checkTicket(obj)
            row_num = obj.ticket.getTableRownum();
            for t = 1:row_num
                if obj.ticket.getTableInfo(t, 1) > 0
                    if obj.save_time == obj.ticket.getTableInfo(t, 3)
                        if obj.ui.boardButton.Value == 1
                            obj.ticket.setTableInfo(t, 1, 0, 0);
                            obj.ticket.setTableInfo(t, 2, 0, 0);
                            TableRownum = obj.ticket.getTableRownum();
                            obj.ticket.setTableInfo(TableRownum + 1, 1, obj.account.logInAccountId, 1);
                        elseif obj.ui.boardButton.Value == 0
                            if obj.ticket.getTableInfo(t, 2) == 0
                                return;
                            end
                            whether_transfer = obj.ticket.getTableInfo(t, 9);
                            departure_station = obj.ticket.getTableInfo(t, 6);
                            departure_time = obj.ticket.getTableInfo(t, 3);
                            transfer_station = obj.ticket.getTableInfo(t, 10);
                            transfer_time = obj.ticket.getTableInfo(t, 13);
                            arrival_station = obj.ticket.getTableInfo(t, 7);
                            seat_quality = obj.ticket.getTableInfo(t, 12);

                            if whether_transfer == 0
                                for i = 1:90
                                    if (strcmp(obj.database.getData(i, 1), departure_station) && obj.database.getData(i, 4) == departure_time)
                                        obj.ticket.setTicket(i, seat_quality, obj.ticket.getTicket(i, seat_quality) + 1);
                                        iteri = i + 1;

                                        while iteri <= 90
                                            if strcmp(obj.database.getData(iteri, 1), arrival_station)
                                                break;
                                            end

                                            obj.ticket.setTicket(iteri, seat_quality, obj.ticket.getTicket(iteri, seat_quality) + 1);
                            
                                            iteri = iteri + 1;
                                        end
                                        break;
                                    end
                                end

                            elseif whether_transfer == 1
                                for i = 1:90
                                    if (strcmp(obj.database.getData(i, 1), departure_station) && obj.database.getData(i, 4) == departure_time)
                                        obj.ticket.setTicket(i, seat_quality, obj.ticket.getTicket(i, seat_quality) + 1);
                                        iteri = i + 1;

                                        while iteri <= 90
                                            if strcmp(obj.database.getData(iteri, 1), transfer_station)
                                                break;
                                            end

                                            obj.ticket.setTicket(iteri, seat_quality, obj.ticket.getTicket(iteri, seat_quality) + 1);
                            
                                            iteri = iteri + 1;
                                        end

                                        break;
                                    end
                                end

                                for j = 1:90
                                    if (strcmp(obj.database.getData(j, 1), transfer_station) && obj.database.getData(j, 4) == transfer_time)
                                        obj.ticket.setTicket(j, seat_quality, obj.ticket.getTicket(j, seat_quality) + 1);

                                        iterj = j + 1;

                                        while iterj <= 90
                                            if strcmp(obj.database.getData(iterj, 1), arrival_station)
                                                break;
                                            end

                                            obj.ticket.setTicket(iterj, seat_quality, obj.ticket.getTicket(iterj, seat_quality) + 1);

                                            iterj = iterj + 1;

                                        end

                                        break;
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        function setTable(obj)
            obj.ticket.saveInfo();
            a = readtable("ticket.csv");
            b = readtable("schedule.xlsx");
            vars = {'Var1', 'Var2'};
            b = b(1:90, vars);
            t = [b, a];
            obj.ui.UITable.Data = t;

        end

        function timerFunction(obj)
            %cTime = obj.ui.getTime();
            cTime = obj.time;
            cTime = cTime + 1;
            obj.save_time = cTime;
            if cTime >= 1440
                cTime = cTime - 1440;
                obj.ui.dateAdd();
                tmp = table;
                if obj.account.logInAccountId > 0
                    initRow = table([0],[0],[0],[0],[0],{'无'},{'无'},{'C1'},[0],{'无'},[0],[0],[0],{'C1'});
                    tmp = [tmp; initRow];
                    tmp.(1)(1) = obj.account.logInAccountId;
                end
                obj.ticket.information = tmp;
                writetable(tmp, 'account.csv');
                
                f = readtable('ticket_save.csv');
                obj.ticket.ticket = f;
                writetable(f, 'ticket.csv');
                
            end
            obj.checkTicket();
            obj.time = cTime;
            obj.ui.setTime(cTime);
            if obj.pay_left_time > 0
                obj.pay_left_time = obj.pay_left_time - 1;
                obj.ui.payTimeLeft.Text = num2str(obj.pay_left_time);
            end
            obj.updateTrainIdGraph();
            if obj.pay_left_time == 0
                if obj.lock_assure_count == 0
                    obj.lock_assure_count = 1;
                    return;
                end
                obj.lock_assure_count = 0;
                obj.ui.payTimeLeft.Text = num2str(0);
                obj.ui.LeapTimePanel.Visible = true;
            end
            
        end

        function delete_timer(obj)
            obj.pauseClock();
            delete(obj.clk);
            stop(obj.clk_table);
            delete(obj.clk_table);
        end
        
        function setSpeed(obj, timespeed)
            obj.pauseClock();
            obj.clk.Period = 1 / timespeed;
            obj.startClock();
        end

        function pauseClock(obj)
            if obj.running == 1
                stop(obj.clk);
                obj.running = 0;
            end
        end

        function startClock(obj)
            if obj.running == 0
                start(obj.clk);
                obj.running = 1;
            end
        end
    end
end