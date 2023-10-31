classdef Account < handle
    
    properties (SetAccess = public)
        logInAccountId;
    end

    properties (SetAccess = private)
        ticket;
        database;
        clock;
    end

    methods
        function obj = Account(ticket, database)
            obj.ticket = ticket;
            obj.logInAccountId = -1;
            obj.database = database;
        end
        
        function setClock(obj, clock)
            obj.clock = clock;
        end 

        function obj = logout(obj)
            obj.logInAccountId = -1;
        end

        function obj = login(obj, accountId)
            obj.logInAccountId = accountId;
            tableRownum = obj.ticket.getTableRownum();
            findSuccess = 0;
            for i = 1:tableRownum
                if accountId == obj.ticket.getTableInfo(i, 1)
                    findSuccess = 1;
                    break;
                end
            end

            if findSuccess == 0
                obj.ticket.setTableInfo(tableRownum + 1, 1, accountId, 1);
            end
        end
        
        
        function outputArg = ticketLeft(obj, structIn, seat_quality)
            if structIn.price == 0
                outputArg = 0;
                return;
            end

            if structIn.departure_time == 0
                outputArg = 0;
                return;
            end

            if structIn.whether_transfer == 0
                for i = 1:90
                    if (strcmp(obj.database.getData(i, 1), structIn.departure_station) && obj.database.getData(i, 4) == structIn.departure_time)
                        outputArg = obj.ticket.getTicket(i, seat_quality);
                        iteri = i + 1;

                        while iteri <= 90
                            if strcmp(obj.database.getData(iteri, 1), structIn.arrival_station)
                                break;
                            end

                            if obj.ticket.getTicket(iteri, seat_quality) < outputArg
                                outputArg = obj.ticket.getTicket(iteri, seat_quality);
                            end
                            
                            iteri = iteri + 1;
                        end

                        return;
                    end
                end

            elseif structIn.whether_transfer == 1
                for i = 1:90
                    if (strcmp(obj.database.getData(i, 1), structIn.departure_station) && obj.database.getData(i, 4) == structIn.departure_time)
                        outputArg = obj.ticket.getTicket(i, seat_quality);
                        iteri = i + 1;

                        while iteri <= 90
                            if strcmp(obj.database.getData(iteri, 1), structIn.transfer_station)
                                break;
                            end

                            if obj.ticket.getTicket(iteri, seat_quality) < outputArg
                                outputArg = obj.ticket.getTicket(iteri, seat_quality);
                            end
                            
                            iteri = iteri + 1;
                        end

                        break;
                    end
                end

                for j = 1:90
                    if (strcmp(obj.database.getData(j, 1), structIn.transfer_station) && obj.database.getData(j, 4) == structIn.transfer_time && strcmp(obj.database.getData(j, 2), structIn.train_id2))
                        if obj.ticket.getTicket(j, seat_quality) < outputArg
                            outputArg = obj.ticket.getTicket(j, seat_quality);
                        end

                        iterj = j + 1;

                        while iterj <= 90
                            if strcmp(obj.database.getData(iterj, 1), structIn.arrival_station)
                                break;
                            end

                            if obj.ticket.getTicket(iterj, seat_quality) < outputArg
                                outputArg = obj.ticket.getTicket(iterj, seat_quality);
                            end

                            iterj = iterj + 1;

                        end

                        return;
                   end
               end
            end

        end
        


        function outputArg = tryBuyTicket(obj, structIn, seat_quality)
            if structIn.whether_transfer == 0
                for i = 1:90
                    if (strcmp(obj.database.getData(i, 1), structIn.departure_station) && obj.database.getData(i, 4) == structIn.departure_time)
                        obj.ticket.setTicket(i, seat_quality, obj.ticket.getTicket(i, seat_quality) - 1);
                        iteri = i + 1;

                        while iteri <= 90
                            if strcmp(obj.database.getData(iteri, 1), structIn.arrival_station)
                                break;
                            end

                            obj.ticket.setTicket(iteri, seat_quality, obj.ticket.getTicket(iteri, seat_quality) - 1);
                            
                            iteri = iteri + 1;
                        end
                        outputArg = 1;
                        return;
                    end
                end

            elseif structIn.whether_transfer == 1
                for i = 1:90
                    if (strcmp(obj.database.getData(i, 1), structIn.departure_station) && obj.database.getData(i, 4) == structIn.departure_time)
                        obj.ticket.setTicket(i, seat_quality, obj.ticket.getTicket(i, seat_quality) - 1);
                        iteri = i + 1;

                        while iteri <= 90
                            if strcmp(obj.database.getData(iteri, 1), structIn.transfer_station)
                                break;
                            end

                            obj.ticket.setTicket(iteri, seat_quality, obj.ticket.getTicket(iteri, seat_quality) - 1);
                            
                            iteri = iteri + 1;
                        end

                        break;
                    end
                end

                for j = 1:90
                    if (strcmp(obj.database.getData(j, 1), structIn.transfer_station) && obj.database.getData(j, 4) == structIn.transfer_time && strcmp(obj.database.getData(j, 2), structIn.train_id2))
                        obj.ticket.setTicket(j, seat_quality, obj.ticket.getTicket(j, seat_quality) - 1);

                        iterj = j + 1;

                        while iterj <= 90
                            if strcmp(obj.database.getData(iterj, 1), structIn.arrival_station)
                                break;
                            end

                            obj.ticket.setTicket(iterj, seat_quality, obj.ticket.getTicket(iterj, seat_quality) - 1);

                            iterj = iterj + 1;

                        end
                        outputArg = 1;
                        return;
                   end
                end
                
            end

        end

        function success = buyTicket(obj, structIn, seat_quality)
            if obj.logInAccountId == -1
                success = 0;
                return;
            end

            tableRownum = obj.ticket.getTableRownum();
            for i = 1:tableRownum
                if obj.logInAccountId == obj.ticket.getTableInfo(i, 1)

                    if obj.ticketLeft(structIn, seat_quality) < 1
                        success = 0;
                        msgbox('Error! No Enough Tickets!', 'error');
                        return;
                    end

                    if obj.ticket.getTableInfo(i, 2) == 1
                        success = 0;
                        msgbox('Error! Cannot Buy Two Tickets!', 'error');
                        return;
                    end
                    obj.tryBuyTicket(structIn, seat_quality);
                    obj.ticket.setTableInfo(i, 2, 1, 0);
                    obj.ticket.setTableInfo(i, 3, structIn.departure_time, 0);
                    obj.ticket.setTableInfo(i, 4, structIn.arrival_time, 0);
                    obj.ticket.setTableInfo(i, 5, structIn.interval_time, 0);
                    obj.ticket.setTableInfo(i, 6, {structIn.departure_station}, 0);
                    obj.ticket.setTableInfo(i, 7, {structIn.arrival_station}, 0);
                    obj.ticket.setTableInfo(i, 8, {structIn.train_id1}, 0);
                    obj.ticket.setTableInfo(i, 9, structIn.whether_transfer, 0);
                    obj.ticket.setTableInfo(i, 10, {structIn.transfer_station}, 0);
                    obj.ticket.setTableInfo(i, 11, structIn.price, 0);
                    obj.ticket.setTableInfo(i, 12, seat_quality, 0);
                    obj.ticket.setTableInfo(i, 13, structIn.transfer_time, 0);
                    obj.ticket.setTableInfo(i, 14, {structIn.train_id2}, 0);
                    success = 1;
                    return;
                end
            end
            success = 0;
        end
        

        function outputArg = consultTicket(obj, input)
            tableRownum = obj.ticket.getTableRownum();
             for i = 1:tableRownum
                if obj.logInAccountId == obj.ticket.getTableInfo(i, 1)
                    outputArg = obj.ticket.getTableInfo(i, input);
                end
             end
        end


        function success = tryCancelTicket(obj)
            if obj.logInAccountId == -1
                success = 0;
                return;
            end
            
            tableRownum = obj.ticket.getTableRownum();
            for i = 1:tableRownum
                if obj.logInAccountId == obj.ticket.getTableInfo(i, 1)
                    if obj.ticket.getTableInfo(i, 2) == 0
                        success = 0;
                        msgbox('No Ticket To Cancel!');
                        return;
                    end
                    whether_transfer = obj.ticket.getTableInfo(i, 9);
                    departure_station = obj.ticket.getTableInfo(i, 6);
                    departure_time = obj.ticket.getTableInfo(i, 3);
                    transfer_station = obj.ticket.getTableInfo(i, 10);
                    transfer_time = obj.ticket.getTableInfo(i, 13);
                    arrival_station = obj.ticket.getTableInfo(i, 7);
                    seat_quality = obj.ticket.getTableInfo(i, 12);
                    train_id2 = obj.ticket.getTableInfo(i, 14);
                end
            end

            if whether_transfer == 0 && obj.clock.save_time < departure_time
                for i = 1:90
                    if (strcmp(obj.database.getData(i, 1), departure_station) && obj.database.getData(i, 4) == departure_time)
                        obj.ticket.setTicket(i, seat_quality, obj.ticket.getTicket(i, seat_quality) + 1);
                        iteri = i + 1;

                        while iteri <= 90
                            if strcmp(obj.database.getData(iteri, 1), arrival_station{1})
                                break;
                            end

                            obj.ticket.setTicket(iteri, seat_quality, obj.ticket.getTicket(iteri, seat_quality) + 1);
                            
                            iteri = iteri + 1;
                        end
                        success = 1;
                        break;
                    end
                end

            elseif whether_transfer == 1 && obj.clock.save_time < departure_time
                for i = 1:90
                    if (strcmp(obj.database.getData(i, 1), departure_station) && obj.database.getData(i, 4) == departure_time)
                        obj.ticket.setTicket(i, seat_quality, obj.ticket.getTicket(i, seat_quality) + 1);
                        iteri = i + 1;

                        while iteri <= 90
                            if strcmp(obj.database.getData(iteri, 1), transfer_station{1})
                                break;
                            end
                       
                            obj.ticket.setTicket(iteri, seat_quality, obj.ticket.getTicket(iteri, seat_quality) + 1);
                            
                            iteri = iteri + 1;
                        end

                        break;
                    end
                end

                for j = 1:90
                    if (strcmp(obj.database.getData(j, 1), transfer_station{1}) && obj.database.getData(j, 4) == transfer_time  && strcmp(obj.database.getData(j, 2), train_id2{1}))
                        obj.ticket.setTicket(j, seat_quality, obj.ticket.getTicket(j, seat_quality) + 1);

                        iterj = j + 1;

                        while iterj <= 90
                            if strcmp(obj.database.getData(iterj, 1), arrival_station{1})
                                break;
                            end

                            obj.ticket.setTicket(iterj, seat_quality, obj.ticket.getTicket(iterj, seat_quality) + 1);

                            iterj = iterj + 1;

                        end

                        break;
                   end
               end
            end
            
            
            for i = 1:tableRownum
                if obj.logInAccountId == obj.ticket.getTableInfo(i, 1)
                    obj.ticket.setTableInfo(i, 1, 0, 0);
                    obj.ticket.setTableInfo(i, 2, 0, 0);
                    TableRownum = obj.ticket.getTableRownum();
                    obj.ticket.setTableInfo(TableRownum + 1, 1, obj.logInAccountId, 1);
                    success = 1;
                end
            end

        end

   
    end
end