%% Phase 1
Phase1=siroutput_full_policies([x(1),x(2),x(3),x(4),x(5),x(6),x(7)], 250);
figure;
plot(Phase1);
legend('S','I','R','D');
xlabel('Time')
ylabel('Percentage Population');
Phase2_starting_values=Phase1(250,:);
Phase1=Phase1(1:249,:);

%% Phase 2
Phase2=siroutput_full_policies([x(1)*0.5,x(2),x(3),Phase2_starting_values(1:4)], 251);
figure;
plot(Phase2);
legend('S','I','R','D');
xlabel('Time')
ylabel('Percentage Population');
Phase3_starting_values=Phase2(251,:);
Phase2=Phase2(1:250,:);
%% Phase 3
Phase3=siroutput_full_policies([x(1)*0.5,x(2)*0.8,x(3)*1.5,Phase3_starting_values(1:4)], 299);
figure;
plot(Phase3);
legend('S','I','R','D');
xlabel('Time')
ylabel('Percentage Population');

%% Phase Combined and Percent Change

Phase_combined=cat(1, Phase1, Phase2, Phase3);
figure;
hold on
plot(Phase_combined);
plot(1 - coviddata(:,1))
plot(Y_fit(:,1))
legend('S','I','R','D','Actual Susceptible','S from Y fit');
xlabel('Time')
ylabel('Percentage Population');

Case_percentage_change=1-(Phase_combined(798,2)+Phase_combined(798,3)+Phase_combined(798,4))/(Y_fit(798,2)+Y_fit(798,3)+Y_fit(798,4));
Deaths_percentage_change=1-(Phase_combined(798,4)/Y_fit(798,4));