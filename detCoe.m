function coeMat = detCoe(C,coordVec)
    % Returns a coefficient matrix given a matrix C of joints and members
    % and a vector of points in coordVec.
    
    [Cr, Cc] = size(C);
    coeMat = zeros(Cr, Cc);
    
    for i = 1:Cr
        memberMatches = find(C(i,:) == 1);

        for j = 1:length(memberMatches)
            jointMatches(j,:) = find(C(:,memberMatches(j)) == 1);
        end

        [jR, ~] = size(jointMatches);

        for k = 1:jR
           dist = coordVec(jointMatches(k,2)) - coordVec(jointMatches(k,1));

           unit = dist / sqrt(coordVec(jointMatches(k,2))^2 + coordVec(jointMatches(k,1))^2);
           
           if (isnan(unit))
               unit = 0;
           end
           
           unitVectors(k) = unit;
        end

        coeVec = zeros(1,Cc);

        for g = 1:length(memberMatches)
            coeVec(memberMatches(g)) = unitVectors(g);
        end
        
        coeMat(i,:) = coeVec;
    end
end