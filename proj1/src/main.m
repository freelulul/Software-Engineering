close all;
clear;

view = UI();

left_ele = elevator();
right_ele = elevator();

left_pan = inner_panel();
right_pan = inner_panel();
out_pan = outer_panel();

control = controler(view,left_ele,right_ele,left_pan,right_pan,out_pan);
% Timer1
console = timer("TimerFcn",@control.lookup);
console.Period = 0.05;
console.ExecutionMode = "fixedRate";
control.flush = console;
start(control.flush);

view.controler = control;