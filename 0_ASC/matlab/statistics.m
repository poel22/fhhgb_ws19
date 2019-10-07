function statistics

    mu = 6;
    sigma = 4;
    N = 1000;
    data = randn(N, 1) * sigma + mu;
    
    b = -10;
    e = 20;
    h = 0.01;
    
    
    p = zeros((e - b) / h + 1);
    j = 0;
    for x = b : h : e;
       j = j + 1;
       p(j) = 1 / (sigma * (2 * pi)^0.5) * exp(-0.5 * ( (x - mu) / sigma)^2 );
    end
    
    hold on;
    hist(data, -10:20);
    plot(b:h:e, p*N, 'r-');
    hold off;
    
end