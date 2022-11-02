%%% The functions used for this part can all be found in this script
%%

%%% This is one of our first attempts at making a linear dynamical model
%%% where we plugged in a starting percentage for each letter (Susceptible
%%% , Infected, recover, Deceased) and a rate at which they change as time
%%% passes on. 

SIRD = [0.9;0.08;0.00;0.02]; 

% Here we have the starting percentagaes 

stateChanger = [0.85 0.1 0 0; 0.15 0.75 0 0;...
    0 0.1 1 0; 0 0.05 0 1];

% Above is the A matrix that changes x as it takes t steps

changeSIRD = [];
change=stateChanger*SIRD; %%Calculate change for first week
changeSIRD=cat(2,changeSIRD,change); %%Concatenate change vector to empty array
for i = 1:99 
    change=stateChanger*change; %%use the current change vector to get new change vector
    changeSIRD=cat(2,changeSIRD,change); %%Concatenate change vector to empty array
end 
plot(changeSIRD');
title('Simulation of Dynamical Model (No reinfections)')
legend('Susceptible','Infected','Recovered','Deceased');
xlabel("Time in Weeks");
ylabel("Fraction of Population");

% This is the graph of what our simulation gave us based on the parameters
% and initial conditions. 
%%
%%% Here we have a different attempt where we introduce the ability to
%%% become reinfected

changeMatrix=[0.85 0.1 0 0;
    0.15 0.75 0.05 0;
    0 0.1 0.95 0;
    0 0.05 0 1];
newSIRD=[1;0;0;0];
change2=changeMatrix*newSIRD;
changeSIRD2=[];
changeSIRD2=cat(2,changeSIRD2,change2);

for i = 1:99
    change2=changeMatrix*change2; %%use the current change vector to get new change vector
    changeSIRD2=cat(2,changeSIRD2,change2); %%Concatenate change vector to empty array
end

figure;
plot(changeSIRD2');
title('Simulation of dynamical model (Reinfections Allowed)')
legend('Susceptible','Infected','Recovered','Deceased');
xlabel("Time in Weeks");
ylabel("Fraction of Population");

% When it is possible to become reinfected with a new disease (or same one)
% then the number of deaths as time goes on increases exponentially and
% eventually everyone dies no matter what. 