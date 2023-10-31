classdef ConsultResult

    properties
        departure_time;
        arrival_time;
        interval_time;
        departure_station;
        arrival_station;
        train_id1;
        train_id2;
        whether_transfer;
        transfer_station;
        transfer_time;
        price;
        date;
    end

    methods
        function obj = ConsultResult()
            obj.departure_time = 0;
            obj.arrival_time = 0;
            obj.interval_time = 0;
            obj.transfer_time = 0;
            obj.price = 0;
            obj.whether_transfer = false;
            obj.transfer_station = '无';
            obj.train_id1 = '';
            obj.train_id2 = '';
            obj.date = datetime('today');
        end

    end
end