close all;
clear all; %#ok<CLALL> 
ui = view();
database = DataBase();
ticket = Ticket();
account = Account(ticket, database);
myobj = ConsultResult();
structArray = repmat(myobj,[1,30]);

timeSpeed = 1;
clock = Clock(ui, timeSpeed, ticket, database, account, 1);
account.setClock(clock);

consult = Consult(database, structArray, ui);

ui.constructor(database, consult, clock, ticket, account); 

ui1 = view();
account1 = Account(ticket, database);
consult1 = Consult(database, structArray, ui);
clock1 = Clock(ui1, timeSpeed, ticket, database, account1, 1);
account1.setClock(clock1);
ui1.constructor(database, consult1, clock1, ticket, account1); 