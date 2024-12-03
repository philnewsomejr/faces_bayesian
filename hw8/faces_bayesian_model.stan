
data {
  int<lower=0> N;  // number of observations
  vector[N] hit_rate;  // dependent variable (hit_rate)
  vector[N] lamyg_mean_change;  // predictor variable (lamyg_mean_change)
}

parameters {
  real beta0;  // intercept
  real beta1;  // slope for lamyg_mean_change
  real<lower=0> sigma;  // residual standard deviation
}

model {
  // Model
  hit_rate ~ normal(beta0 + beta1 * lamyg_mean_change, sigma);

  // Priors
  beta0 ~ normal(0.6, 0.3);  // prior for intercept
  beta1 ~ normal(0, 0.2);   // prior for slope
  sigma ~ normal(0, 1);   // prior for residual standard deviation
}

generated quantities {
  vector[N] hit_rate_rep;  // predicted hit_rate from the model
  for (n in 1:N) {
    hit_rate_rep[n] = normal_rng(beta0 + beta1 * lamyg_mean_change[n], sigma);
  }
}

