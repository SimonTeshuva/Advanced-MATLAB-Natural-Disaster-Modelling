%% advanced matlab final project, setEventData1
 
% simon teshuva, 302207220
% last updated 17/6/2014
 
% this function sets the relevant data for a tornado
 
function [entryPointY entryPointX strength yDir xDir] = setEventData1()
%% set angle
% in this model, a tornado comes in from one of 8 directins, inputed from
% user
 
display('from which direction is the tornado coming from?');
display('1: north');
display('2: north-east');
display('3: east');
display('4: south-east');
display('5: south');
display('6: south-west');
display('7: west');
display('8: north-west');
choice = input('');
choice = round(choice);
 
while choice < 1 || choice > 8
    display('invalid choice, try again');
    display('from which direction is the tornado coming from?');
    display('1: north');
    display('2: north-east');
    display('3: east');
    display('4: south-east');
    display('5: south');
    display('6: south-west');
    display('7: west');
    display('8: north-west');
    choice = input('');
    choice = round(choice);
end
 
 
%% set entry points
 
% using the user's choice, assing the starting location for the tornado
 
if choice == 1
    entryPointX = 51;
    entryPointY = 1;
else if choice == 2
        entryPointX = 101;
        entryPointY = 1;
    else if choice == 3
            entryPointX = 101;
            entryPointY = 51;
        else if choice == 4
                entryPointX = 101;
                entryPointY = 101;
            else if choice == 5
                    entryPointX = 51;
                    entryPointY = 101;
                else if choice == 6
                        entryPointX = 1;
                        entryPointY = 101;
                    else if choice == 7
                        entryPointX = 1;
                        entryPointY = 51;
                        else if choice == 8
                                entryPointX = 1;
                                entryPointY = 1;
                            end
                        end
                    end
                end
            end
        end
    end
end
 
            
 
    
%% set strength
    display('how strong is the tornado?');
    display('pick a value from 1 to 100');
    strength = input('');
    
    while strength < 0 || strength > 100
    display('how strong is the tornado?');
    display('pick a value from 1 to 100');
    strength= input('');
    end
    
%% set path
% calculate which direction the tornado is moving in. pick a point for the tornado to move towards
% create a line from start in the direction that the tornado moves. re-set
% the point that the tornado moves towards as the last point in the map
% that the tornado passes through
 
    display('in what direction will the tornado move');
    display('set this by choosing a point in the map for the tornado to move towards');
    display('choose a number from 1 to 100 for both the x and y co-ordinates');
    xPoint = input('choose x value');
    xPoint = round(xPoint);
    while xPoint < 1 || xPoint > 100
        display('invalid choice for x, try again');
        xPoint = input('pick a value from 1 to 100');
    end
    xPoint = round(xPoint);
    
    yPoint = input('choose y value');
    
    while yPoint < 1 || yPoint > 100
        display('invalid choice for y, try again');
        yPoint = input('pick a value from 1 to 100');
    end
    yPoint = round(yPoint);
 
    % order the points in acending order
    if entryPointX > xPoint
        x = xPoint:entryPointX;
    else
        x = entryPointX:xPoint;
    end
    
    % calculate the path as a linear line
    grad = (entryPointY - yPoint)/(entryPointX - xPoint);
    c = entryPointY - grad*entryPointX;
    y = grad * x + c;
    xDir = x(end-1);
    yDir = round(y(end-1));
    
 
end
