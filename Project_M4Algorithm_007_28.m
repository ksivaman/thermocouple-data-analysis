function [ts, tau, yh, yl] = Project_M4Algorithm_007_28(time, temp)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% This function calculates the start time of heating or cooling for a 
% given data set. It then calculates the lowest and highest temperatures
% before the change (heating or cooling) occurs and then finds the values. 
%
% Function Call
% [ts, tau, yh, yl] = Project_M4Algorithm_007_28(time, temp)
%
% Input Arguments
% time %vector of time for the time history data
% temp %vector of temperature for the time history data
%
% Output Arguments
% ts %Start time of heating or cooling
% tau %Time constant for data
% yh %High temperature for the change (Heating or cooling) 
% yl %Low temperature for the change (Heating or cooling)

% Assignment Information
%   Assignment:       	Milestone 4, Final project
%   Authors:            Kirthi Shankar Sivamani, ksivaman@purdue.edu
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
 
   length_data = length(temp); %calculating mumber of data points
   ts = 0; %Initializing start time of heating
   type = 1; %Initializing type of data (1 represents heating and 0 represents cooling)
%  ten_percent_length = length_data / 10 - rem(length_data / 10, 1); %Calculating 10% of total number of data points
%
%  REFINEMENT CATEGORY 1
%  In this refinement category, we improved the yl (low temperature) for
%  cooling and yh (high temperature) for heating. In our algorithm for
%  milestone 3, we calculated yl for cooling and yh for heating by taking
%  the mean of the last 10 percent of temperature data. By doing so, we got
%  values for standard deviation of time constant out of required range.
%  While analyzing how to improve the parameters, we created heating and
%  cooling plots (tempetaure vs time) for each FOS using the 100 time histories given to us in
%  the Milestone 3 document. In these plots, we saw that for FOS's 4 and 5,
%  the steady state wasn't reached until the last 4-5 percent of
%  temperature data. Thus, when we actually used the mean temperature for
%  the last 10% of data sets, we were taking temperature values well before
%  the attainment of steady state. Thus, we decided to take the mean value
%  of the last 2% of the data sets instead of the 10% so that we only
%  consider temperatures after it has become nearly constant. This
%  refinement has been shown in line 63 where 2% length of data is
%  calculated instead of the 10% data length in commented out line 43. 

   two_percent_length = length_data / 50 - rem(length_data / 50, 1); %Calculating 2% of total number of data points
%% ____________________
%% CALCULATIONS

   if temp(1) > temp(length_data) %Checking for cooling condition
       type = 0; %Setting type of data to represent cooling 
   end %ending if 

   mean_initial_temp = mean(temp(1:two_percent_length)); %calculating mean of temperature for the first 10 percent of data 

   if type == 1 %Checking for heating condition 
%      if mean_initial_temp > 0 %If initial mean initial temperature is positive
%          temp_limit = mean_initial_temp * 110 / 100; %Setting limit of temperature till up until which Ts will be calculated 
%      else  %If initial mean initial temperature is non-positive
%          temp_limit = mean_initial_temp * 90 / 100; %Setting limit of temperature till up until which Ts will be calculated
%      end %Ending if-else
%
%      REFINEMENT-CATEGORY 1
%      We have removed all temperature limit threshholds given in the
%      commented out lines of code (74-78). This improves the parameter
%      start time and thus aids us in getting better SSE mod values for
%      each FOS. This improves the parameter start time because when the
%      data is noisy, the varition in temperature even for a change in few
%      indices of time is very high. So when we took a 10% threshhold as
%      given in commented out lines 75 and 77, the value for time rose
%      drastically varying from the true value. 

       yh = mean(temp(length_data - two_percent_length:length_data)); %Setting high temperature for heating condition
       for index = 1:length_data %Checking entire data set for calculating Ts
