%% advanced matlab final project, simulateEvent
 
% simon teshuva, 302207220
% last updated 17/6/2014
 
% this function is a generic simulation of any disaster. it is called by
% all other simulateEventX functions to do the main computations
 
function [finishStartRGBMap, finishFinalRGBMap] = simulateEvent(map, damageArray)
 
totalHealthArray = [0 45 30 45 60 30 45];
 
% update colors
% an array of rgb maps which can be used for the montage
% an array; 101 by 101 by 3 by length(path)
startRGBMap = map;
startRGBMap(:,:,2) = map;
startRGBMap(:,:,3) = map;
 
 
 
 
%% set initial values for rgb
 
% color scheme
% road = 0 0 0 - 0 0 0 - 0 0 0
% house = 100 100 255 - 75 75 190 - 40 40 100
% petrol station = 255 100 100 - 190 75 75 - 100 40 40
% shopping centre = 255 255 255 - 200 200 200 - 100 100 100
% university - 100 255 100 - 75 190 75 - 40 100 40
% park - 255 100 255 - 190 75 190 - 100 40 100
% supermarket - 255 255 100 - 190 190 75 - 100 100 40
 
% for each co-ordinate in the map, based off of its ID, color it in for its
% initial colors colors as seen in the table above
for xAxis = 1:length(map(:, 1))
    for yAxis = 1:length(map(1, :))
        if map(yAxis, xAxis) == 1
            startRGBMap(yAxis, xAxis, 1) = 0;
            startRGBMap(yAxis, xAxis, 2) = 0;
            startRGBMap(yAxis, xAxis, 3) = 0;
        else if map(yAxis, xAxis) == 2
                startRGBMap(yAxis, xAxis, 1) = 100;
                startRGBMap(yAxis, xAxis, 2) = 100;
                startRGBMap(yAxis, xAxis, 3) = 255;
            else if map(yAxis, xAxis) == 3
                    startRGBMap(yAxis, xAxis, 1) = 255;
                    startRGBMap(yAxis, xAxis, 2) = 100;
                    startRGBMap(yAxis, xAxis, 3) = 100;
                else if map(yAxis, xAxis) == 4
                        startRGBMap(yAxis, xAxis, 1) = 255;
                        startRGBMap(yAxis, xAxis, 2) = 255;
                        startRGBMap(yAxis, xAxis, 3) = 255;
                    else if map(yAxis, xAxis) == 5
                            startRGBMap(yAxis, xAxis, 1) = 100;
                            startRGBMap(yAxis, xAxis, 2) = 255;
                            startRGBMap(yAxis, xAxis, 3) = 100;
                        else if map(yAxis, xAxis) == 6
                                startRGBMap(yAxis, xAxis, 1) = 255;
                                startRGBMap(yAxis, xAxis, 2) = 100;
                                startRGBMap(yAxis, xAxis, 3) = 255;
                            else if map(yAxis, xAxis) == 7
                                    startRGBMap(yAxis, xAxis, 1) = 255;
                                    startRGBMap(yAxis, xAxis, 2) = 255;
                                    startRGBMap(yAxis, xAxis, 3) = 100;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
 
%% updating color
 
 
% the updated map
finalRGBMap = startRGBMap;
 
