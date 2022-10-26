sird = [0.9;0.08;0.00;0.02];

stateChanger = [0.85 0.1 0 0; 0.15 0.75 0 0;...
    0 0.1 1 0; 0 0.05 0 1];

week1 = stateChanger * sird;

week2 = stateChanger * week1;

week3 = stateChanger * week2;

suseptable = 0.90;
infected = 0.08;
recovered = 0.00;

zero = [0 0 0 0; 0 0 0 0; 0 0 0 0; 0 0 0 0];

for i = 1:10
    
    
    
end 