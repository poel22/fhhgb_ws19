function paint(fnstr, a, b, h)

    if nargin == 3
        h = 0.2;
    end
    
    N = (b - a) / h + 1;
    
    Z = zeros(N);
    
    x_ = 0;
    
    for x = a : h : b
        x_ = x_ + 1;
        y_ = 0;
        for y = a : h : b
            y_ = y_ + 1;
            Z(x_, y_) = eval(fnstr);
        end
    end
    
    tiledlayout(1, 2);
    nexttile;
    pcolor(a : h : b, a : h : b, Z);
    shading interp;
    title("2D");
    nexttile;
    surfc(a : h : b, a : h : b, Z);
    title("3D");
    

end