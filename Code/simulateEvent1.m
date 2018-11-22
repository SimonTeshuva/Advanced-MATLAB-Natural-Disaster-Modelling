%% advanced matlab final project, simulateEvent1
 
% simon teshuva, 302207220
% last updated 17/6/2014
 
% this function simulates the results of a tornado
 
function [startRGBMap finishRGBMap endDamageArray] = simulateEvent1(entryPointY, entryPointX, strength, yDir, xDir, map)
 
% need to deal with roads (remove them!!)
 
% extraData contains health info, color code, id etc...
damageArray = zeros(101,101);
 
 
%% path
 
% calculate the final point for the domain. it will either be the first
% column or the last column depending on which direction the tornado is
% moving towards
xFin = (entryPointX - xDir) * strength  + entryPointX;
if xFin < 1
    xFin = 1;
else if xFin > 101
        xFin = 101;
    end
end
 
xVals = entryPointX:xFin;
xVals = round(xVals);
 
% calculate the path as a linear line based on the input
grad = (entryPointY - yDir)/(entryPointX - xDir);
if grad < 0
    grad = grad*-1;
end
 
c = entryPointY - grad*entryPointX;
 
yVals = grad*xVals + c;
yVals = round(yVals);
%% damage at each point (need to rework)
 
tempStrength = strength;
for i = 1:length(xVals)
    damageArray(yVals(i), xVals(i)) = tempStrength;
    tempStrength = tempStrength -1;
end
 
endDamageArray = damageArray;
 
%% call simulateEvenrt
[startRGBMap finishRGBMap] = simulateEvent(map, damageArray);
end
