function [maxLoad, firstFail, u] = calculateMaxLoad(L, T, fitCoe, memberLengths)

    SR = T;
    SR(SR > 0) = 0;
    SR = abs(SR)';
    numMembers = length(memberLengths);
    eulerUncertainty = 817.4265;

    for i = 1:length(memberLengths)
        SR(i) = SR(i)./(fitCoe/(memberLengths(i)^2));
    end
    
    firstFail = find(SR == max(SR));
    
    maxLoad = abs(sum(L)) * (1 / SR(firstFail));
    
    u = zeros(1, numMembers);
    for i = 1:numMembers
        u(i) = eulerUncertainty / (memberLengths(i)^3);
    end
    
end