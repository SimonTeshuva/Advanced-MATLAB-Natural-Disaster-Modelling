%% advanced matlab final project, graphs
 
% simon teshuva, 302207220
% last updated 17/6/2014
 
% this is a function that takes as input an array of buildings and creates
% and returns a graph and list of names using simbiology.
 
function [outputGraph outputNames] = graphs(damagedGraph, damagedVector, destroyedGraph, destroyedVector)
 
 
display('which graph would you like to see?');
display('1: buildingds that were damaged significantly');
display('2: buildingds that were completly destroyed');
display('0: none');
choice = input('');
choice = round(choice);
 
while choice <0 || choice > 2
    display('invalid choice, try again');
    display('which graph would you like to see?');
    display('1: buildingds that were damaged significantly');
    display('2: buildingds that were completly destroyed');
    display('0: none');
    choice = input('');
    choice = round(choice);
end
 
 
 
if choice == 1
    finalGraph = biograph(damagedGraph);
    view(finalGraph);
    outputNames = damagedVector;
else if choice == 2
        finalGraph = biograph(destroyedGraph);
        view(finalGraph);
        outputNames = destroyedVector;
    end
end
 
 
 
outputGraph = finalGraph;
end

%% advanced matlab final project, calculateDamages
 
% simon teshuva, 302207220
% last updated 17/6/2014
 
% this is a function that calculates the total damage done by a disaster
 
function totalCost = calculateDamages(map, buildingIDs, damageArray)
%% intialise variables
totalHealthArray = [0 45 30 45 60 30 45];
totalCostArray = [0 300000 400000 25000000 300000000 750000 2000000];
dimensionArray = [0 3 3 15 23 11 7];
 
numberOfBuildings = 505;
 
%% iterativly calculate cost of damage to each building add sum it
 
tempCost = 0;
% for each building
for counter = 1:numberOfBuildings
    % re-initialise variables
    thisCost = 0;
    found = false;
    y = 1;
    x = 1;
    
    % for find top – left most point of the building
    for counterY = 1:length(buildingIDs(1,:))
        for counterX = 1:length(buildingIDs(:,1))
            if buildingIDs(counterY, counterX) == counter && found == false
                found = true;
                x = counterX;
                y = counterY;
            end
        end
    end
    
    % find data about the building
    type = map(y,x);
    size = dimensionArray(type);
    buildingCost = totalCostArray(type);
 
    % the total damgage a building can take
    buildingHealth = size*size*totalHealthArray(type);
 
    % calculate the damade done to that building
    thisRealDamage = calculateCost(type, y, x, damageArray);
    
    
    % if less than 15% of the building has been damaged (mostly fine)
    if thisRealDamage < 0.15*buildingHealth
        thisCost = thisRealDamage * buildingCost * 0.33;
        % if between 15 and 50 % of th ebuilding has been damaged (damged)
    else if thisRealDamage >= 0.15*buildingHealth && thisRealDamage < 0.5*buildingHealth
            thisCost = thisRealDamage * buildingCost * 0.66;
            % if more than 50% of the building has been damaged (destroyed)
        else if thisRealDamage >= 0.5*buildingHealth
                thisCost = thisRealDamage * buildingCost;
            end
        end
    end
 
    % bring the cost in to sensible regions
    thisCost = thisCost / 10;
    
    % if the total cost of the
    % damage done to a building is greater than the value of
    % the building, make it equal to the actual cost of the building
    if thisCost > buildingCost
        thisCost = buildingCost;
    end
    
    % update the total cost of the damage
    tempCost = tempCost + thisCost;
    
end
 
% return the total cost
totalCost = tempCost;
end

%% advanced matlab final project, createGraph
 
% simon teshuva, 302207220
% last updated 17/6/2014
 
% this is a function that calculates the total damage done by a disaster to
% one particular building
 
function thisRealDamage = calculateCost(type, y, x, damageArray)
%% initialise variables
 
% the dimensions for each building type
dimensionArray = [0 3 3 15 23 11 7];
% the ammound of damage each square of a given building can take
totalHealthArray = [0 45 30 45 60 30 45];
% the layout for the above two vectors is
% array = [road house petrolStation shoppingCenter university park
% supermarket]
 
