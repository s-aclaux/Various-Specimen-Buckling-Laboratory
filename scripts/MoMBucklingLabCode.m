clear all
clf
clc

%% Given Values
% 1 is for Alumninium
% 2 is for Steel
E1 = 68.947 * 10^9;
E2 = 200 * 10^9;
k = 0.5;
A1 = 31.76919859 * 10^(-6); % Change to your average aluminium specimen area
A2 = 31.19248072 * 10^(-6); % Change to your average steel specimen area
I1 = 80.31769662 * 10^(-12); % Change to your average aluminium specimen area moment of inertia
I2 = 77.42887132 * 10^(-12); % Change to your average steel specimen area moment of inertia
sigmay1 = 240 * 10^6;
sigmay2 = 250 * 10^6;


%% Functions
% S1 = sqrt((A1 .* L.^2)/I1)
% S2 = sqrt((A2 .* L.^2)/I2)

sigmacre1 = @(S1) (pi.^2 .* E1) ./ (k.^2 .* (S1).^2);
sigmacre2 = @(S2) (pi.^2 .* E2) ./ (k.^2 .* (S2).^2);

sigmacrj1 = @(S1) sigmay1 - ((sigmay1^2 .* k^2 .* S1.^2) ./ (4 .* pi.^2 .* E1));
sigmacrj2 = @(S2) sigmay2 - ((sigmay2^2 .* k^2 .* S2.^2) ./ (4 .* pi.^2 .* E2));

%% Transitions
tre1 = fzero(@(S1) sigmacre1(S1) - sigmay1, 100)
tre2 = fzero(@(S2) sigmacre2(S2) - sigmay2, 180)

trj1 = (pi ./ k) .* sqrt((2 .* E1) ./ sigmay1)
trj2 = (pi ./ k) .* sqrt((2 .* E2) ./ sigmay2)

%% Experimental Data
SE1 = [28.52664575, 88.69291334, 151.6981131, 214.254317, 314.2586749];
SE2 = [29.49044584, 89.44532483, 152.063492, 217.3608902, 315.8925749];
% Change these to your slenderness values for each specimen

sigmaE1 = [303.5552069, 300.6625313, 136.9937201, 66.45888579, 26.91182389] * 10^6;
sigmaE2 = [706.534528, 570.1773681, 360.4497065, 184.3808051, 98.18438164] * 10^6;
% Change these to your peak stress values for each specimen

%% Plotting
figure(1)
fplot(sigmacre1, [tre1, 600], 'g', 'LineWidth', 2)
hold on;
fplot(sigmacrj1, [0, trj1], 'r', 'LineWidth', 2)
hold on;
fplot(sigmay1, [0, tre1], 'b', 'LineWidth', 2)
hold on;
xline(tre1, 'b--', 'LineWidth', 1);
hold on;
xline(trj1, 'r--', 'LineWidth', 1);
hold on;
plot(SE1, sigmaE1, 'ro', 'MarkerSize', 4, 'MarkerFaceColor', 'k'); 
axis([0 600 0 800000000]);
title({'Stress as a Function of Slenderness', 'for 6061-T6 Aluminium'});
xlabel('Slenderness');
ylabel('Peak Stress (Pa)');

figure(2)
fplot(sigmacre2, [tre2, 600], 'g', 'LineWidth', 2)
hold on;
fplot(sigmacrj2, [0, trj2], 'r', 'LineWidth', 2)
hold on;
fplot(sigmay2, [0, tre2], 'b', 'LineWidth', 2)
hold on;
xline(tre2, 'b--', 'LineWidth', 1);
hold on;
xline(trj2, 'r--', 'LineWidth', 1);
hold on;
plot(SE2, sigmaE2, 'ro', 'MarkerSize', 4, 'MarkerFaceColor', 'k');
axis([0 600 0 800000000]);
title({'Stress as a Function of', 'Slenderness for A36 Steel'});
xlabel('Slenderness');
ylabel('Peak Stress (Pa)');