# Battery Degradation Model

## General view
This code performs a battery degradation analysis by fitting a custom function to data obtained from an Excel file. The data is read into MATLAB using the readtable function and assigned to two variables, Ah and Q_loss. The fixed parameters of the model include the State of Charge (SOC), Gas Constant (R_g), Temperature (T), Current (I_c), and Activation Energy (E_a). The custom fitting model is defined using the fittype function and the data is fit to the model using the fit function. The fitted parameters are extracted and used to calculate the severity factor and R^2 value. The fitted expression is also plotted for a defined range of Ah values using the feval function.

## Prerequisites
MATLAB
Excel file containing the battery degradation data (named "data.xlsx")

## Running the code
Open MATLAB.
Run the code in the MATLAB environment.
The plot of the fitted expression will be displayed in a new figure window.
