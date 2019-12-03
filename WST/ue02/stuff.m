nrDoc = size(TtD, 2);
indexPerm = randperm(nrDoc);
nrCluster = size(CtD, 1);

splitIndex = round(nrDoc * 0.7);

trainingSetIndexes = indexPerm(1:splitIndex)
validationSetIndexes = indexPerm(splitIndex + 1:nrDoc)

techDocs = []
nonTechDocs = []

for index = trainingSetIndexes
    if CtD(1, index)
        techDocs = [techDocs, TtD(:,index)];
    else
        nonTechDocs = [nonTechDocs, TtD(:,index)];
    end
end

techCenter = mean(techDocs, 2);
nonTechCenter = mean(nonTechDocs, 2);

correctlyClassified = []
falsePositives = []
falseNegatives = []
% Evaluate cosinus
for index = validationSetIndexes
    if pdist2(techCenter', TtD(:,index)', "cosine") < pdist2(nonTechCenter', TtD(:,index)', "cosine")
        if CtD(1, index)
            correctlyClassified = [correctlyClassified, index]
        else
            falsePositives = [falsePositives, index]
        end
    else
        if CtD(1, index)
            falseNegatives = [falseNegatives, index]
        end
    end
end