function J = computeCostMulti(X, y, theta)
% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta
%               You should set J to the cost.


tempSum = 0;
for i=1:m
    hypothesis = calculateHypothesis(X(i, :), theta);
    tempSum += power((hypothesis - y(i)), 2);
end
J = tempSum/(2*m);


% =========================================================================

end


function h = calculateHypothesis(Xi, theta)

    h = Xi * theta;

end