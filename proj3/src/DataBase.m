classdef DataBase < handle

    properties (SetAccess = private)
        station;
        trainid;
        departure;
        arrival;
        trainstate;
    end

    methods
        function obj = DataBase()
            readIn = importdata("schedule.xlsx");
            obj.station = readIn.textdata(1:90);
            obj.trainid = readIn.textdata(91:180);
            obj.arrival = readIn.data(1:90);
            obj.departure = readIn.data(91:180);
            obj.trainstate = readIn.data(181:270);
        end

        function outputArg = getData(obj, row, coloumn)
            %Get Value DataBase[row][coloumn]
            %row1-station, row2-trainID, row3-departure time, row4-arrival time 
            if coloumn == 1
                outputArg = obj.station(row);
            elseif coloumn == 2
                outputArg = obj.trainid(row);
            elseif coloumn == 3
                outputArg = obj.arrival(row);
            elseif coloumn == 4
                outputArg = obj.departure(row);
            elseif coloumn == 5
                outputArg = obj.trainstate(row);
            end
        end
    end
end