% for each co-ordinate in the map
for xAxis = 1:length(map(:, 1))
    for yAxis = 1:length(map(1, :))
              
        % based of the coordinates ID, damage taken and total health per
        % square
        status = damageArray(yAxis, xAxis);
        ID = map(yAxis,xAxis);
        totalHealth = totalHealthArray(ID);
        
        % if less than 15% of the building has been damaged, dont update
        % anything
        if status < 0.15*totalHealth
            
            % else if between 15 and 50 % of the building is damaged,
            % update the colors to "damaged" status
        else if status >= 0.15*totalHealth && status < 0.5*totalHealth
                if map(yAxis, xAxis) == 1
                    finalRGBMap(yAxis, xAxis, 1) = 0;
                    finalRGBMap(yAxis, xAxis, 2) = 0;
                    finalRGBMap(yAxis, xAxis, 3) = 0;
                else if map(yAxis, xAxis) == 2
                        finalRGBMap(yAxis, xAxis, 1) = 75;
                        finalRGBMap(yAxis, xAxis, 2) = 75;
                        finalRGBMap(yAxis, xAxis, 3) = 190;
                    else if map(yAxis, xAxis) == 3
                            finalRGBMap(yAxis, xAxis, 1) = 190;
                            finalRGBMap(yAxis, xAxis, 2) = 75;
                            finalRGBMap(yAxis, xAxis, 3) = 75;
                        else if map(yAxis, xAxis) == 4
                                finalRGBMap(yAxis, xAxis, 1) = 190;
                                finalRGBMap(yAxis, xAxis, 2) = 190;
                                finalRGBMap(yAxis, xAxis, 3) = 190;
                            else if map(yAxis, xAxis) == 5
                                    finalRGBMap(yAxis, xAxis, 1) = 75;
                                    finalRGBMap(yAxis, xAxis, 2) = 190;
                                    finalRGBMap(yAxis, xAxis, 3) = 75;
                                else if map(yAxis, xAxis) == 6
                                        finalRGBMap(yAxis, xAxis, 1) = 190;
                                        finalRGBMap(yAxis, xAxis, 2) = 75;
                                        finalRGBMap(yAxis, xAxis, 3) = 190;
                                    else if map(yAxis, xAxis) == 7
                                            finalRGBMap(yAxis, xAxis, 1) = 190;
                                            finalRGBMap(yAxis, xAxis, 2) = 190;
                                            finalRGBMap(yAxis, xAxis, 3) = 75;
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            % else if over 50 % of the building is damaged,
            % update the colors to "destroyed" status
            else if status > totalHealth * 0.5
                    if map(yAxis, xAxis) == 1
                        finalRGBMap(yAxis, xAxis, 1) = 0;
                        finalRGBMap(yAxis, xAxis, 2) = 0;
                        finalRGBMap(yAxis, xAxis, 3) = 0;
                    else if map(yAxis, xAxis) == 2
                            finalRGBMap(yAxis, xAxis, 1) = 40;
                            finalRGBMap(yAxis, xAxis, 2) = 40;
                            finalRGBMap(yAxis, xAxis, 3) = 100;
                        else if map(yAxis, xAxis) == 3
                                finalRGBMap(yAxis, xAxis, 1) = 100;
                                finalRGBMap(yAxis, xAxis, 2) = 40;
                                finalRGBMap(yAxis, xAxis, 3) = 40;
                            else if map(yAxis, xAxis) == 4
                                    finalRGBMap(yAxis, xAxis, 1) = 100;
                                    finalRGBMap(yAxis, xAxis, 2) = 100;
                                    finalRGBMap(yAxis, xAxis, 3) = 100;
                                else if map(yAxis, xAxis) == 5
                                        finalRGBMap(yAxis, xAxis, 1) = 40;
                                        finalRGBMap(yAxis, xAxis, 2) = 100;
                                        finalRGBMap(yAxis, xAxis, 3) = 40;
                                    else if map(yAxis, xAxis) == 6
                                            finalRGBMap(yAxis, xAxis, 1) = 100;
                                            finalRGBMap(yAxis, xAxis, 2) = 40;
                                            finalRGBMap(yAxis, xAxis, 3) = 100;
                                        else if map(yAxis, xAxis) == 7
                                                finalRGBMap(yAxis, xAxis, 1) = 100;
                                                finalRGBMap(yAxis, xAxis, 2) = 100;
                                                finalRGBMap(yAxis, xAxis, 3) = 40;
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
%% normalise values
 
% normalise the values of the start and finish map to be in the range from
% 0 to 1
finishStartRGBMap = startRGBMap/255;
finishFinalRGBMap = finalRGBMap/255;
 
end
