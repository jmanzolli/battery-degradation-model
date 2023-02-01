% Read data from an Excel file
filename = 'data.xlsx';
tab = readtable(filename);

% Assign the values to two different variables
t = transpose(tab.Var1);
Q_loss = transpose(tab.Var2);

% Define the fixed parameters
SOC = 60;
R_g = 8.3140;
T = 20;
E_a = 31500;

% Define the fit model, in this case a custom function

% Define the custom fitting model
ft = fittype('(a*SOC+b)*exp((E_a)/(R_g*(273.15+T)))*(t^z)',...
    'independent', {'t'}, 'dependent', {'Q_loss'},...
    'coefficients', {'a', 'b', 'z'},...
    'problem', {'SOC', 'R_g', 'T', 'E_a'});

% Fit the data using the custom fitting model and the fixed parameters
[fitresult, gof] = fit(t', Q_loss', ft, 'problem', {SOC, R_g, T, E_a});

% Extract the fitted parameters
a = fitresult.a;
b = fitresult.b;
z = fitresult.z;

% Severity factor function and R^2 
B = (a*SOC+b)*exp((E_a)/(R_g*(273.15+T)));
r_square = gof.rsquare;

% Extract the fitted equation
eqn = formula(fitresult);

% Define the range of Ah values to be plotted
t_range = linspace(min(t), max(t), 100);

% Evaluate the fitted expression for the defined range of Ah values
Q_loss_fit = feval(fitresult, t_range);

% Plot the fitted expression
figure
plot(t_range, Q_loss_fit, 'b-')
hold on
plot(t, Q_loss, 'ro')
title('Battery degradation curve as a function of the time')
xlabel('time [days]')
ylabel('Batery loss [%]')
legend('Fit', 'Data')