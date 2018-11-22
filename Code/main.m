%% advanced matlab final project , main
 
% simon teshuva, 302207220
% last updated 17/6/2014
 
% this project attempts to model the effects of natural disasters hitting a
% city. it models tornados, tsunamis and earthquakes.
 
% this is the main m file. from it the type of disaster is chosen. after
% that the relevatnt function is called to determine additional information
% about the properties of the disaster such as its path, starting location
% and strength. a rgb image of the city before and after the disaster is
% created and are then montaged together. the total financial damgade done
% by the disaster is also calculated.
 
% each building has a color code. as the building gets more damaged it gets
% progressiely darker.
%                    fine            damaged                 destroyed
% road              0 0 0              0 0 0                  0 0 0
% house            100 100 255       75 75 190              40 40 100
% petrol station  255 100 100       190 75 75              100 40 40
% shopping centre 255 255 255      200 200 200            100 100 100
% university       100 255 100     75 190 75                 40 100 40

% park            255 100 255       190 75 190               100 40 100
% supermarket     255 255 100        190 190 75              100 100 40
 
clear all;
clc;
 
%% initialising all variables
 
 
map = load('mapGrid.txt');
buildingIDs = load('mapIDsModded.txt');
 
% create an image to display to user
% dimensions of image = sizeShownImage * sizeShownImage
sizeShownImage = 101;
% call the method to create the image
shownImage = createStartImage(map);
% resize the image by a factor of 3
shownImage= imresize(shownImage, [sizeShownImage*3 sizeShownImage*3]);
% display to user
imshow(shownImage);
 
 
% information for user
display('color code for buildings;');
display('black : road');
display('blue : house');
display('orange : petrol station');
display('white : shopping center');
display('green : university');
display('pink : park');
display('yellow : supermarket');
 
 
 
%% re-assign IDs to sensible values
 
% many of the buildings have IDs that are outside of the range of 1 - 505;
% this set of loops and ifs bring all builings to inside that range to
% allow for easier computation
for xAxis = 1:length(buildingIDs)
    for yAxis = 1:length(buildingIDs)
        % roads = 999 -- > 1
        if buildingIDs(yAxis, xAxis) == 999
            buildingIDs(yAxis, xAxis) = 1;
            % IDs ranging from 602 - 698 go to 2 - 98
        else if buildingIDs(yAxis, xAxis) > 600
                buildingIDs(yAxis, xAxis) = buildingIDs(yAxis, xAxis) - 600;
                % miscelaneous buildings to be adjested for the next 4
            else if buildingIDs(yAxis, xAxis) == 509
                    buildingIDs(yAxis, xAxis) = 200;
                else if buildingIDs(yAxis, xAxis) == 508
                        buildingIDs(yAxis, xAxis) = 328;
                    else if buildingIDs(yAxis, xAxis) == 507
                            buildingIDs(yAxis, xAxis) = 329;
                        else if buildingIDs(yAxis, xAxis) == 506
                                buildingIDs(yAxis, xAxis) = 330;
                            end
                        end
                    end
                end
            end
            
        end
    end
end
 
% a menu system for choosing what type of disaster
display('welcome to the main');
display('what type of event to you want to model?');
display('0: quit');
display('1: tornado');
display('2: tsunami');
display('3: earthquake');
choice = input('');
choice = round(choice);
 
while choice <0 || choice > 3
    display('invalid choice, try again');
    display('0: quit');
    display('1: tornado');
    display('2: tsunami');
    display('3: earthquake');
    choice = input('');
    choice = round(choice);
end
 
% if not quitting, do the main part of the algorithm
if choice ~= 0
    
    % call the appropriate setEvenData and simulateEvent functions
if choice == 1
    [entryPointY entryPointX strength yDir xDir] = setEventData1();
    [startRGBMap finishRGBMap damageArray] = simulateEvent1(entryPointY, entryPointX, strength, yDir, xDir, map);
else if choice == 2
        [entryPointY entryPointX strength] = setEventData2();
        [startRGBMap finishRGBMap damageArray] = simulateEvent2(entryPointY, entryPointX, strength, map);
    else if choice == 3
            [entryPointY entryPointX strength] = setEventData3();
            [startRGBMap finishRGBMap damageArray] = simulateEvent3(entryPointY, entryPointX, strength, map);
        end
    end
end
 
% calculate the total finacial cost from the disaster
totalCost = calculateDamages(map, buildingIDs, damageArray);
 
 
% use the image processing toolbox to save the initial and final maps to
% computer, then scale them up by a factor of 5 and save to computer again.
% once this is done, montage the two images together to show the difference
 
size = 101;
 
startImage = startRGBMap;
finishImage = finishRGBMap;
 
imwrite(startImage, 'start.jpg');
imwrite(finishImage, 'finish.jpg');
 
start = imread('start.jpg');
finish = imread('finish.jpg');
 
% may need a 3rd dimension
scaledStart = imresize(start, [5*size 5*size]);
scaledFinish = imresize(finish, [5*size 5*size]);
 
imwrite(scaledStart, 'scaledStart.jpg');
imwrite(scaledFinish, 'scaledFinish.jpg');
 
finalStart = imread('scaledStart.jpg');
finalFinish = imread('scaledFinish.jpg');
 
% may be wrong
montage([finalStart finalFinish]);
display('the total damage caused in dollars was ');
display(totalCost);
 
% create a graph and then a tree out of our data
[damagedGraph damagedVector destroyedGraph destroyedVector] = createGraph(map, damageArray, buildingIDs, entryPointX, entryPointY);
[examinedGraph names] = graphs(damagedGraph, damagedVector, destroyedGraph, destroyedVector);
display('the IDs of the nodes in the graph are');
for i = 1:length(names)
    node = int2str(i);
    ID = int2str(names(i));
    display(strcat(node, ' = ', ID));
end
 
end