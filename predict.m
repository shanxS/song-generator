function predictedValue = predict(X, y, in)

    predictedValue = 0;

    [m n] = size(X);
    X = [ones(m, 1) X];
    initial_theta = zeros(n + 1, 1);
    
    options = optimset('GradObj', 'on', 'MaxIter', 400);
    [theta, cost] = ...
        fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);
        
    predictedValue = [1 in] * theta;
    
end