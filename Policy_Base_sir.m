%% Phase 1 No Mandates
Phase1=siroutput_full_policies([x(1),x(2),x(3),x(4),x(5),x(6),x(7)], 250);
%We keep the rates and initial conditions as they originally are since no
%mandates were enforced during this time
figure;
plot(Phase1);
legend('S','I','R','D');
xlabel('Time')
ylabel('Percentage Population');
Phase2_starting_values=Phase1(250,:);
Phase1=Phase1(1:249,:);

%% Phase 2 Mask Mandates
Phase2=siroutput_full_policies([x(1)*0.5,x(2),x(3),Phase2_starting_values(1:4)], 251);
%We mades the initial conditions start from the last state percentages in 
% the previous phase and decreased the infection rate by a factor of 0.5 due to 
% the mask mandate while keeping the other rates the same as the previous phase
figure;
plot(Phase2);
legend('S','I','R','D');
xlabel('Time')
ylabel('Percentage Population');
Phase3_starting_values=Phase2(251,:);
Phase2=Phase2(1:250,:);
%% Phase 3 Vaccinations
Phase3=siroutput_full_policies([x(1)*0.5,x(2)*0.8,x(3)*1.5,Phase3_starting_values(1:4)], 299);
%We mades the initial conditions start from the last state percentages in 
% the previous phase. We decreased the death rate by a factor of 0.8 and
% increased the recovery rate by a factor of 1.5 due to vaccines being
% rolled out during this period. We kept the other rates the same as the
% previous phase.
figure;
plot(Phase3);
legend('S','I','R','D');
xlabel('Time')
ylabel('Percentage Population');

%% Phase Combined and Percent Change

Phase_combined=cat(1, Phase1, Phase2, Phase3); %Combined phases into 1 array
figure;
hold on
plot(Phase_combined);
plot(1 - coviddata(:,1))
plot(Y_fit(:,1))
legend('S','I','R','D','Actual Susceptible','S from Y fit');
xlabel('Time')
ylabel('Percentage Population');

Case_percentage_change=1-(Phase_combined(798,2)+Phase_combined(798,3)+Phase_combined(798,4))/(Y_fit(798,2)+Y_fit(798,3)+Y_fit(798,4));
%This calculates the percent change by dividing the last case
%percentages (sum of infected, deceased, and recovered fraction) in Phase_combined by the last state percentages in Y_fit
%(array without any mandates) and subtracting the quotient from 1
Deaths_percentage_change=1-(Phase_combined(798,4)/Y_fit(798,4));
%This calculates the percent change by dividing the last death percentage
%in Phase_combined by the last death percentage in Y_fit and subtracting
%the quotient from 1.