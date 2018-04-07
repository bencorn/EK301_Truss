% Connection Matrix (Joints, Members)
C = [
        1 1 0 0 0 0 0;
        1 0 1 0 1 1 0;
        0 1 1 1 0 0 0;
        0 0 0 1 1 0 1;
        0 0 0 0 0 1 1;
];

% Connection Matrix (Reactions, Sx)
Sx = [
        1 0 0;
        0 0 0;
        0 0 0;
        0 0 0;
        0 0 0;
];

% Connection Matrix (Reactions, Sy)
Sy = [ 
        0 1 0;
        0 0 0;
        0 0 0;
        0 0 0;
        0 0 1;
];

% Location Vector (X)
X = [0,2,1,3,4];

% Location Vector (Y)
Y = [0,0,-2,-3,0];

% Applied Loads
L = [0 0 0 0 0 0 0 0 300 0];


save EK301_Vars.mat