function [Xout, Yout, Zout] = paint2(mu, sigma, a, b, h)

    if nargin == 4
        h = 0.01;
    end

    N = (b - a) / h + 1;
    x = zeros(N);
    y = zeros(N);
    z = zeros(N);
    xc = 0;
    
    for x_ = a : h : b
        yc = 0;
        xc = xc + 1;
        for y_ = a : h : b
            yc = yc + 1;
            x(xc, yc) = x_;
            y(xc, yc) = y_;
            X = [x_; y_];
            z(xc, yc) = 0;
            for i = 1 : 1 : size(mu, 2)
                p1 = 1 / ((2 * pi)^(size(mu{i}, 2) / 2) * det(sigma{i})^0.5);
                p2 = exp(-0.5*(X - mu{i})' * inv(sigma{i}) * (X - mu{i}));
                p_x = p1 * p2;
                z(xc, yc) = z(xc, yc) + p_x;
            end
        end
    end
    
    Xout = x;
    Yout = y;
    Zout = y;
    
end