function [] = Project_M4exec_007_28()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% This function calculates the mean time constant, standard deviation of the time 
% constant and the mean modififed SSE for five different thermocouples using user defined functions 
% M3_calcSSE_007_28, Project_M3Regression_007_28, and Project_M3Algorithm_007_28
%
% Function Call
% Project_M4exec_007_28()
%
% Input Arguments
% NONE.
%
% Output Arguments
% NONE.
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
   
   tic;
   
   Heating_data = csvread('M3_Data_HeatingTimeHistories.csv', 0, 0);
   Cooling_data = csvread('M3_Data_CoolingTimeHistories.csv', 0, 0);
   
   time = Heating_data(:,1); %Time vector for all 100 time history data
   FOS1_heating_temp = Heating_data(:,(2:11)); %Temperature vector for FOS1 heating data
   FOS2_heating_temp = Heating_data(:,(12:21)); %Temperature vector for FOS2 heating data
   FOS3_heating_temp = Heating_data(:,(22:31)); %Temperature vector for FOS3 heating data
   FOS4_heating_temp = Heating_data(:,(32:41)); %Temperature vector for FOS4 heating data
   FOS5_heating_temp = Heating_data(:,(42:51)); %Temperature vector for FOS5 heating data
   FOS1_cooling_temp = Cooling_data(:,(2:11)); %Temperature vector for FOS1 cooling data
   FOS2_cooling_temp = Cooling_data(:,(12:21)); %Temperature vector for FOS2 cooling data
   FOS3_cooling_temp = Cooling_data(:,(22:31)); %Temperature vector for FOS3 cooling data
   FOS4_cooling_temp = Cooling_data(:,(32:41)); %Temperature vector for FOS4 cooling data
   FOS5_cooling_temp = Cooling_data(:,(42:51)); %Temperature vector for FOS5 cooling data
   
   FOS1_heating_parameters = zeros(10,4); %Initializing matrix to store all 4 parameters for each data set for FOS-1 heating data
   FOS2_heating_parameters = zeros(10,4); %Initializing matrix to store all 4 parameters for each data set for FOS-2 heating data
   FOS3_heating_parameters = zeros(10,4); %Initializing matrix to store all 4 parameters for each data set for FOS-3 heating data
   FOS4_heating_parameters = zeros(10,4); %Initializing matrix to store all 4 parameters for each data set for FOS-4 heating data
   FOS5_heating_parameters = zeros(10,4); %Initializing matrix to store all 4 parameters for each data set for FOS-5 heating data
   FOS1_cooling_parameters = zeros(10,4); %Initializing matrix to store all 4 parameters for each data set for FOS-1 cooling data
   FOS2_cooling_parameters = zeros(10,4); %Initializing matrix to store all 4 parameters for each data set for FOS-2 cooling data
   FOS3_cooling_parameters = zeros(10,4); %Initializing matrix to store all 4 parameters for each data set for FOS-3 cooling data
   FOS4_cooling_parameters = zeros(10,4); %Initializing matrix to store all 4 parameters for each data set for FOS-4 cooling data
   FOS5_cooling_parameters = zeros(10,4); %Initializing matrix to store all 4 parameters for each data set for FOS-5 cooling data
   
   tau_values = [1:100]; %Initializing a vector of length 100 to store tau for each datatype
   
