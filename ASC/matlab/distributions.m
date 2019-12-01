function distributions
    
    N = 1000;
    %data1 = randn(N, 3) * [2 0.5; 0.5 3]+ repmat([3 7 5], N, 1);
    %data2 = randn(N, 3) * [1 0; 0 1]+ repmat([8 5 2], N, 1);
    %data3 = randn(N, 3) * [1 0; 0 1]+ repmat([2 5 1], N, 1);
    %data4 = randn(N, 3) * [1 0; 0 1]+ repmat([8 2 6], N, 1);
    data1 = randn(N, 3) + repmat([1 2 5], N, 1);
    data2 = randn(N, 3) + repmat([8 5 2], N, 1);
    data3 = randn(N, 3) + repmat([2 4 1], N, 1);
    data4 = randn(N, 3) + repmat([5 2 6], N, 1);
    plot3(data1(:,1),data2(:,2),data2(:,3),'g.');
    hold on;
    plot3(data2(:,1),data2(:,2),data2(:,3),'r.');
    plot3(data3(:,1),data3(:,2),data3(:,3),'b.');
    plot3(data4(:,1),data4(:,2),data4(:,3),'y.');
    hold off;
    grid on;
    
end