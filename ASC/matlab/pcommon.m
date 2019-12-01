function pcommon(A, a, b, h)

    if nargin == 3
        h = 0.01;
    end
    
    tic
    
    N = (b - a) / h + 1;
    
    Y = [];
    
    x_ = 0;

    for i = a : h : b
        x_ = x_ + 1;
        p = 0;
        for x = (size(A, 2) - 1) : -1 : 0
            p = p + A(size(A, 2) - x) * i ^ x;
        end
        Y = [Y p];
    end
    
    toc
    
    plot(a : h : b, Y);
    
    title('Plot Common');
    
    grid on;

end