coviddata = table2array(COVID_STLmetro(:,5:6))/(100000 * STLmetroPop); % TO SPECIFY
t = 798; % TO SPECIFY

% The following line creates an 'anonymous' function that will return the cost (i.e., the model fitting error) given a set
% of parameters.  There are some technical reasons for setting this up in this way.
% Feel free to peruse the MATLAB help at
% https://www.mathworks.com/help/optim/ug/fmincon.html
% and see the sectiono on 'passing extra arguments'
% Basically, 'sirafun' is being set as the function siroutput (which you
% will be designing) but with t and coviddata specified.
sirafun= @(x)siroutput_policy(x,t,coviddata);

%% set up rate and initial condition constraints
% Set A and b to impose a parameter inequality constraint of the form A*x < b
% Note that this is imposed element-wise
% If you don't want such a constraint, keep these matrices empty.
A = [0,1,1,0,0,0,0,0;
    1,0,0,0,0,0,0,0];
b = [1,1];

%% set up some fixed constraints
% Set Af and bf to impose a parameter constraint of the form Af*x = bf
% Hint: For example, the sum of the initial conditions should be
% constrained
% If you don't want such a constraint, keep these matrices empty.
Af = [0,0,0,0,1,1,1,1];
bf = 1;

%% set up upper and lower bound constraints
% Set upper and lower bounds on the parameters
% lb < x < ub
% here, the inequality is imposed element-wise
% If you don't want such a constraint, keep these matrices empty.
ub = [1,1,1,1,1,1,1,1]';
lb = [0,0,0,0,0,0,0,0]';

% Specify some initial parameters for the optimizer to start from
x0 = [0.2,0.3,0.1,0.1,1,0,0,0]; 

% This is the key line that tries to opimize your model parameters in order to
% fit the data
% note tath you 
xP = fmincon(sirafun,x0,A,b,Af,bf,lb,ub);

%plot(Y);
%legend('S','I','R','D');
%xlabel('Time')

Y_fit_Policy = siroutput_full_policies(xP,t);

figure;
hold on
plot(Y_fit_Policy);
xlabel('Time')
plot(1-coviddata(:,1))
plot(coviddata(:,2))
legend('S','I','R','D','Actual Suseptable', 'Actual Deaths');
% Make some plots that illustrate your findings.
% TO ADD