# matlab_macro_economic_sim
Different Macroeconomic Simulations in MATLAB.

The following is a reduced form of the New Keynesian Model. Output follows the process

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

First we use initial conditions simulate output, inflation, and the interest rate policy for 1000 periods. We will set $\rho = 0.8$, $\bar{y} = 1$, $\theta = 2$, $r^n = 0.04$, $\beta = 0.95$, $\delta = 0.95$, $\rho_\epsilon = \rho_\zeta = 0.9$, $\sigma_\epsilon^2 = \sigma_\zeta^2 = 0.001$, $\omega = 0.5$, $\mu = 0.2$, $\lambda = 0.5$, $\pi^* = 0.02$, and $\chi_\pi = \chi_y = 0.5$. We will assume that the initial conditions are given by $y_0 = 0.95$, $\pi_0 = 0.02$, and $\epsilon_0 = \zeta_0 = 0$. 

Then we will look at an economy where the monetary authority does not have any credibility, i.e. $\lambda = 0$, and for an economy where the monetary authority has full credibility, i.e. $\lambda = 1$. We will see the overall loss for 1000 periods using the given loss function.

Finally we will look at an economy where the monetary authority is very dovish and does not care about inflation at all, i.e. $\chi_\pi = 0$, and for an economy where the monetary authority is very hawkish and cares strongly about inflation, for instance $\chi_\pi = 2$. We will, again, see the overall loss for 1000 periods using the given loss function.

| Metric                            | Value      |
|-----------------------------------|------------|
| **Average output**                | 0.94548    |
| **Average inflation**             | 0.020037   |
| **Standard deviation of output**  | 0.033016   |
| **Standard deviation of inflation** | 0.026745   |

| **Lambda Value** | **Total Loss** |
|-----------------|---------------|
| 0               | 0.059242      |
| 1               | 0.028441      |

| **$x_{\pi}$ Value**  | **Total Loss** |
|----------------|---------------|
| 0              | 0.014786      |
| 2              | 0.032218      |

As expected we see a greater loss in the situations where the monetary authority does not have any credibility and also where they are very hawkish. This makes sense as when the monetary authority does not have any credibility households and firms will deviate from the inflation target and increase volatility in output. Furthermore, a hawkish monetary authority would interfere more with the inflation of the economy thus increasing the loss of the output function.

We can use MATLAB to find roots of higher order equations using a contraction mapping approach. This is especially useful in dynamic programming as it allows us to solve value functions that can be used to model economic growth. For example, consider the cubic equation, $g(x) = x^3 + x^2 - ax + 1 = 0$, $x \in A$, $A = R[0, 1]$. We define the operator

$$
x_{n+1} = \Gamma(x_n) = \frac{1}{a} \left[ x_n^3 + x_n^2 + 1 \right].
$$

The code in __________ solves this.


Consider an economy where a large number of identical households seek to maximize their discounted lifetime utility given by

$$
\max_{{c_t}_{t=0}^\infty} \sum_{t=0}^\infty \beta^t \ln(c_t),
$$

subject to

$$
c_t + a_{t+1} \leq w_t n_t^s + a_t(1 + r_t),
$$

$$
c_t, a_t \geq 0, \quad 0 \leq n_t^s \leq 1, \quad a_0 > 0 \text{ is given}.
$$

where $c_t$ and $n_t^s$ are consumption and labor supply of the household at time $t$. Households have one unit of time available that can be used for leisure and work. There are competitive labor and capital markets where the wage rate $w_t$ and interest rate $r_t$ (net of depreciation) are competitively settled. Households lend their capital to firms to provide capital services. Firms seek to maximize their profits by picking optimal $k_t$ and $n_t^d$, where

$$
\Pi_t = \max_{k_t, n_t^d} \left( f(k_t, n_t^d) - w_t n_t^d - (r_t + \delta) k_t \right),
$$

and the production technology is given by $f(k_t, n_t) = k_t^\alpha n_t^{1-\alpha}$.

Capital depreciates at rate $0 < \delta < 1$. All the capital and production units (firms) are owned by households.


