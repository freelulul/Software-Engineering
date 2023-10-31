classdef Ticket < handle

    properties (SetAccess = public)
        information;
        ticket;
    end
    
    %The 1 col is user id.
    %The 2 col is whether have ticket.
    %The 3 col is departure_time;
    %The 4 col is arrival_time;
    %The 5 col is interval_time;
    %The 6 col is departure_station;
    %The 7 col is arrival_station;
    %The 8 col is train_id1;
    %The 9 col is whether_transfer;
    %The 10 col is transfer_station;
    %The 11 col is price;
    %The 12 col is seat quality;
    %The 13 col is transfer_time;
    methods
        function obj = Ticket()
            obj.information = readtable("account.csv");
            obj.ticket = readtable("ticket.csv");
        end
        
        %aux is to control whether to initialize a new line in table.
        function setTableInfo(obj, row, col, val, aux)
            if aux == 1
                initRow = table([0],[0],[0],[0],[0],{'无'},{'无'},{'C1'},[0],{'无'},[0],[0],[0],{'C1'});
                obj.information = [obj.information; initRow];
            end
 
            obj.information.(col)(row) = val;
        end
        
        function setTicket(obj, row, col, val)
            obj.ticket.(col)(row) = val;
        end

        function outputArg = getTicket(obj, row, col)
            outputArg = obj.ticket.(col)(row);
        end

        function outputArg = getTableInfo(obj, row, col)
            outputArg = obj.information.(col)(row);
        end

        function outputArg = getTableRownum(obj)
            outputArg = size(obj.information, 1);
        end

        function outputArg = getTableColnum(obj)
            outputArg = size(obj.information, 2);
        end
        
        
        %Should be invoked when app are closed.
        function saveInfo(obj)
            writetable(obj.information, 'account.csv');
            writetable(obj.ticket, 'ticket.csv');
        end
    end
end