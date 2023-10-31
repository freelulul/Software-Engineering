classdef step < handle

    properties (SetAccess = private)
        steps = 0
        ui
    end

    methods

        % @constructor
        % @return {Self} self
        function self = step(front)
            self.steps = 0;
            self.ui = front;
        end

        % Increment the counter
        % @param {Self} self
        % @return {int} count - The current count
        function steps = increment(self)
            self.steps = self.steps + 1;
            steps = self.steps;
            self.ui.score_board.Text = num2str(self.steps);
            return;
        end

        % Decrement the counter
        % @param {Self} self
        % @return {int} count - The current count
        function steps = decrement(self)
            if self.steps > 0
                self.steps = self.steps - 1;
                steps = self.steps;
                self.ui.score_board.Text = num2str(self.steps);
            end
        end

        function steps = value(self)
            steps = self.steps;
        end

        function steps = set(self,value)
            self.steps = value;
            steps = self.steps;
            self.ui.score_board.Text = num2str(self.steps);
        end

        function data_record(self,level)
            filename = 'history.csv';
            data = readtable(filename);
            if self.steps < data{level+1,2}
                data{level+1,2} = self.steps;
                writetable(data,filename);
            end
        end
    end

end