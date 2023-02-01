% Read data from an Excel file
filename = 'data.xlsx';
tab = readtable(filename);

% Assign the values to two different variables
Ah = transpose(tab.Var1);
Q_loss = transpose(tab.Var2);

% Define the fixed parameters
SOC = 60;
R_g = 8.3140;
T = 20;
I_c = 0.25;
E_a = 31500;

% Define the fit model, in this case a custom function

% Define the custom fitting model
ft = fittype('(a*SOC+b)*exp((n*I_c - E_a)/(R_g*(273.15+T)))*(Ah^z)',...
    'independent', {'Ah'}, 'dependent', {'Q_loss'},...
    'coefficients', {'a', 'b', 'n', 'z'},...
    'problem', {'SOC', 'R_g', 'T', 'I_c', 'E_a'});

% Fit the data using the custom fitting model and the fixed parameters
[fitresult, gof] = fit(Ah', Q_loss', ft, 'problem', {SOC, R_g, T, I_c, E_a});

% Extract the fitted parameters
a = fitresult.a;
b = fitresult.b;
n = fitresult.n;
z = fitresult.z;

% Severity factor function and R^2 
Severity_factor = (a*SOC+b)*exp((n*I_c - E_a)/(R_g*(273.15+T)));
r_square = gof.rsquare;

% Extract the fitted equation
eqn = formula(fitresult);

% Define the range of Ah values to be plotted
Ah_range = linspace(min(Ah), max(Ah), 100);

% Evaluate the fitted expression for the defined range of Ah values
Q_loss_fit = feval(fitresult, Ah_range);

% Plot the fitted expression
figure
plot(Ah_range, Q_loss_fit, 'b-')
hold on
plot(Ah, Q_loss, 'ro')
title('Battery degradation curve as a function of the Ah')
xlabel('Ampere-hour throughput [Ah]')
ylabel('Batery loss [%]')
legend('Fit', 'Data')
