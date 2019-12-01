function plotSinSurf(a, b, h)
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
            z(xc, yc) = sin(x_ / 10 * y_ / 10);
        end
    end
    shading interp;
    surfc(x, y, z);
end