%% advanced matlab final project, setEventData2
 
% simon teshuva, 302207220
% last updated 17/6/2014
 
% this function sets the relevant data for a tsunami
 
function [entryPointY entryPointX strength] = setEventData2()
%% set entry points
% these are determined by calculating the direction that the tornado enters
% the city from and then finding the point which approximates this best.
display('from which direction is the tsunami coming from?');
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
    display('from which direction is the tsunami coming from?');
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
 
%% entry point
 
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
    display('how strong is the tsunami?');
    display('pick a value from 1 to 100');
    strength= input('');
    
    while strength < 0 || strength > 100
    display('ivalid choice, try again. how strong is the tsunami?');
    display('pick a value from 1 to 100');
    strength= input('');
    end
    
   
 
end