%          for index2 = index:length_data %Checking if all temperature values from present index till the end are all either bigger (heating) or all smaller (cooling) than that in the present index
%              if temp(index2) < temp(index) %Checking if value at this particular index is smaller than value at original for loop index
%                  count = count + 1; %Incrementing count
%              end %Ending if
%          end %Ending for loop
%
%          REFINEMENT-CATEGORY 2
%          We have converted the above (commented out) for loop (lines 92-96) to a while
%          loop segment just below this comment section (line 116). In the for loop,
%          we were checking the entire length of the data for the variable
%          index2. This took up a lot of extra execution time since we just
%          need one point beyond a certain index to verify that that index
%          is not the one at which t = start time. However, with the for
%          loop we were counting the number of such points and proceeded
%          with the loop even if we found one such point. With the while
%          loop, we can use the variable count as the loop control variable
%          and break the loop as soon we get one point beyond which the
%          index2 has a greater temperature than at index of the for loop. We also tried
%          vectorizing the entire loop instead of converting it to a while
%          loop but that took even more time than the for loop and hence we
%          rejected that idea.

           count = 0; %Setting variable to count the number of values that do not match desired comparsion
           index2 = index; %Setting index for while loop contionals. This index runs from current for loop index till the end of data      
           while count == 0 && index2 <= length_data %Stopping calculations as soon as any temperature greater than that of index is found. If not, loop runs till end of data
               if temp(index2) < temp(index) %Checking if value at this particular index is greater than value at original for loop index
                    count = count + 1; %Incrementing count 
               end %Ending if
               index2 = index2 + 1; %Incrementing while loop index
           end %Ending while loop
           if count == 0 && temp(index) <= mean_initial_temp %Checking whether or not to change start time from previous value
               ts = time(index); %Setting Ts
               yl = temp(index); %Setting low temperature
           end %Ending if
       end %ending for loop
       temp_tau = yl + 0.632 * (yh - yl); %Calculating temperature at time tau for heating
       %REFINEMENT-CATEGORY 1: Improvement of time constant for heating
       %Description for this improvement is given on line 198. 
       tau = time(length_data - length(find(temp > temp_tau)) + 1) - ts; %Calculating tau
   else
       if mean_initial_temp > 0 %If initial mean initial temperature is positive
           if temp(1) == temp(2) %Testing for clean data               
               temp_limit = mean_initial_temp; %Setting limit of temperature till up until which Ts will be calculated for clean data
           else %Testing for noisy data
               temp_limit = mean_initial_temp * 100.4 / 100; %Setting limit of temperature till up until which Ts will be calculated for noisy data
           end %Ending if-else structure
       else %If initial mean initial temperature is non-positive
           temp_limit = mean_initial_temp * 99.6 / 100; %Setting limit of temperature till up until which Ts will be calculated
       end %Ending if-else
       yl = mean(temp(length_data - two_percent_length:length_data)); %Setting low temperature for cooling condition
       yh = mean(temp(1:two_percent_length)); %Setting high temperature for cooling condition
       for index = 1:length_data %Checking entire data set for calculating Ts
