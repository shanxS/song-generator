function [J, grad] = costFunction(theta, X, y)

m = length(y); % number of training examples

J = 0;
grad = zeros(size(theta));

J = calculateCostFunction(theta, X, y);
grad = calculateGradient(J, theta, X, y);

end


function grad = calculateGradient(J, theta, X, y)
    
    m = length(y);
    grad = (((calculateHypothesis(X, theta)) - y)' * X)/m;
    
end


function J = calculateCostFunction(theta, X, y)
    m = length(y);

    tempSum = 0;
    for i=1:m
        hypothesis = calculateHypothesis(X(i, :), theta);
        tempSum += power((hypothesis - y(i)), 2);
    end
    J = tempSum/(2*m);
end


function h = calculateHypothesis(Xi, theta)

    h = Xi * theta;

end