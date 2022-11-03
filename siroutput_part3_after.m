function f = siroutput_part3_after(x,t,mockData)

% Here is a suggested framework for x.  However, you are free to deviate
% from this if you wish.

% set up transmission constants
k_infections = x(1);
k_fatality = x(2);
k_recover = x(3);
k_vaccinated = x(4);
k_breakthrough = x(5);

% set up initial conditions
ic_susc = x(6);
ic_inf = x(7);
ic_rec = x(8);
ic_fatality = x(9);
ic_vac = x(10);

% Set up SIRD within-population transmission matrix
A = [(1-k_infections-k_vaccinated) 0 0.05 0 k_breakthrough;
    (k_infections) (1-k_fatality-k_recover) 0 0 0;
    0 (k_recover) 0.95 0 0;
    0 (k_fatality) 0 1 0;
    (k_vaccinated) 0 0 0 (1-k_breakthrough)];

% The next line creates a zero vector that will be used a few steps.
B = zeros(5,1);

% Set up the vector of initial conditions
x0 = [ic_susc, ic_inf, ic_rec, ic_fatality,ic_vac];

% Here is a compact way to simulate a linear dynamical system.
% Type 'help ss' and 'help lsim' to learn about how these functions work!!
sys_sir_base = ss(A,B,eye(5),zeros(5,1),1);
y  = lsim(sys_sir_base,zeros(t,1),linspace(0,t-1,t),x0);

% return a "cost".  This is the quantitity that you want your model to
% minimize.  Basically, this should encapsulate the difference between your
% modeled data and the true data. Norms and distances will be useful here.
% Hint: This is a central part of this case study!  choices here will have
% a big impact!
f = norm(y(:,2) - (mockData(:,1))) + norm(y(:,4) - (mockData(:,2)));
end