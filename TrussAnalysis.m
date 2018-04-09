% ----- Merrell & Gucci ----- %
clear
clc
fprintf('EK301, Section A3, Merrell & Gucci: Ben C, Jared L, Zoe R, 4/8/2018\n');

% ----- Load Truss Design Parameters ----- %

matFiles = dir('**/*.mat');

fprintf('Variable files found in current directory: \n');
for i = 1:length(matFiles)
    fprintf('%d: %s\n', i, matFiles(i).name);
end

fileIndex = input('Enter corresponding file number to load: ');
fileName = matFiles(fileIndex).name;

load(fileName)

% ----- Load Calculations ----- %

[numJoints, numMembers] = size(C);

[Ax, Ay] = detCoe(C,X,Y);

A = [Ax, Sx; Ay, Sy];

T = pinv(A) * L;

memberLengths = calculateLength(X,Y,C);

totalMemberLength = sum(memberLengths);

fitCoe = 1579.5; % N*cm^2

bucklingLoad = fitCoe ./ (memberLengths.^2)';

[maxLoad, firstFail] = calculateMaxLoad(L, T, fitCoe, memberLengths);

% ----- Compression / Tension Output ----- %

fprintf('Load: %.2f N\n', abs(sum(L)));
fprintf('Member forces in Newtons\n');
for i = 1:numMembers
    if (T(i) > 0)
        fprintf('m%d: %.3f (T)\n', i, abs(T(i)));
    elseif (T(i) < 0)
        fprintf('m%d: %.3f (C)\n', i, abs(T(i)));
    else
        fprintf('m%d: 0\n',i);
    end
end

% ----- Reaction Force Output ----- %

fprintf('Reactions forces in Newtons:\n');
fprintf('Sx1: %.2f\n', T(numMembers+1));
fprintf('Sy1: %.2f\n', T(numMembers+2));
fprintf('Sy2: %.2f\n', T(numMembers+3));

% ----- Truss Cost Calculation ----- %

jointCost = 10; % $10 USD / joint
jointTotalCost = jointCost * numJoints; 

memberCost = 1; % $1 USD / cm of member length
memberTotalCost = memberCost * totalMemberLength; 

totalCost = jointTotalCost + memberTotalCost;

fprintf('\nCost of truss: $%.2f\n', totalCost);

% ----- Theoretical Max Load/Cost Ratio ----- %

compressionMembers = abs(T(T < 0))';
fprintf('Max Load: %.2f N\n', maxLoad);
fprintf('Member %d fails first. \n', firstFail);
fprintf('Theoretical Max Load/Cost ratio in N/$: %.4f\n', maxLoad / totalCost);

% ----- Buckling Member ----- %
for i = 1:numMembers
    if (abs(T(i)) > maxLoad)
        fprintf('DISASTER m%d: %.3f (Buckles)\n', i, abs(T(i)));
    end
end
