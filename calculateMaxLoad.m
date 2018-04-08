function [maxLoad, firstFail] = calculateMaxLoad(L, T, fitCoe, memberLengths)

    SR = T;
    SR(SR > 0) = 0;
    SR = abs(SR)';

    for i = 1:length(memberLengths)
        SR(i) = SR(i)./(fitCoe/(memberLengths(i)^2));
    end
    
    firstFail = find(SR == max(SR));
    
    maxLoad = abs(sum(L)) * (1 / SR(firstFail));
    
end