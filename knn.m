function [confusion_matrix, Fmeasure] = kNN()

    load Dataset
	
	% ----- Normalize Data
	inputs = zscore(inputs);

    % ----- Perform leave-one-out cross validation
    
    n = size(inputs,1);  
    predictions = zeros(n,1);

    for element = 1:n

        testData = inputs(element, :);
        trainData = [inputs(1:element-1,:); inputs(element + 1:end,:)];
        trainLabels = [outputs(1:element-1,:); outputs(element + 1:end, :)];
     
        % ----------- Find best k using the trainData
        max_k = 30;
		
		% x contains the classfication errors
        x = zeros(numel(1:2:max_k),1);
        
		% create distance matrix
        [~, trainDistIdx] = sort(pdist2(trainData,trainData));

        % k = 1;
        classes  = trainLabels(trainDistIdx(2,:));
        error_rate  = numel(find(trainLabels-classes)) / n;
        x(1) = error_rate;

        % k > 1, k = i-1
        for i = 4:2:max_k
        classes = mean(trainLabels(trainDistIdx(2:i,:))) > 0.5;
        error_rate  = numel(find(trainLabels'-classes)) / n;
        x(i/2)= error_rate;

        end
        
        [~, minIdx] = min(x);
        k = (minIdx * 2) - 1;
        
        % --------- Classify testData
        
        [~, DistIdx] = sort(pdist2(testData,trainData));
        predictions(element,1) = mean(trainLabels(DistIdx(:,1:k))) > 0.5;
    
    end


    FP = numel(find(outputs-predictions < 0));
    FN = numel(find(outputs-predictions > 0));
    TP = numel(find(predictions)) - FP;
    TN = numel(find(~predictions)) - FN;
    Precision = TP / (TP + FP);
    Recall = TP / (TP + FN);
    Fmeasure = 2 * Precision * Recall / (Precision + Recall);
    confusion_matrix = zeros(2,2);
    confusion_matrix(1,1) = TP;
    confusion_matrix(1,2) = FP;
    confusion_matrix(2,1) = FN;
    confusion_matrix(2,2) = TN;

     

    % ----- Plot Error rates for different k values (using the whole input data)
    max_k = 100;
    x = zeros(numel(1:2:max_k),1);
    y = cell(numel(1:2:max_k),1);
    [~, DistIdx] = sort(pdist2(inputs,inputs));
    % k = 1;
    classes  = outputs(DistIdx(2,:));
    error_rate  = numel(find(outputs-classes)) / n;
    x(1) = error_rate;
    y{1} = num2str(1);
    % k > 1, k = i-1
    for i = 4:2:max_k
        classes = mean(outputs(DistIdx(2:i,:))) > 0.5;
        error_rate  = numel(find(outputs'-classes)) / n;
        x(i/2)= error_rate;
        y{i/2} = num2str(i-1);
    end    
    %find(x == min(x(:)));
    plot(1:numel(1:2:max_k), x);
    text(1:numel(1:2:max_k), x, y);
    title('Error rates for different k values (using the whole input data)')

end
