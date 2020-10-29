% Project 5 - Figuring out Functions

namesSm = ["CENTRAL OVER S&S CAN","WACKER-MICHIGAN-RAND","RYAN SB RMP TO 55WB","1.3-2.6 MI SW OF I94","MICH.AVE-S.OF RIVER", "North to West Ramp","RIVER TO CANAL ST","RAMP 'G'","RANDOLPH-MICHIGAN-FI","55 EB RMP TO SB RYAN","LARAMIE    K2 AVE BR", "CANAL-HARRISON-TAYLO", "CANAL-MADISON-ADAMS"];
yearBuiltSm = [1970,1926,1962,1963,1921,2015,1962,2006,1937,1964,1956,1926,1926];
yearReconstructSm = [2007,2002,1990,2000,1998,0,1989,0,1981,1997,1999,1983,1983];
scoreSm = [79,50,94.5,94,60.9,96,68,96,80.9,94.4,80.2,41.4,45.6];

% this main function call will execute main() and run all the code below.
main(namesSm, yearBuiltSm, yearReconstructSm, scoreSm);  

% This is your main function for Project 5.  
% Only copy and paste code below this line for testing in zyBooks.  
function main(names, yearBuilt, yearReconstruct, score)
close all;

% TODO 4 - Write this function using header comments above.
%Calls for cleanData function
disp("Before Clean:");
disp(yearReconstruct);
yearReconstruct = cleanData(yearReconstruct);
disp("After Clean:");
disp(yearReconstruct);

%Calls for findOldestBridge function
indOld = findOldestBridge(yearBuilt,yearReconstruct);
disp("Oldest Standing Bridge");
disp(names(indOld));

%calls for plotIt function
subplot(3,1,1); %plots year built graph
plotIt(yearBuilt, "Year Built", "rv", names, indOld);
subplot(3,1,2); %plots year reconstructed graph
plotIt(yearReconstruct, "Year Reconstructed", "bo", names, indOld);
subplot(3,1,3); %plots overall score graph
plotIt(score, "Overall Score", "g*", names, indOld);


end



% This function cleans that data.
% INPUTS:
%    dataIn - a 1D array of data, any size
% OUTPUTS:
%   dataOut - all data in dataIn that are zeros are set to NaN
%             and returned via dataOut
%   ct - stores the number of 0's in dataIn that are 
%        getting set to NaNs
function [dataOut, ct] = cleanData(dataIn)

% TODO 1 - write this function using header comments above.
%Sets all 0 values to NaN, then stores it in dataOut, and then calculates
%number of 0s made into NaN
    dataIn(dataIn == 0) = NaN; 
    dataOut = dataIn;
    ct = length(dataOut(isnan(dataOut)));
end



% This function finds the oldest bridge. You may not use any built in
% functions (except length and isnan) to write this function.
% INPUTS:
%    yearBuilt - an array of years that correspond with when 
%                each bridge was built
%    yearReconstruct - an array of years that correspond with when 
%                      each bridge was reconstructed (if a bridge 
%                      has never been reconstructed, its year will be NaN)
% OUTPUTS:
%    ind - the index location(s) of the oldest standing bridge. 
%          For example, if your data was: 
%            yearBuilt=[1930 1910 1890]; yearReconstruct=[1950 NaN 1980];
%          then ind = 2 -- the oldest standing bridge is the second bridge. 
%          since it was originally built in 1900 and never reconstructed 
%          and the other two bridges were reconstructed in 1950 and 1980.
%        
%          For example, if your data was: 
%            yearBuilt=[1940 1960 1910]; yearReconstruct=[1950 1970 1920];
%          then ind = 3 -- the oldest standing bridge is the third bridge.
%
%          For example, if your data was: 
%            yearBuilt=[1925 1930 1915]; yearReconstruct=[1930 NaN 1956];
%          then ind = [1, 2]; -- their is a tie for the oldest.
function [ind] = findOldestBridge(yearBuilt, yearReconstruct)

% TODO 2 - write this function using header comments above.
%Uses a while loop to build up an array of values of time standing for each
%bridge and then calculates the index of the max value
    i = 1;
    stand = [];
    while (i <= length(yearReconstruct))
        if (isnan(yearReconstruct(i)))
            stand = [stand, 2020 - yearBuilt(i)];
        else
            stand = [stand, 2020 - yearReconstruct(i)];
        end
        i = i + 1;
    end
    ind = find(stand == max(stand));
end



% This function should plot the data received as the first input. The plot
% should also label x axis as "Bridges", label the y axis using ystr, and
% customize the line using custom. 
% 
% If the data sent in has less than or equal to 15 bridges, it should 
% label the ticks with names and angle the x tick labels at -45 degrees.
%
% The linewidth should be increased to 2. 
%
% Lastly, this function will only create one plot and it will not 
% call figure, subplot, or anything else. 
% (those will need to be called outside of this function)
%
% INPUTS:
%    y - the data to plot on the y axis
%    ystr - the string to label the y axis
%    custom - the character array to customize the line
%    names - the array of strings to label the x ticks
%    indCircle - an array of integer indices that should be circled in
%                the plot. Increase the marker size, and set the 
%                marker to a red circle. Additonally, add a text 
%                annotation at each location that labels it as the
%                "Oldest Standing Bridge".
% OUTPUTS:
%    The function does not return anything, a plot is produced 
%    when this function is called.
function plotIt(y, ystr, custom, names, indCircle)

% TODO 3 - write this function using header comments above.  
%Defines x,y, labels, xticks, and then uses a conditional statement to see
%whether plot is for overall score (calculated by a max of 100) in which it
%assigns a marker face color, otherwise none.
    x = [1 : length(names)];
    xlabel("Bridges");
    if (max(y) <= 100)
        plot(x,y,custom, "LineWidth", 2, "MarkerFaceColor", "g");
    else
        plot(x,y,custom, "LineWidth", 2);
    end
    ylabel(ystr);
    xlabel("Bridges");
    %conditional statement to assign xticks only if length of name array is
    %15 or less
    if (length(names) <= 15)
       xticks(x);
       xticklabels(names);
       xtickangle(-45); 
    end
    hold on; %holds all 
    plot(x(indCircle),y(indCircle),"ro", "MarkerSize",15, "LineWidth", 2); %plots a red circle over the oldest bridge's point
    text(x(indCircle),y(indCircle), "Oldest Standing Bridge");  %puts text next to it
end
  
