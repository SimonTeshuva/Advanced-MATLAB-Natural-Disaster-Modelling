
%% advanced matlab final project, createGraph
 
% simon teshuva, 302207220
% last updated 17/6/2014
 
% this is a function that creates a graph based on where the
% disaster damages
 
function [damagedGraph damagedVector destroyedGraph destroyedVector]= createGraph(map, damageArray, buildingIDs, xStart, yStart)
%% intiialise values
totalHealthArray = [0 45 30 45 60 30 45];
dimensionArray = [0 3 3 15 23 11 7];
 
numberOfBuildings = 505;
damagePerBuilding = zeros(1, numberOfBuildings);
buildingTypeArray = zeros(1, numberOfBuildings);
 
startBuilding = buildingIDs(yStart, xStart);
 
% for each point in the map (but effectivley for each one of the 505
% buildings
for yAxis = 1:length(map(:,1))
    for xAxis = 1:length(map(1,:))
        % the building's type is determined from the value of 'map' at that
        % poit
        ID = buildingIDs(yAxis, xAxis);
        type = map(yAxis, xAxis);
        buildingTypeArray(ID) = type;
    end
end
 
%% calculate damage per bilding
 
% using the damageArray and buildingIDs, for each point, find which
% building we are looking at, how much damage has been done at that point
% and update the ammount of damage dealt to that building overall
for xAxis = 1:length(map(1,:))
    for yAxis = 1:length(map(:, 1))
        type = map(yAxis, xAxis);
        ID = buildingIDs(yAxis, xAxis);
        damage = damageArray(yAxis, xAxis);
        if type ~= 1
            damagePerBuilding(ID) = damagePerBuilding(ID) + damage;
        end
    end
end
 
 
 
%% add in nodes to graph
 
% two graphs will be created, one for buildings significantly damaged and
% one for those destroyed
buildingsInDamagedGraph = zeros(1, numberOfBuildings);
buildingsInDestroyedGraph = zeros(1, numberOfBuildings);
 
% for each building
for i = 1:numberOfBuildings
    type = buildingTypeArray(i);
    health = totalHealthArray(type)*dimensionArray(type)^2;
    DPB = damagePerBuilding(i);
    % if more than 15% of the building has been damaged it goes in to the
    % list of damaged buildings
    if DPB > health * 0.15
        buildingsInDamagedGraph(i) = 1;
        % if more than 50% of the building has been damaged it also goes in
        % to the list of destroyed buildings
        if DPB > health * 0.5
            buildingsInDestroyedGraph(i) = 1;
        end
    end
end
 
% creating vectors of all buildings that have been damaged or destroyed
% first need to know how large the vectors will be,
% trace trace through the arrays buildingsInDestroyedGraph and
% buildingsInDestroyedGraph and keep a counter of the number of 1s
numberDamaged = 0;
numberDestroyed = 0;
for i = 1:numberOfBuildings
    if buildingsInDestroyedGraph(i) == 1
        numberDamaged = numberDamaged + 1;
    end
    
    if buildingsInDestroyedGraph(i) == 1
        numberDestroyed = numberDestroyed + 1;
    end
    
end
 
% create the two vectors based on the counters calculated above
damagedVector = zeros(1, numberDamaged);
destroyedVector = zeros(1, numberDestroyed);
damagedCounter = 1;
destroyedCounter = 1;
 
% for each building, check if it has been damaged or destroyed, and if it
% has add it in to the appropriate vector. then update the counter for that
% vector, which indicates where to place the next piece of data
for i = 1:numberOfBuildings
    if buildingsInDamagedGraph(i) == 1 && startBuilding ~= i
        damagedVector(damagedCounter) = i;
        damagedCounter = damagedCounter + 1;
    end
 
    if buildingsInDestroyedGraph(i) == 1 && startBuilding ~= i
        destroyedVector(destroyedCounter) = i;
        destroyedCounter = destroyedCounter + 1;
    end
end
 
% the graphs will be represented as arrays of size
% #buildings damaged x #buildings damaged
% #buildings destroyed x #buildings destroyed
damaged = length(damagedVector);
destroyed = length(destroyedVector);
 
myDamagedGraph = zeros(damaged , damaged);
myDestroyedGraph = zeros(destroyed, destroyed);
 
% for each building other the first
 
% create an undirected
% edge joining the first building to the one being looked at
 
% do this for both damaged and destroyed buildings
for i = 2:damaged
    myDamagedGraph(1, i) = 1;
    myDamagedGraph(i, 1) = 1;
end
 
for i = 2:destroyed
    myDestroyedGraph(1, i) = 1;
    myDestroyedGraph(i, 1) = 1;
end
 
%% return graph
 
damagedGraph = myDamagedGraph;
destroyedGraph = myDestroyedGraph;
end
