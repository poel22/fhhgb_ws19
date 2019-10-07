function printSomething(a, b, h)
    
    N = (b - a) / h + 1;
    x = zeros(N);
    y = zeros(N);
    z = zeros(N);
    xc = 0;
    
    mu = [2;2;2];
    sigma = [2 0.5 0; 0 0.5 5; 0 3 8];
    
    
    for x_ = a : h : b
        yc = 0;
        xc = xc + 1;
        for y_ = a : h : b
            yc = yc + 1;
            x(xc, yc) = x_;
            y(xc, yc) = y_;
            X = [x_; y_];
            p_x = 1 / (2 * pi * det(sigma)^0.5) * exp(-0.5 * (X - mu)' * inv(sigma) * (X - mu)); 
            z(xc, yc) = p_x;
        end
    end
    shading interp;
    surfc(x, y, z);

end