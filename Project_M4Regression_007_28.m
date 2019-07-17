function [SSE, SST, r_squared] = Project_M4Regression_007_28(tau1, tau2, tau3, tau4, tau5, tau_values)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% This function performs non-linear regression on a set of 5 data points
% for 5 different values of time constant. This is done on a graph for time
% constant versus price per unit for the given FOS. This function then
% finds out the equation that represents values for all 100 data points and
% generates the plot. 
%
% Function Call
% [SSE, SST, r_squared] = Project_M4Regression_007_28(tau1, tau2, tau3, tau4, tau5, tau_values)
%
% Input Arguments
% tau1 % mean time constant for the 20 data sets for FOS-1
% tau2 % mean time constant for the 20 data sets for FOS-2
% tau3 % mean time constant for the 20 data sets for FOS-3
% tau4 % mean time constant for the 20 data sets for FOS-4
% tau5 % mean time constant for the 20 data sets for FOS-5
% tau_values %values for time constants for each of the 100 time histories
%            %provided
%
% Output Arguments
% SSE %Sum of squared errors for the regression model
% SST %Sum of squared totals for the regression model
% r-squared %r-squared value for the regression model
%
% Assignment Information
%   Assignment:       	Milestone 4, Final project
%   Authors:            Kirthi Shankar Sivamani, ksivaman@purdue.edu
%                       Godfred Mantey, gmantey@purdue.edu
%                       Oliver Balicanta, obalican@purdue.edu
%                       Spencer Dorsch, sdorsch@purdue.edu 
%   Team ID:            007-28      
%  	Contributor: 		Name, login@purdue [repeat for each]
%   My contributor(s) helped me:	
%     [ ] understand the assignment expectations without
%         telling me how they will approach it.
%     [ ] understand different ways to think about a solution
%         without helping me plan my solution.
%     [ ] think through the meaning of a specific error or
%         bug present in my code without looking at my code.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ____________________
%% INITIALIZATION 

   mean_tau_values = [tau1, tau2, tau3, tau4, tau5]; %Creating a vector storing 
   unit_price = [17.09, 9.16, 3.77, 2.19, 0.70]; %These values represent unit prices ($) for different thermocouples given in the project memo. 
                                                 %The price at index 1 is for FOS-1, index 2 is for FOS-2 and so on.
   log_tau = log10(mean_tau_values); %taking log of tau values for linearization of the power function
   log_price = log10(unit_price); %taking log of tau values for linearization of the power function
   original_unit_price = [linspace(unit_price(1), unit_price(1), 20), linspace(unit_price(2), unit_price(2), 20), linspace(unit_price(3), unit_price(3), 20), linspace(unit_price(4), unit_price(4), 20), linspace(unit_price(5), unit_price(5), 20)]; %Original unit prices of thermocouples for corresponding tau values
   tau_points = linspace(min(tau_values), max(tau_values), 10000); %Creating vector for tau values to plot for regression model. The vector contains 10000 points for a smooth curve
   FOS1_price = linspace(unit_price(1), unit_price(1), 20);
   FOS2_price = linspace(unit_price(2), unit_price(2), 20);
   FOS3_price = linspace(unit_price(3), unit_price(3), 20);
   FOS4_price = linspace(unit_price(4), unit_price(4), 20);
   FOS5_price = linspace(unit_price(5), unit_price(5), 20);
   
%% ____________________
%% CALCULATIONS

   coeffs = polyfit(log_tau, log_price, 1); %Calculating the slope and intercept of the linearized data
   intercept = coeffs(2); %separating intercept in a variable
   slope = coeffs(1); %separating slope in a variable
   coeffx = 10 ^ intercept; %Calculating the coefficient of x in the exponential function
   power = slope; %Assigning the coefficient of 10 for exponential function
   model_price_all_values = coeffx .* (tau_points .^ (power)); %Calculating the modelled price as a function of tau for all values of tau 
   model_price_actual = coeffx .* (tau_values .^ (power)); %Calculating the modelled price as a function of tau in the original data set
   mean_unit_price = mean(original_unit_price); %Calculating mean of all unit prices. 
   FOS1_tau = tau_values(1:20); %Tau values for FOS-1
   FOS2_tau = tau_values(21:40); %Tau values for FOS-2
   FOS3_tau = tau_values(41:60); %Tau values for FOS-3
   FOS4_tau = tau_values(61:80); %Tau values for FOS-4
   FOS5_tau = tau_values(81:100); %Tau values for FOS-5
   
