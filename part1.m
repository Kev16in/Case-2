SIRD = [0.9;0.08;0.00;0.02];

stateChanger = [0.85 0.1 0 0; 0.15 0.75 0 0;...
    0 0.1 1 0; 0 0.05 0 1];

changeSIRD = [];
change=stateChanger*SIRD; %%Calculate change for first week
changeSIRD=cat(2,changeSIRD,change); %%Concatenate change vector to empty array
for i = 1:9
    change=stateChanger*change; %%use the current change vector to get new change vector
    changeSIRD=cat(2,changeSIRD,change); %%Concatenate change vector to empty array
end 
plot(changeSIRD');
legend('Susceptible','Infected','Recovered','Deceased');
xlabel("Time in Weeks");
ylabel("Fraction of Population");
%%
changeMatrix=[0.95 0.04 0 0;
    0.05 0.85 0 0;
    0 0.1 1 0;
    0 0.01 0 1];
newSIRD=[1;0;0;0];
change2=changeMatrix*newSIRD;
changeSIRD2=[];
changeSIRD2=cat(2,changeSIRD2,change2);
for i = 1:199
    change2=changeMatrix*change2; %%use the current change vector to get new change vector
    changeSIRD2=cat(2,changeSIRD2,change2); %%Concatenate change vector to empty array
end
figure;
plot(changeSIRD2');