function display_clusters(cluster, docs)
%% DISPLAYING Clusters
disp('GENERATED CLUSTERS')
n=size(unique(cluster),1);
for i=1:1:n
    index = find(cluster == i); 
    disp('________________________')
    fprintf('      Cluster %g \n',i); 
    disp('------------------------')
    disp(docs(index, 3))
end
end