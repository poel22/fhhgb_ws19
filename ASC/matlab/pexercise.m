function pexercise(b, e, h)

    if nargin == 0
        b = -10;
        e = 10;
        h = 0.0001;
    end

    %{
    
    % V 1
    
    tic
    
    y = [];
    
    for x = b : h : e
        y_ = x^3 - 7 * x^2 + 2;
        y = [y y_];
    end
    
    toc
    %}
    
    %{

    % V 2
    
    tic
    
    xc = 0;
    y = zeros((b - e) / h + 1);
    
    for x = b : h : e
        xc = xc + 1;
        y_ = x^3 - 7 * x^2 + 2;
        y(xc) = y_;
    end
    
    toc
        
    %}
    
    % V 3
    
    tic
    
    x = b : h : e;
    y = x.^3 - 7 * x.^2 + 2;
    
    toc
    
    plot(b:h:e, y)
    
end