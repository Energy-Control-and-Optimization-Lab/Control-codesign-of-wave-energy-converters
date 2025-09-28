figure;

% Left Y-axis for velocities
yyaxis left
plot(ReferenceVelocitySMCtanh.time, ReferenceVelocitySMCtanh.signals.values, 'g--', 'LineWidth', 1.5);
hold on;
plot(VelocitySMCTanh.time, VelocitySMCTanh.signals.values, 'b', 'LineWidth', 1.5);
ylabel('Velocity (m/s)');

% Right Y-axis for Fext
yyaxis right
plot(FextSMCTanh.time, FextSMCTanh.signals.values, 'r', 'LineWidth', 1.5);
ylabel('Excitation Force (N)');

xlabel('Time (s)');
title('Fext, Reference Velocity, and Actual Velocity - SMC Tanh');
legend('Reference Velocity', 'Actual Velocity', 'Fext', 'Location', 'best');
grid on;
%% Energy
figure;
plot(EnergySMCTanh.time, EnergySMCTanh.signals.values / 1e6, 'm', 'LineWidth', 1.5); % Energy in MJ
xlabel('Time (s)');
ylabel('Energy (MJ)');
title('Absorbed Energy - SMC Tanh');
grid on;
%% position
figure;
plot(PositionSMCTanh.time, PositionSMCTanh.signals.values, 'k', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Position (m)');
title('Position - SMC Tanh');
grid on;
%% Control Force
figure;
plot(ControlforceSMCTanh.time, ControlforceSMCTanh.signals.values, 'c', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Control Force (N)');
title('Control Force - SMC Tanh');
grid on;