%          for index2 = index:length_data %Checking if all temperature values from present index till the end are all either bigger (heating) or all smaller (cooling) than that in the present index
%              if temp(index2) > temp(index) %Checking if value at this particular index is bigger than value at original for loop index
%                  count = count + 1; %Incrementing count 
%              end %Ending if
%          end %ending for loop
%
%          REFINEMENT-CATEGORY 2
%          We have converted the above (commented out) for loop (lines 144-148) to a while
%          loop segment just below this comment section (line 167). In the for loop,
%          we were checking the entire length of the data for the variable
%          index2. This took up a lot of extra execution time since we just
%          need one point beyond a certain index to verify that that index
%          is not the one at which t = start time. However, with the for
%          loop we were counting the number of such points and proceeded
%          with the loop even if we found one such point. With the while
%          loop, we can use the variable count as the loop control variable
%          and break the loop as soon we get one point beyond which the
%          index2 has a greater temperature than at index 1. We also tried
%          vectorizing the entire loop instead of converting it to a while
%          loop but that took even more time than the for loop and hence we
%          rejected that idea.
           count = 0; %Setting variable to count the number of values that do not match desired comparsion
           index2 = index; %Setting index for while loop contionals. This index runs from current for loop index till the end of data      
           while count == 0 && index2 <= length_data %Stopping calculations as soon as any temperature greater than that of index is found. If not, loop runs till end of data
               if temp(index2) > temp(index) %Checking if value at this particular index is smaller than value at original for loop index
                    count = count + 1; %Incrementing count 
               end %Ending if
               index2 = index2 + 1; %Incrementing while loop index
           end %Ending while loop
           if count == 0 && temp(index) >= temp_limit %Checking whether or not to change start time from previous value
               ts = time(index); %Setting Ts
           end %Ending if
       end %ending for loop
       temp_tau = yh - 0.632 * (yh - yl); %Calculating temperature at time tau for cooling
       %REFINEMENT-CATEGORY 1: Improvement of time constant for cooling
       %Description for this improvement is given on line 198.
       tau = time(length_data - length(find(temp < temp_tau)) + 1) - ts; %Calculating tau
   end %ending outer if-else
   
%   difference_temp = abs(temp(1) - temp_tau); %Calculating difference in temperature of the value at specific index vs that of required temperature
%   for index = 1:length_data %Checking entire data set
%       if abs(temp(index) - temp_tau) < difference_temp %Conditional change in value of tau
%           difference_temp = abs(temp(index) - temp_tau); %Reassigning difference of temperature variable to new smaller difference
%           tau = time(index) - ts; %Calculating tau
%       end %Ending if statement
%   end %Ending for loop
%
%  REFINEMENT-CATEGORY 2
%  We change the above segment of code and eliminated the for loop from the
%  calculation of tau. We instead used vector manipulation techniques to
%  remove unnecessary repetition structures. This improved our execution
%  time by 4 to 5 seconds due to no repetition and just working with one
%  vector. 
%          
%  REFINEMENT-CATEGORY 1
%  The above refinement for calculating tau (time constant) also serves as 
%  a parameter improvement method. We changed our method of calculating tau 
%  that resulted in much more accurate mean and standard deviation values
%  for time constant for each FOS. Earlier (in M3), we calculated the temperature at tau using
%  the formula mentioned in page 3 of the Milestone 1 project introduction
%  pdf. We then calculated the difference of the temperature at each index of 
%  temperature vector to that of temperature at tau. We took the index at which this
%  difference was minimum. Tau was then equal to temperature at this index
%  minus start time. In our new method for identification of time constant,
%  the first step is the same in which we calculate temperature at tau
%  using the same formula from the M1 document mentioned above. We then find the number
%  of points in the data set which have a temperature greater than
%  temperature at tau (for heating) or less than temperature at tau (for
%  cooling). We find this number using the length and find functions. We
%  then subtract this number from the number of data points to get the
%  index of time at which temperature has reached 63.2% of its final
%  constant value. We then subtract the start time from the time at
%  this index to get time constant. These refinements have been shown in
%  the above sections of code on line 130 for heating and line 180 for
%  cooling. Our method for calculating tau for Milestone 4 is better than
%  that of Milestone 3 because our Milestone 3 algorithm for tau was not
%  robust enough to noise. For many data, the difference we were looking to
%  minimize was found in an outlying index value for which temperature was
%  extremely close to temperature at tau. This resulted in incorrect
%  values for tau and thus increased the standard deviation. 

end %Ending function

%% ____________________
%% FORMATTED TEXT & FIGURE DISPLAYS

%% ____________________
%% COMMAND WINDOW OUTPUT

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% I have not used source code obtained from any other unauthorized
% source, either modified or unmodified.  Neither have I provided
% access to my code to another. The project I am submitting
% is my own original work.