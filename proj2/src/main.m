% Entrypoint for your project.

% Below is an example application created by teaching staff. You can use it as
% a reference and remove it when you start your own project.

% Initialize the UI and the controller.
%ui = view();
%controller = counter();
%ui.constructor(counter);

% * YOUR CODE HERE *
ui = app_menu();
board = chessboard();
matrix = [3 1 1 4 ; 3 1 1 4;5 2 2 6;5 8 9 6;7 0 0 10];
board.init_board(matrix)
ui.init(board)