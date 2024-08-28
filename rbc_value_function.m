beta = 0.95;
alpha = 0.3;
del = 0.1;

N = 1000; %discretization points
T = 100; %no. of time periods

kv = linspace(0.5, 4.5, N); %state space for capital
V = zeros(1, N); %value function
kp = zeros(1, N); %policy function

%function iteration
distanceV = 1;
tolerance = 0.1;

while distanceV > tolerance
    Vp = zeros(1, N); %temp value function

    for i = 1:N
        c = max(kv(i)^alpha - kv + (1 - del) * kv(i), 1e-8); % consumption vector
        [Vp(i), kp(i)] = max(log(c) + beta * V); % bellman 
    end

    distanceV = max(abs(V - Vp)); %convergence measure updates based on abs distance
    V = Vp; %value function update
  
    subplot(2,1,1);
    plot(kv, V);
    title('Value Function V(k)');
    xlabel('Capital k');
    ylabel('Value');
    pause(0.1);

    subplot(2,1,2);
    plot(kv, kv(kp));
    title('Policy Function');
    xlabel('Capital k');
    ylabel('Optimal Next Period Capital k''');
end

steady_state_index = 0

for i = 2:N
    if V(i) > V(i-1)
        steady_state_index = i-1;
        disp(steady_state_index)
        disp(i)
        break;
    end
end


% idea here is to stop the loop when then the value 
% function decreases

steady_state_k = kv(steady_state_index);

%set the steady state value to the capital state space at that point

%the earthquake shoc
k_post_earthquake = steady_state_k * 0.8;

%intialize economics variables
capital_stock = k_post_earthquake;
output = capital_stock^alpha;
consumption = output; % assume all output is consumed
investment = steady_state_k - (1 - del) * capital_stock; % investment to return to steady state
wage_rate = (1 - alpha) * capital_stock^alpha;
interest_rate = alpha * capital_stock^(alpha - 1);

%store results in matrix
capital_stock_series = zeros(1, T);
output_series = zeros(1, T);
consumption_series = zeros(1, T);
investment_series = zeros(1, T);
wage_rate_series = zeros(1, T);
interest_rate_series = zeros(1, T);


for t = 1:T
    % Store the results
    capital_stock_series(t) = capital_stock;
    output_series(t) = output;
    consumption_series(t) = consumption;
    investment_series(t) = investment;
    wage_rate_series(t) = wage_rate;
    interest_rate_series(t) = interest_rate;

    %update next period
    min_diff = inf;
    k_index = 1;

% go through the capital grid to find the closest capital stock
    for i = 1:N
        diff = abs(kv(i) - capital_stock);
        if diff < min_diff
            min_diff = diff;
            k_index = i;
        end
    end
    capital_stock = kv(kp(k_index));
    output = capital_stock^alpha; 
    consumption = output - investment; 
    investment = capital_stock - (1 - del) * kv(k_index); 
    wage_rate = (1 - alpha) * capital_stock^alpha;
    interest_rate = alpha * capital_stock^(alpha - 1);
    %update the econoimic values
end

subplot(3, 2, 1);
plot(1:T, capital_stock_series);
title('Capital Stock');

subplot(3, 2, 2);
plot(1:T, output_series);
title('Output');

subplot(3, 2, 3);
plot(1:T, consumption_series);
title('Consumption');

subplot(3, 2, 4);
plot(1:T, investment_series);
title('Investment');

subplot(3, 2, 5);
plot(1:T, wage_rate_series);
title('Wage Rate');

subplot(3, 2, 6);
plot(1:T, interest_rate_series);
title('Interest Rate');
