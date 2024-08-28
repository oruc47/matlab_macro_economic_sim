# matlab_macro_economic_sim
Different Macroeconomic Simulations in MATLAB.

Consider the following reduced form of the New Keynesian Model. Output follows the process

$$
y_t = \rho y_{t-1} + (1 - \rho) \bar{y} - \frac{i_t - E_t \pi_{t+1} - r^n}{\theta} + \epsilon_t, \quad 0 < \rho < 1, \quad \theta, r_t^n > 0,
$$

where $\bar{y}$ denotes the full-employment level of output, $r^n$ is the natural real interest rate, and $\epsilon_t$ is a demand shock following an AR1 process given by

$$
\epsilon_t = \rho_\epsilon \epsilon_{t-1} + \epsilon_t^\epsilon, \quad \epsilon_t^\epsilon \sim N(0, \sigma_\epsilon^2), \quad 0 < \rho_\epsilon < 1.
$$

Inflation follows the mechanism

$$
\pi_t = \beta E_t \pi_{t+1} + \omega \left( y_t - \bar{y} \right) + \zeta_t, \quad 0 < \beta < 1, \omega > 0,
$$

where $\zeta_t$ is an inflation shock following an AR1 process given by

$$
\zeta_t = \rho_\zeta \zeta_{t-1} + \epsilon_t^\zeta, \quad \epsilon_t^\zeta \sim N(0, \sigma_\zeta^2), \quad 0 < \rho_\zeta < 1.
$$

Expectations are formed in an adaptive (backward-looking) manner according to

$$
E_t \pi_{t+1} = \lambda \pi^* + (1 - \lambda) \pi_t, \quad 0 < \lambda < 1.
$$

where $\lambda$ denotes the extent of the credibility of the monetary authority and $\pi^*$ is the inflation target. The monetary authority follows the Taylor rule

$$
i_t = r^n + \pi_t + \chi_\pi (\pi_t - \pi^*) + \chi_y (y_t - \bar{y}), \quad \chi_\pi, \chi_y > 0.
$$

The overall loss function in the economy, $L$, is measured by the following function

$$
L = \sum_{t=0}^{\infty} \delta^t \left[ (y_t - \bar{y})^2 + \mu (\pi_t - \pi^*)^2 \right], \quad 0 < \delta < 1, \mu > 0.
$$
