function rsquares=rsquared(measured,predicted)
    % measured is a matrix, first column is independent, second column is
    % dependent.
    
    % predicted is matrix of predicted values in columns.
    % rsquares = max(0,1 - sum((y(:)-f(:)).^2)/sum((y(:)-mean(y(:))).^2));
    rsquares = 1 - sum((predicted-measured(:,2)).^2,1) / sum((measured(:,2)-mean(measured(:,2))).^2);
end