%% ____________________
%% FORMATTED TEXT & FIGURE DISPLAYS
 
  figure(1); %Creating new figure window
  grid on; %Displaying gridlines
  subplot(2,2,1); %Creating subplot 1 of 4
  plot(mean_tau_values, unit_price, 'ok') %Plotting 5 mean values of tau vs price for the FOS to analyze and decide the type of function that best models the relationship.
  title('Linear scale plot of time constant vs unit price for the FOS'); %Adding title 
  xlabel('Time constant (seconds)'); %Labelling x-axis
  ylabel('Price per unit thermocouple (US dollars)'); %Labelling y-axis
  subplot(2,2,2); %Creating subplot 2 of 4
  loglog(mean_tau_values, unit_price, '*r') %Creating log-log plot of the original data
  title('Loglog plot of time constant vs unit price for the FOS'); %Adding title 
  xlabel('Time constant (seconds)'); %Labelling x-axis
  ylabel('Price per unit thermocouple (US dollars)'); %Labelling y-axis
  subplot(2,2,3); %Creating subplot 3 of 4
  semilogx(mean_tau_values, unit_price, '^b') %Creating semilogx plot of the original data
  title('Semilogx plot of time constant vs unit price for the FOS'); %Adding title 
  xlabel('Time constant (seconds)'); %Labelling x-axis
  ylabel('Price per unit thermocouple (US dollars)'); %Labelling y-axis
  subplot(2,2,4); %Creating subplot 4 of 4
  semilogy(mean_tau_values, unit_price, 'xg') %Creating semilogy plot of the original data 
  title('Semilogy plot of time constant vs unit price for the FOS'); %Adding title 
  xlabel('Time constant (seconds)'); %Labelling x-axis
  ylabel('Price per unit thermocouple (US dollars)'); %Labelling y-axis
  
  figure(2); %Opening new figure window
  %plot(tau_values, original_unit_price, '*r', 'DisplayName', sprintf('Original data')); %plotting original data of time constant and price
  plot(FOS1_tau, FOS1_price, '*r', 'DisplayName', sprintf('FOS-1 data')); %Plotting original data for FOS1
  hold on; %retaining figure window
  plot(FOS2_tau, FOS2_price, '*g', 'DisplayName', sprintf('FOS-2 data')); %Plotting original data for FOS2
  hold on; %retaining figure window
  plot(FOS3_tau, FOS3_price, '*m', 'DisplayName', sprintf('FOS-3 data')); %Plotting original data for FOS3
  hold on; %retaining figure window
  plot(FOS4_tau, FOS4_price, '*b', 'DisplayName', sprintf('FOS-4 data')); %Plotting original data for FOS4
  hold on; %retaining figure window
  plot(FOS5_tau, FOS5_price, '*y', 'DisplayName', sprintf('FOS-5 data')); %Plotting original data for FOS5
  hold on; %retaining figure window
  grid on; %Displaying gridlines
  plot(tau_points, model_price_all_values, '-k', 'DisplayName', sprintf('Regression model: price = (%.2f)*(tau^{%.2f})', coeffx, power)) %Plotting all values of time constant vs the modelling price as a function of time constant
  title('Plot of time constant vs actual price overlayed on a smooth best fit regression model'); %Adding title
  xlabel('Time constant (seconds)'); %Labelling x-axis
  ylabel('Price per unit thermocouple (US dollars)'); %Labelling y-axis
  %axis([0 1.8 0 20]);
  legend %Creating legend
  
  SSE = sum((model_price_actual - (original_unit_price)') .^ 2); %Calculating SSE for the regression model
  SST = sum((model_price_actual - mean_unit_price) .^ 2); %Calculating SST for the regression model
  r_squared = 1 - SSE / SST; %Calculating r-squared value for the regression model
  
end %Ending function
%% ____________________
%% COMMAND WINDOW OUTPUT

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% I have not used source code obtained from any other unauthorized
% source, either modified or unmodified.  Neither have I provided
% access to my code to another. The project I am submitting
% is my own original work.