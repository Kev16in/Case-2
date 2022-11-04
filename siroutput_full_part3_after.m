%% This function takes three inputs
% x - a set of parameters
% t - the number of time-steps you wish to simulate
function f = siroutput_full_part3_after(x,t,initial)

% Here is a suggested framework for x.  However, you are free to deviate
% from this if you wish.

% set up transmission constants
k_infections = x(1);
k_fatality = x(2);
k_recover = x(3);
k_vaccinated = x(4);
k_breakthrough = x(5);

% Set up SIRD within-population transmission matrix
A = [(1-k_infections-k_vaccinated) 0                        0.001     0 0                  0.02;
    (k_infections)                 (1-k_fatality-k_recover) 0     0 0                  0;
    0                              (k_recover)              0.998 0 0                  0;
    0                              (k_fatality)             0     1 0                  0;
    (k_vaccinated)                 0                        0.001  0 (1-k_breakthrough) 0;
    0                              0                        0     0 (k_breakthrough)   0.98];

% A = [(1-k_infections-k_vaccinated) 0                        (1-k_recover-k_vaccinated) 0 0                  0;
%     (k_infections)                 (1-k_fatality-k_recover) 0                          0 0                  0;
%     0                              (k_recover)              (k_recover)                0 0                  (k_recover);
%     0                              (k_fatality)             0                          1 0                  (k_fatality);
%     (k_vaccinated)                 0                        (k_vaccinated)             0 (1-k_breakthrough) 0;
%     0                              0                        0                          0 (k_breakthrough)   (1-k_recover-k_fatality)];

% The next line creates a zero vector that will be used a few steps.
B = zeros(6,1);

% Set up the vector of initial conditions
x0 = initial;

% Here is a compact way to simulate a linear dynamical system.
% Type 'help ss' and 'help lsim' to learn about how these functions work!!
sys_sir_base = ss(A,B,eye(6),zeros(6,1),1);
y  = lsim(sys_sir_base,zeros(t,1),linspace(0,t-1,t),x0);

% return the output of the simulation
f = y;
end