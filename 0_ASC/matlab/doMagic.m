function [B,C] = doMagic(A)

    if nargin == 0
        A = [1 2 3];

    C = A + 7;
    

    B = A / 2;
    
end