%% ____________________
%% CALCULATIONS
  
   for index = 1:10 %To store all all 10 rows of the matrix 
       [FOS1_heating_parameters(index,1), FOS1_heating_parameters(index,2), FOS1_heating_parameters(index,3), FOS1_heating_parameters(index,4)] = Project_M4Algorithm_007_28(time, FOS1_heating_temp(:,index)); %Calculating the 4 parameters using Algorithm for this particular Temperature set
       [FOS2_heating_parameters(index,1), FOS2_heating_parameters(index,2), FOS2_heating_parameters(index,3), FOS2_heating_parameters(index,4)] = Project_M4Algorithm_007_28(time, FOS2_heating_temp(:,index)); %Calculating the 4 parameters using Algorithm for this particular Temperature set
       [FOS3_heating_parameters(index,1), FOS3_heating_parameters(index,2), FOS3_heating_parameters(index,3), FOS3_heating_parameters(index,4)] = Project_M4Algorithm_007_28(time, FOS3_heating_temp(:,index)); %Calculating the 4 parameters using Algorithm for this particular Temperature set
       [FOS4_heating_parameters(index,1), FOS4_heating_parameters(index,2), FOS4_heating_parameters(index,3), FOS4_heating_parameters(index,4)] = Project_M4Algorithm_007_28(time, FOS4_heating_temp(:,index)); %Calculating the 4 parameters using Algorithm for this particular Temperature set
       [FOS5_heating_parameters(index,1), FOS5_heating_parameters(index,2), FOS5_heating_parameters(index,3), FOS5_heating_parameters(index,4)] = Project_M4Algorithm_007_28(time, FOS5_heating_temp(:,index)); %Calculating the 4 parameters using Algorithm for this particular Temperature set
       [FOS1_cooling_parameters(index,1), FOS1_cooling_parameters(index,2), FOS1_cooling_parameters(index,3), FOS1_cooling_parameters(index,4)] = Project_M4Algorithm_007_28(time, FOS1_cooling_temp(:,index)); %Calculating the 4 parameters using Algorithm for this particular Temperature set 
       [FOS2_cooling_parameters(index,1), FOS2_cooling_parameters(index,2), FOS2_cooling_parameters(index,3), FOS2_cooling_parameters(index,4)] = Project_M4Algorithm_007_28(time, FOS2_cooling_temp(:,index)); %Calculating the 4 parameters using Algorithm for this particular Temperature set
       [FOS3_cooling_parameters(index,1), FOS3_cooling_parameters(index,2), FOS3_cooling_parameters(index,3), FOS3_cooling_parameters(index,4)] = Project_M4Algorithm_007_28(time, FOS3_cooling_temp(:,index)); %Calculating the 4 parameters using Algorithm for this particular Temperature set
       [FOS4_cooling_parameters(index,1), FOS4_cooling_parameters(index,2), FOS4_cooling_parameters(index,3), FOS4_cooling_parameters(index,4)] = Project_M4Algorithm_007_28(time, FOS4_cooling_temp(:,index)); %Calculating the 4 parameters using Algorithm for this particular Temperature set
       [FOS5_cooling_parameters(index,1), FOS5_cooling_parameters(index,2), FOS5_cooling_parameters(index,3), FOS5_cooling_parameters(index,4)] = Project_M4Algorithm_007_28(time, FOS5_cooling_temp(:,index)); %Calculating the 4 parameters using Algorithm for this particular Temperature set
   end %Ending for loop 

   mean_tau_FOS1 = mean([FOS1_heating_parameters(:,2);FOS1_cooling_parameters(:,2)]); %calculating the mean time constant for FOS1
   std_tau_FOS1 = std([FOS1_heating_parameters(:,2);FOS1_cooling_parameters(:,2)]); %calculating standard deviation of time constant for FOS1
   mean_tau_FOS2 = mean([FOS2_heating_parameters(:,2);FOS2_cooling_parameters(:,2)]); %calculating the mean time constant for FOS2
   std_tau_FOS2 = std([FOS2_heating_parameters(:,2);FOS2_cooling_parameters(:,2)]); %calculating standard deviation of time constant for FOS2
   mean_tau_FOS3 = mean([FOS3_heating_parameters(:,2);FOS3_cooling_parameters(:,2)]); %calculating the mean time constant for FOS3
   std_tau_FOS3 = std([FOS3_heating_parameters(:,2);FOS3_cooling_parameters(:,2)]); %calculating standard deviation of time constant for FOS3
   mean_tau_FOS4 = mean([FOS4_heating_parameters(:,2);FOS4_cooling_parameters(:,2)]); %calculating the mean time constant for FOS4
   std_tau_FOS4 = std([FOS4_heating_parameters(:,2);FOS4_cooling_parameters(:,2)]); %calculating standard deviation of time constant for FOS4
   mean_tau_FOS5 = mean([FOS5_heating_parameters(:,2);FOS5_cooling_parameters(:,2)]); %calculating the mean time constant for FOS5
   std_tau_FOS5 = std([FOS5_heating_parameters(:,2);FOS5_cooling_parameters(:,2)]); %calculating standard deviation of time constant for FOS5
       
   mean_SSEmod_FOS1 = M4_calcSSE_007_28([FOS1_heating_parameters;FOS1_cooling_parameters], time, [FOS1_heating_temp,FOS1_cooling_temp]); %calculating mean modified SSE for FOS1
   mean_SSEmod_FOS2 = M4_calcSSE_007_28([FOS2_heating_parameters;FOS2_cooling_parameters], time, [FOS2_heating_temp,FOS2_cooling_temp]); %calculating mean modified SSE for FOS2
   mean_SSEmod_FOS3 = M4_calcSSE_007_28([FOS3_heating_parameters;FOS3_cooling_parameters], time, [FOS3_heating_temp,FOS3_cooling_temp]); %calculating mean modified SSE for FOS3
   mean_SSEmod_FOS4 = M4_calcSSE_007_28([FOS4_heating_parameters;FOS4_cooling_parameters], time, [FOS4_heating_temp,FOS4_cooling_temp]); %calculating mean modified SSE for FOS4
   mean_SSEmod_FOS5 = M4_calcSSE_007_28([FOS5_heating_parameters;FOS5_cooling_parameters], time, [FOS5_heating_temp,FOS5_cooling_temp]); %calculating mean modified SSE for FOS5
   
   tau_values = [FOS1_heating_parameters(:,2);FOS1_cooling_parameters(:,2);FOS2_heating_parameters(:,2);FOS2_cooling_parameters(:,2);FOS3_heating_parameters(:,2);FOS3_cooling_parameters(:,2);FOS4_heating_parameters(:,2);FOS4_cooling_parameters(:,2);FOS5_heating_parameters(:,2);FOS5_cooling_parameters(:,2)]; %Assigning all 100 time constants to a vector
   
   [SSE, SST, r_squared] = Project_M4Regression_007_28(mean_tau_FOS1, mean_tau_FOS2, mean_tau_FOS3, mean_tau_FOS4, mean_tau_FOS5, tau_values); %Calling regression fucntion to perform non-linear regressiona and return the values of SSE, SST and r_squared
   
