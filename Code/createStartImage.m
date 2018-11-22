%% advanced matlab final project, shownImage
 
% simon teshuva, 302207220
% last updated 17/6/2014
 
% creates a map of the city to show to the user. it is called by the main
% file at the very beginning and is in the form of a function in order to
% save space
 
function shownImage = createStartImage(map)
 
% create an array of size 3x101x101 for the rgb componenets of the map
myMap = map;
myMap(:,:,2) = map;
myMap(:,:,3) = map;
 
 
 
%% set initial values for rgb
 
% color scheme
% road = 0 0 0 - 0 0 0 - 0 0 0
% house = 100 100 255 - 75 75 190 - 40 40 100
% petrol station = 255 100 100 - 190 75 75 - 100 40 40
% shopping centre = 255 255 255 - 200 200 200 - 100 100 100
% university - 100 255 100 - 75 190 75 - 40 100 40
% park - 255 100 255 - 190 75 190 - 100 40 100
% supermarket - 255 255 100 - 190 190 75 - 100 100 40
 
% for each point in the map, based on the building type, color that point
% based on the color scheme above
for xAxis = 1:length(map(:, 1))
    for yAxis = 1:length(map(1, :))
        if map(yAxis, xAxis) == 1
            myMap(yAxis, xAxis, 1) = 0;
            myMap(yAxis, xAxis, 2) = 0;
            myMap(yAxis, xAxis, 3) = 0;
        else if map(yAxis, xAxis) == 2
                myMap(yAxis, xAxis, 1) = 100;
                myMap(yAxis, xAxis, 2) = 100;
                myMap(yAxis, xAxis, 3) = 255;
            else if map(yAxis, xAxis) == 3
                    myMap(yAxis, xAxis, 1) = 255;
                    myMap(yAxis, xAxis, 2) = 100;
                    myMap(yAxis, xAxis, 3) = 100;
                else if map(yAxis, xAxis) == 4
                        myMap(yAxis, xAxis, 1) = 255;
                        myMap(yAxis, xAxis, 2) = 255;
                        myMap(yAxis, xAxis, 3) = 255;
                    else if map(yAxis, xAxis) == 5
                            myMap(yAxis, xAxis, 1) = 100;
                            myMap(yAxis, xAxis, 2) = 255;
                            myMap(yAxis, xAxis, 3) = 100;
                        else if map(yAxis, xAxis) == 6
                                myMap(yAxis, xAxis, 1) = 255;
                                myMap(yAxis, xAxis, 2) = 100;
                                myMap(yAxis, xAxis, 3) = 255;
                            else if map(yAxis, xAxis) == 7
                                    myMap(yAxis, xAxis, 1) = 255;
                                    myMap(yAxis, xAxis, 2) = 255;
                                    myMap(yAxis, xAxis, 3) = 100;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
% normalise and returnt the map
shownImage = myMap/255;
end
