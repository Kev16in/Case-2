%% This file contains copied code from base_sir_fit 
%%% Although it has copied code, the inputs are different to accomidate for
%%% new state varibles that we eventually add to our model 

%%% The files that are called in this file are siroutput_part3_before.m,
%%% siroutput_part3_after.m, and siroutput_full_part3_after.m

%% Before Vaccinations
mockData = cat(2, newInfections', cumulativeDeaths');
mockData_before_vaccine=mockData(1:100,:);
mockData_after_vaccine=mockData(100:365,:);
t = 100;

%%% The line of code above represents the base phase of the simulation
%%% before vaccines were introduced into the population

sirafun= @(x)siroutput_part3_before(x,t,mockData_before_vaccine);

A = [0,1,1,0,0,0,0];
b = 1;

% Had these parameter to keep the fatality and recovered constants to not
% be greater than 1

Af = [0,0,0,1,1,1,1];
bf = 1;

% Made sure parameters always added up to 1

ub = [1,1,1,1,1,1,1]';
lb = [0,0,0,0,0,0,0]';

% Set bounds so that no fraction ever exeeds 1 or falls below 0

x0Mock_before = [0.2,0.3,0.1,1,0,0,0]; 


xMock_before = fmincon(sirafun,x0Mock_before,A,b,Af,bf,lb,ub);

Y_fitMock_before = siroutput_full(xMock_before,t);

% This is the outcome of the 1st phase of the simulation

%% After Vaccinations
t = 266;
sirafun= @(x)siroutput_part3_after(x,t,mockData_after_vaccine,[Y_fitMock_before(100,:),0,0]);

% Had around the same bounds as before but we made sure to have the recover
% and fatality added to not exeed 1 or not have infected and vaccinated
% together not go past 1 now.

A = [0,1,1,0,0;
     1,0,0,1,0];
b = [1,1];


Af = [];
bf = [];



ub = [1,1,1,1,1]';
lb = [0,0,0,0,0]';
x0Mock_after = [xMock_before(1:3),0.1,0]; 

% Here we only give it 5 x inputs which will changes the constants of the
% model and not mess with the initial parameters since it kept drastically
% changing them. 


xMock_after = fmincon(sirafun,x0Mock_after,A,b,Af,bf,lb,ub);

Y_fitMock_after = siroutput_full_part3_after(xMock_after,t,[Y_fitMock_before(100,:),0,0]);

%% Combined Data

% Now the data get combined and placed into one graph to see how it works
% as a whole system

Y_fitMock_before=cat(2,Y_fitMock_before,zeros(100,2));
Y_fitMock_combined=cat(1,Y_fitMock_before(1:99,:),Y_fitMock_after);
figure;
hold on;
title("State of Population throughout Global Pandemic Simulation")
xlabel("Time (Days)")
ylabel("Fraction of the total population")
plot(Y_fitMock_combined);
plot(cumulativeDeaths');
plot(newInfections');
legend('S','I','R','D','V','B','Cumulative Deaths', 'New Infections');