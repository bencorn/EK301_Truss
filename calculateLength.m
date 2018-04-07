function l = calculateLength(X,Y,C)
     [~, nM] = size(C);
     l = zeros(1,nM);
     
     for i = 1:nM
         memMatch = find(C(:,i) == 1);
         memMatch = reshape(memMatch,1,2);
         l(i) = sqrt(((X(memMatch(1))-X(memMatch(2)))^2)+((Y(memMatch(1))-Y(memMatch(2)))^2));
     end
end