rho = 0.8;
theta = 1;
rn = 0.04;
beta = 0.95;
delta = 0.95;
rho_epsilon = 0.95;
rho_zeta = 0.9;

sigma_epsilon = 0.01;
sigma_zeta = 0.01;
omega = 0.5;
lambda = 0.5;
pi_star = 0.02;
x_pi = 0.5;
x_y = 0.5;
y0 = 0.95;
pi0 = 0.02;
epsilon0 = 0;
zeta0 = 0;
T = 1000;

y = zeros(T, 1);
pi = zeros(T, 1);
epsilon = zeros(T, 1);
zeta = zeros(T, 1);

y(1) = y0;
pi(1) = pi0;
epsilon(1) = epsilon0;
zeta(1) = zeta0;

epsilon_shock = sigma_epsilon * randn(T, 1);
zeta_shock = sigma_zeta * randn(T, 1);

for t = 2:T
    epsilon(t) = rho_epsilon * epsilon(t-1) + epsilon_shock(t);
    zeta(t) = rho_zeta * zeta(t-1) + zeta_shock(t);
    Et_pi_next = lambda * pi_star + (1 - lambda) * pi(t-1);
    it = rn + pi(t-1) + x_pi * (pi(t-1) - pi_star) + x_y * (y(t-1) - y0); % Taylor rule
    y(t) = rho * y(t-1) + (1 - rho) * y0 - (1/theta) * (it - Et_pi_next - rn) + epsilon(t);
    pi(t) = beta * Et_pi_next + omega * (y(t) - y0) + zeta(t);
end

average_y = mean(y);
average_pi = mean(pi);
std_y = std(y);
std_pi = std(pi);

disp(['Average output: ', num2str(average_y)]);
disp(['Average inflation: ', num2str(average_pi)]);
disp(['Standard deviation of output: ', num2str(std_y)]);
disp(['Standard deviation of inflation: ', num2str(std_pi)]);

zeta0 = 0;
T = 1000;

y = zeros(T, 1);
pi = zeros(T, 1);
epsilon = zeros(T, 1);
zeta = zeros(T, 1);

delta = 0.95;
mu = 0.2;
y_bar = 1;
lambda_values = [0, 1];
loss_values = zeros(size(lambda_values));

for j = 1:length(lambda_values)
    lambda = lambda_values(j);
    loss = 0;
    y(1) = y0;
    pi(1) = pi0;
    epsilon(1) = epsilon0;
    zeta(1) = zeta0;
    
    for t = 2:T
        epsilon(t) = rho_epsilon * epsilon(t-1) + epsilon_shock(t);
        zeta(t) = rho_zeta * zeta(t-1) + zeta_shock(t);
        Et_pi_next = lambda * pi_star + (1 - lambda) * pi(t-1);
        it = rn + pi(t-1) + x_pi * (pi(t-1) - pi_star) + x_y * (y(t-1) - y_bar); % Taylor rule
        y(t) = rho * y(t-1) + (1 - rho) * y_bar - (1/theta) * (it - Et_pi_next - rn) + epsilon(t);
        pi(t) = beta * Et_pi_next + omega * (y(t) - y_bar) + zeta(t);
        loss = loss + delta^(t-1) * ((y(t) - y_bar)^2 + mu * (pi(t) - pi_star)^2);
    end
    
    loss_values(j) = loss;
    disp(['Lambda = ', num2str(lambda)]);
    disp(['Total loss: ', num2str(loss)]);
end

T = 1000;

y = zeros(T, 1);
pi = zeros(T, 1);
epsilon = zeros(T, 1);
zeta = zeros(T, 1);

x_pi_values = [0, 2];
loss_values = zeros(size(x_pi_values));

for j = 1:length(x_pi_values)
    x_pi = x_pi_values(j);
    loss = 0;
    y(1) = y0;
    pi(1) = pi0;
    epsilon(1) = epsilon0;
    zeta(1) = zeta0;
    
    for t = 2:T
        epsilon(t) = rho_epsilon * epsilon(t-1) + epsilon_shock(t);
        zeta(t) = rho_zeta * zeta(t-1) + zeta_shock(t);
        Et_pi_next = lambda * pi_star + (1 - lambda) * pi(t-1);
        it = rn + pi(t-1) + x_pi * (pi(t-1) - pi_star) + x_y * (y(t-1) - y_bar); % Taylor rule with current x_pi
        y(t) = rho * y(t-1) + (1 - rho) * y_bar - (1/theta) * (it - Et_pi_next - rn) + epsilon(t);
        pi(t) = beta * Et_pi_next + omega * (y(t) - y_bar) + zeta(t);
        loss = loss + delta^(t-1) * ((y(t) - y_bar)^2 + mu * (pi(t) - pi_star)^2);
    end
    
    loss_values(j) = loss;
    disp(['x_pi = ', num2str(x_pi)]);
    disp(['Total loss: ', num2str(loss)]);
end