size = dimensionArray(type);
healthPerSquare = totalHealthArray(type);
 
%% calculate damage to the building
 
% the building extends from the top left most corner an equal ammount in
% either direction, the ammount is based off of the building type
 
totalDamage = 0;
% for each point in the building keep a running sum of the damage to that
% building
for xAxis = 0:(size-1)
    for yAxis = 0:(size-1)
            tempDamage = damageArray(y + yAxis, x + xAxis);
            if tempDamage > healthPerSquare
                tempDamage = healthPerSquare;
            end
            totalDamage = totalDamage + tempDamage;
    end
end
 
%% bound it by max building health
% if the total damage done to the building is greater than the total damage
% that it can sustain, set total damage done to total max damage possible
buildingHealth = size*size*healthPerSquare;
if totalDamage > buildingHealth
    thisRealDamage = buildingHealth;
else
    thisRealDamage = totalDamage;
end
 
end

%% advanced matlab final project, findNearestDamagedBuilding
 
% simon teshuva, 302207220
% last updated 17/6/2014
 
% this is a function that takes one damaged building and finds the nearest
% damaged building
 
function nearest = findNearestDamagedBuilding(building, map, damageArray, buildingIDs, damageType)
%% initialise variables
    
totalHealthArray = [0 45 30 45 60 30 45];
dimensionArray = [0 3 3 15 23 11 7];
    
counterX = 1;
counterY = 1;
found = false;
yPoint = 1;
xPoint = 1;
 
%% find our building and relevant data about it
 
% trace trough the map until the top - left most point of our building has
% been found. save its co-ordinates
while counterX < length(buildingIDs(1,:)) && found == false
    while counterY < length(buildingIDs(:,1)) && found == false
        if buildingIDs(counterY,counterX) == building
            found = true;
            yPoint = counterY;
            xPoint = counterX;
        end
        counterX = counterX+1;
        counterY = counterY+1;
    end
end
 
% find the middle of the building
 
buildingType = map(yPoint, xPoint);
 
% based on the building's type, toAdd = (building size + 1)/2
toAdd = 0;
if buildingType == 2
    toAdd = 1;
else if buildingType == 3
        toAdd = 1;
    else if buildingType == 4
            toAdd = 7;
        else if buildingType == 5
                toAdd = 11;
            else if buildingType == 6
                    toAdd = 5;
                else if buildingType == 7
                        toAdd = 3;
                    end
                end
            end
        end
    end
end
 
% by adding toAdd to the xPoint and yPoint we find the middle of the
% building
xPoint = xPoint + toAdd;
yPoint = yPoint + toAdd;
 
 
%% find nearest building and return
dist = 10000000;
ID = 10000;
 
% for each point in the map
for counterX = 1:length(buildingIDs(1,:))
    for counterY = 1:length(buildingIDs(:,1))
        % find relevant data about that point
        currentDamage = damageArray(counterY, counterX);
        currentType = map(counterY, counterX);
        
        % calculate the distance from our initial building and find the ID
        % of the building we are currently looking at
        currentDist = sqrt((counterX - xPoint)^2 + (counterY - yPoint)^2);
        currentID = buildingIDs(counterY, counterX);
        
        % if the building being looked at is not a road, and has been
        % damaged, and is not our initial building, examine it further
        if currentType ~= 1 && currentDamage > 0 && currentID ~= building
            % if it is closer to our building than the previous closest
            % building
            if currentDist < dist
                % if we are looking for damaged or destroyed buildings and
                % if more than 15% of the building has been damaged
                if damageType == 1 && currentDamage > 0.15 * totalHealthArray(currentType)
                % store the distance from this building and the building's
                % ID
                dist = currentDist;
                ID = currentID;
                % else if we are only looking for buildings that have beeen
                % destroyed, and more than 50% of the building has been
                % damaged
                else if damageType == 2 && currentDamage > 0.5 * totalHealthArray(currentType)
                % store the distance from this building the the building's
                % ID
                dist = currentDist;
                ID = currentID;
                    end
                end
                
            end
        end
    end
end
 
% return the closest building's ID
nearest = ID;
 
end

