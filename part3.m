
mockData = cat(2, newInfections', cumulativeDeaths');
t = 365;
sirafun= @(x)siroutput(x,t,mockData);

A = [0,1,1,0,0,0,0;
    1,0,0,0,0,0,0];
b = [1,1];

Af = [0,0,0,1,1,1,1];
bf = 1;

ub = [1,1,1,1,1,1,1]';
lb = [0,0,0,0,0,0,0]';
x0Mock = [0.2,0.3,0.1,1,0,0,0]; 


xMock = fmincon(sirafun,x0Mock,A,b,Af,bf,lb,ub);

Y_fitMock = siroutput_full(xMock,t);

hold on 
plot(Y_fitMock)
plot(cumulativeDeaths)
plot(newInfections)
legend('S','I','R','D','Cumulative Deaths', 'New Infections')