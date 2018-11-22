%% advanced matlab final project, simulateEvent3
 
% simon teshuva, 302207220
% last updated 17/6/2014
 
% this function simulates the results of a earthquake
 
function [startRGBMap finishRGBMap endDamageArray] = simulateEvent3(originY, originX, strength, map)
 
% extraData contains health info, color code, id etc...
damageArray = zeros(101,101);
strength = strength * 1.75;
 
%% damage done at each square
 
% the damage to each square = strength - distance from start
 
for axisY = 1:101
    for axisX = 1:101
        xDis = (axisX - originX)^2;
        yDis = (axisY - originY)^2;
        dist = sqrt(xDis + yDis);
        if dist == 0
            damage = strength;
        else
            damage = strength - dist;
        end
 
        % if the distance is larger than the strength, no damage was done,
        % instead of letting it go into negatives set it to 0
 
        if damage < 0
            damage = 0;
        end
        damageArray(axisY,axisX) = damage;
        
    end
end
    
%% call simulateEvent
    
endDamageArray = damageArray;
 
[startRGBMap finishRGBMap] = simulateEvent(map, damageArray);
end

