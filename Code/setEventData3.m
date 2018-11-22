%% advanced matlab final project, setEventData3
 
% simon teshuva, 302207220
% last updated 17/6/2014
 
% this function sets the relevant data for a earthquake
 
function [entryPointY entryPointX strength] = setEventData3()
%% set origin points
% these are determined by calculating the direction that the tornado enters
% the city from and then finding the point which approximates this best
    display('where does the earthquake start from?');
    display('set this by choosing a point in the map to be the origin');
    display('choose a number from 1 to 101 for both the x and y co-ordinates');
    
    entryPointX = input('choose x value');
    while entryPointX < 1 || entryPointX > 101
        display('invalid choice for x, try again');
        entryPointX = input('pick a value from 1 to 101');
    end
    
    entryPointY = input('choose y value');
    while entryPointY < 1 || entryPointY > 101
        display('invalid choice for y, try again');
        entryPointY = input('pick a value from 1 to 101');
    end
    
    entryPointX = round(entryPointX);
    entryPointY = round(entryPointY);
 
%% set strength
    display('how strong is the earthquake?');
    display('pick a value from 1 to 100');
    strength= input('');
    
    while strength < 0 || strength > 100
    display('how strong is the earthquake?');
    display('pick a value from 1 to 100');
    strength= input('');
    end
end