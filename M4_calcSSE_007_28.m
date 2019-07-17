function [mean_mod_SSE] = M4_calcSSE_007_28(parameters, time, data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% This function takes a data set of parameters as an input, calculates SSE
% for each of them and then return the mean modified SSE to the calling
% function. 
%
% Function Call
% [SSE] = M4_calcSSE_007_28(parameters, time, data)
%
% Input Arguments
% data %The data set for which we need to calculate modified SSE. 
% time %The common time vector from 0 to 10 for the time history data
% parameters %The 4 first order parameter calculated using Algorithm for
%             M4 for each data set.
%
% Output Arguments
% mean_mod_SSE %The calculated mean modified SSE for the data set provided.  
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
 
   mean_mod_SSE = 0; %Initializing the mean modified SSE to zero. 
   [row_data, col_data] = size(parameters); %Initializing size of the data matrix
   num_points = length(time); %Number of temperature values within the time range vector
   
%% ____________________
%% FORMATTED TEXT & FIGURE DISPLAYS

%% ____________________
%% CALCULATIONS
   
   for num = 1:row_data %Checking for each parameter set in the given FOS
       
       index = 1; %Assigning index
       if data(1,num) > data(num_points,num) %for cooling condition
           for time_index = (time)' %Checking the entire data set for time
               if (time_index < parameters(num,1)) %Condition before start of cooling
                   calibration_temp(index) = parameters(num,3); %Setting temperature as high temperature
                   index = index + 1; %Incrementing index
               else %After cooling starts
                   calibration_temp(index) = parameters(num,4) + (parameters(num,3) - parameters(num,4)) * (exp((parameters(num,1) - time_index) / parameters(num,2))); %Setting temperature vaue according to model equation
                   index = index + 1; %Incrementing index
               end %Ending if else
           end %Ending for loop       
       else %for heating condition
           for time_index = (time)' %Checking the entire data set for time
               if (time_index < parameters(num,1)) %Condition before start of cooling
                   calibration_temp(index) = parameters(num,4); %Setting temperature as high temperature
                   index = index + 1; %Incrementing index
               else %After heating starts
                   calibration_temp(index) = parameters(num,4) + (parameters(num,3) - parameters(num,4)) * (1 - exp((parameters(num,1) - time_index) / parameters(num,2))); %Setting temperature vaue according to model equation
                   index = index + 1; %Incrementing index
               end %Ending if else
           end %Ending for loop
       end %Ending if-else
       
       SSE = mean(((data(:,num))' - calibration_temp) .^ 2); %SSE mod for data of this particular iteration. 
       mean_mod_SSE = (SSE + mean_mod_SSE * (num - 1)) / num; %Updating the mean modified SSE
       
   end %Ending for loop
   
end %ending function
%% ____________________
%% COMMAND WINDOW OUTPUT

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% I have not used source code obtained from any other unauthorized
% source, either modified or unmodified.  Neither have I provided
% access to my code to another. The project I am submitting
% is my own original work.