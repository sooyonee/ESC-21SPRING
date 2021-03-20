install.packages('ggplot2')
install.packages('tidyr')
install.packages("ggpubr")

library(ggplot2)
library(ggpubr)
library(tidyr)

## Normal model with unknown mu

## prior
mu_0 = 10
tau_0 = 5

## data
mu = 5
sd = 2.5
n = 10

## posterior(parameter update)
mu_n = ((1/tau_0^2)/(1/tau_0^2+n/sd^2))*mu_0+
  (n/sd^2/(1/tau_0^2+n/sd^2))*mu
tau_n = sqrt(1/(1/tau_0^2+n/sd^2))


title = "Prior & Data & Posterior"
theta = seq(0,30,0.1)
p = data.frame(theta = theta, 
               prior = dnorm(theta, mu_0, tau_0),
               post = dnorm(theta, mu_n, tau_n),
               data = dnorm(theta, mu, sd)
)%>% gather(grp, prob, -theta) %>%
  ggplot(aes(x=theta, y=prob, color=grp))+geom_line()+labs(title=title)

ggarrange(p)


## Normal model with unknown sigma

# prior
sigma_0 = 2
nu_0 = 9

# data1
data = rnorm(5, 7, 3)
mu = mean(data)
sigma = var(data)
n = length(data)

# posterior
nu_n = nu_0 + n
sigma_n = (nu_0*sigma_0^2+sum((data-mu)^2))/nu_n


dist_inverse_chi = function(theta, v, tau2)
  ((v*tau2/2)^(v/2))/gamma(v/2) *(1/theta)^(v/2 +1) * exp(-v*tau2/(2*theta))

title ="Prior & Posterior"
sigma2 = seq(0,20,0.1)
p = data.frame(sigma2 = sigma2,
               prior = dist_inverse_chi(sigma2, nu_0, sigma_0),
               posterior = dist_inverse_chi(sigma2, nu_n, sigma_n)
) %>%
  gather(grp, prob, -sigma2) %>%
  ggplot(aes(x=sigma2, y=prob, color=grp))+geom_line()+labs(title=title)+
  geom_vline(xintercept=sigma_0, linetype="dashed", color="blue")+
  geom_vline(xintercept=sigma_n, linetype="dashed", color="red")

ggarrange(p)
