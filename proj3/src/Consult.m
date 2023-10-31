classdef Consult < handle

    properties (SetAccess = public)
        index
        lastArray
        array
        a
    end
    
    properties (SetAccess = private)
        database
        view
    end

    methods

        function obj = Consult(db, arr, view)
            obj.database = db;
            obj.array = arr;
            obj.view = view;
            obj.index = 0;
        end
        
        function obj = setIndex(obj, input)
            obj.index = input;
        end


        function outputArg = sorting(obj, way_sort, arr)
            count = 0;
            for m = 1:30
                if arr(m).departure_time == 0 && arr(m).arrival_time == 0
                    count = m - 1;
                    break;
                end
            end
            if strcmp(way_sort, '最少耗时')
                n = count;
                sortedArray = arr;
                for i = 1:n-1
                    for j = 1:n-1
                        if sortedArray(j).interval_time > sortedArray(j+1).interval_time
                            temp = sortedArray(j);
                            sortedArray(j) = sortedArray(j+1);
                            sortedArray(j+1) = temp;
                        end
                    end
                end
            end
            if strcmp(way_sort, '最早到时')
                n = count;
                sortedArray = arr;
                for i = 1:n-1
                    for j = 1:n-1
                        if sortedArray(j).arrival_time > sortedArray(j+1).arrival_time
                            temp = sortedArray(j);
                            sortedArray(j) = sortedArray(j+1);
                            sortedArray(j+1) = temp;
                        end
                    end
                end
            end
            if strcmp(way_sort, '最小价格')
                n = count;
                sortedArray = arr;
                for i = 1:n-1
                    for j = 1:n-1
                        if sortedArray(j).price > sortedArray(j+1).price
                            temp = sortedArray(j);
                            sortedArray(j) = sortedArray(j+1);
                            sortedArray(j+1) = temp;
                        end
                    end
                end
            end
            obj.array = sortedArray;
            obj.lastArray = sortedArray;
            outputArg = sortedArray;
        end

        function refreshArray(obj)
            myobj = ConsultResult();
            obj.array = repmat(myobj,[1,30]);
        end

        function outputArg = search(obj, now_time, dep_station,arrival_station, date)
           
            obj.refreshArray();
            result_cnt = 0;
            for i = 1:90
                cal_time = now_time;
                price = 0;
                if strcmp(obj.database.getData(i, 1), dep_station) && (obj.database.getData(i, 4) > cal_time)
                    iteri = i + 1;

                    while iteri <= 90
                        break_tag = 0;
                       
                        if obj.database.getData(i, 5)
                            price = price + 4;
                        else
                            price = price + 1;
                        end
                        if strcmp(obj.database.getData(iteri, 1), arrival_station)
                            
                            result_cnt  = result_cnt + 1;
                            obj.array(result_cnt).departure_time = obj.database.getData(i, 4);
                            obj.array(result_cnt).arrival_time = obj.database.getData(iteri, 3);
                            obj.array(result_cnt).departure_station = dep_station;
                            obj.array(result_cnt).arrival_station = arrival_station;
                            obj.array(result_cnt).interval_time =  obj.array(result_cnt).arrival_time - obj.array(result_cnt).departure_time;
                            obj.array(result_cnt).train_id1 = obj.database.getData(i, 2);
                            obj.array(result_cnt).train_id2 = obj.database.getData(i, 2);
                            obj.array(result_cnt).price = price;
                            obj.array(result_cnt).date = date;
                            break;
                        end

                        if obj.database.getData(iteri, 4) == -1
                            cal_time = obj.database.getData(iteri, 3);
                            save_price = price;
                            for j = 1:90
                                if strcmp(obj.database.getData(j, 1), obj.database.getData(iteri, 1)) && (obj.database.getData(j, 4) > cal_time)
                                    transfer_time = obj.database.getData(j, 4);
                                    iterj = j + 1;
                                    
                                    if obj.database.getData(iterj, 5)
                                        
                                        if strcmp(obj.database.getData(iterj, 1), dep_station)
                                            continue;
                                        end

                                        if strcmp(obj.database.getData(iterj, 1), arrival_station)
                                            result_cnt  = result_cnt + 1;
                                            obj.array(result_cnt).departure_time = obj.database.getData(i, 4);
                                            obj.array(result_cnt).arrival_time = obj.database.getData(iterj, 3);
                                            obj.array(result_cnt).departure_station = dep_station;
                                            obj.array(result_cnt).arrival_station = arrival_station;
                                            obj.array(result_cnt).interval_time =  obj.array(result_cnt).arrival_time - obj.array(result_cnt).departure_time;
                                            obj.array(result_cnt).train_id1 = obj.database.getData(i, 2);
                                            obj.array(result_cnt).train_id2 = obj.database.getData(j, 2);
                                            obj.array(result_cnt).whether_transfer = true;
                                            obj.array(result_cnt).transfer_station = obj.database.getData(iteri, 1);
                                            obj.array(result_cnt).price = price + 4;
                                            price = save_price;
                                            obj.array(result_cnt).date = date;
                                            obj.array(result_cnt).transfer_time = transfer_time;
                                            continue;
                                        end
                                    end
                                    
                                    while obj.database.getData(iterj, 4) ~= -1
                                        
                                        if obj.database.getData(j, 5)
                                            price = price + 4;
                                        else
                                            price = price + 1;
                                        end
                                     
                                        if strcmp(obj.database.getData(iterj, 1), dep_station)
                                            break;
                                        end

                                        if strcmp(obj.database.getData(iterj, 1), arrival_station)
                                            result_cnt  = result_cnt + 1;
                                            obj.array(result_cnt).departure_time = obj.database.getData(i, 4);
                                            obj.array(result_cnt).arrival_time = obj.database.getData(iterj, 3);
                                            obj.array(result_cnt).departure_station = dep_station;
                                            obj.array(result_cnt).arrival_station = arrival_station;
                                            obj.array(result_cnt).interval_time =  obj.array(result_cnt).arrival_time - obj.array(result_cnt).departure_time;
                                            obj.array(result_cnt).train_id1 = obj.database.getData(i, 2);
                                            obj.array(result_cnt).train_id2 = obj.database.getData(j, 2);
                                            obj.array(result_cnt).whether_transfer = true;
                                            obj.array(result_cnt).transfer_station = obj.database.getData(iteri, 1);
                                            obj.array(result_cnt).price = price;
                                            price = save_price;
                                            obj.array(result_cnt).date = date;
                                            obj.array(result_cnt).transfer_time = transfer_time;
                                            break;
                                        end
                                        
                                        iterj = iterj + 1; 
                                    end
                                    price = save_price;
                                end
                                if j == 90 
                                    break_tag = 1;
                                end
                            end
                        end
                   
                        if break_tag == 1
                            break;
                        end
                        iteri = iteri + 1; 
                    end
                end
            end
            obj.lastArray = obj.array;
            outputArg = obj.array;
        end
    end
end