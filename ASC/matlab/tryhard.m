% could also be oneliner, but for readabilitie's sake
function tryhard(A, a, b, h)

    if nargin == 3
        h = 0.01;
    end
    
    tic
    
    % "to the power" vector
    p1 = size(A,2) : -1 : 1;
    
    % needed to transform Y
    p2 = ones(size(A))';
    
    % x values
    Y1 = (a : h : b) .* p2;
    
    % "power" every value
    Y2 = Y1' .^ p1;
    
    % mulitply every value with input vector
    Y3 = Y2 .* A;
    
    % calculate final p(x)
    Y4 = sum(Y3, 2);
       
    toc
  
    plot(a : h : b, Y4);
    grid on;
    
end