function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

C_vec = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
sigma_vec = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
predictions_error = zeros(length(C_vec),length(sigma_vec));

for i=1:length(C_vec)
    for j=1:length(sigma_vec)
        % set C, sigma
        C = C_vec(i);
        sigma = sigma_vec(j);
        % training model
        model = svmTrain(X, y, C, @(x1, x2)gaussianKernel(x1, x2, sigma));
        % predict y on cross validation set
        predictions = svmPredict(model, Xval);
        % saved predicted value to matrix
        predictions_error(i, j) = mean(double(predictions ~= yval));
    end
end

% find C and sigma that give minimum error
minimum = min(predictions_error, [],'all', 'linear');
[i, j] = find(predictions_error == minimum);

% assign C and sigma
C = C_vec(i);
sigma = sigma_vec(j);
% =========================================================================

end
