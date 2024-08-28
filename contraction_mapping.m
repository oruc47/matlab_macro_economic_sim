a = 9;
Gamma = @(x) (x^3 + x^2 + 1) / a;
%define the operation function and set the value of 'a'

x = 0.3; %initial guess for the root
epsilon = 1e-6; %minimum bound for convergence (ideally a number close to zero)
iter = 100; %number of iterations
iter_count = 0; %iteration counter

while true
    iter_count = iter_count + 1;
    x_1 = Gamma(x); %apply gamma to our initial guess

    %convergence check
    if abs(x_1 - x) < epsilon
        break; % condition is met, convergence satisfied, end code
    end
    
    x = x_1; % else, we set x to be the new calculated value
    
    % If the number of iterations exceeds the set limit, break the loop
    if iter_count >= iter
        disp('Max no. of iterations reached without convergence.');
        break;
    end
end

disp(x);