%% ____________________
%% FORMATTED TEXT & FIGURE DISPLAYS

   fprintf('Mean time constant for FOS-1 data: %f\n', mean_tau_FOS1);
   fprintf('Standard deviation for time constants for FOS-1 data: %f\n', std_tau_FOS1);
   fprintf('Mean modified SSE for FOS-1 data: %f\n\n', mean_SSEmod_FOS1);
   fprintf('Mean time constant for FOS-2 data: %f\n', mean_tau_FOS2);
   fprintf('Standard deviation for time constants for FOS-2 data: %f\n', std_tau_FOS2);
   fprintf('Mean modified SSE for FOS-2 data: %f\n\n', mean_SSEmod_FOS2);
   fprintf('Mean time constant for FOS-3 data: %f\n', mean_tau_FOS3);
   fprintf('Standard deviation for time constants for FOS-3 data: %f\n', std_tau_FOS3);
   fprintf('Mean modified SSE for FOS-3 data: %f\n\n', mean_SSEmod_FOS3);
   fprintf('Mean time constant for FOS-4 data: %f\n', mean_tau_FOS4);
   fprintf('Standard deviation for time constants for FOS-4 data: %f\n', std_tau_FOS4);
   fprintf('Mean modified SSE for FOS-4 data: %f\n\n', mean_SSEmod_FOS4);
   fprintf('Mean time constant for FOS-5 data: %f\n', mean_tau_FOS5);
   fprintf('Standard deviation for time constants for FOS-5 data: %f\n', std_tau_FOS5);
   fprintf('Mean modified SSE for FOS-5 data: %f\n\n', mean_SSEmod_FOS5);
   fprintf('SSE for the regression model for price vs time constant is: %f ($^2)\n', SSE);
   fprintf('SST for the regression model for price vs time constant is: %f ($^2)\n', SST);
   fprintf('R-squared value for the regression model for price vs time constant is: %f\n', r_squared);
   
   runTime = toc
   
end %Ending function
%% ____________________
%% COMMAND WINDOW OUTPUT

% Project_M4exec_007_28
% Mean time constant for FOS-1 data: 0.142820
% Standard deviation for time constants for FOS-1 data: 0.027078
% Mean modified SSE for FOS-1 data: 0.343606
% 
% Mean time constant for FOS-2 data: 0.344970
% Standard deviation for time constants for FOS-2 data: 0.028099
% Mean modified SSE for FOS-2 data: 0.344996
% 
% Mean time constant for FOS-3 data: 0.931920
% Standard deviation for time constants for FOS-3 data: 0.033193
% Mean modified SSE for FOS-3 data: 0.353819
% 
% Mean time constant for FOS-4 data: 1.102780
% Standard deviation for time constants for FOS-4 data: 0.030853
% Mean modified SSE for FOS-4 data: 0.349095
% 
% Mean time constant for FOS-5 data: 1.626990
% Standard deviation for time constants for FOS-5 data: 0.030849
% Mean modified SSE for FOS-5 data: 0.390191
% 
% SSE for the regression model for price vs time constant is: 1368.414909 ($^2)
% SST for the regression model for price vs time constant is: 7333.256567 ($^2)
% R-squared value for the regression model for price vs time constant is: 0.813396
% 
% runTime =
% 
%     1.3935
  
%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% I have not used source code obtained from any other unauthorized
% source, either modified or unmodified.  Neither have I provided
% access to my code to another. The project I am submitting
% is my own original work.