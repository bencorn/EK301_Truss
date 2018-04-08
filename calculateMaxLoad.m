function maxLoad = calculateMaxLoad(L, T, fitCoe, memberLengths)

    T2 = T;
    T2(T2 > 0) = 0;
    T2 = abs(T2)';

    for i = 1:length(memberLengths)
        T2(i) = T2(i)./(fitCoe/(memberLengths(i)^2));
    end
    
    maxLoad = abs(sum(L)) * (1 / max(T2));
    
end