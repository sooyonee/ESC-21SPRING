
## Normal with known sigma

# prior
sigma_0 = 2
nu_0 = 45

# data
set.seed(2016122021)
data = rnorm(5, 2, 3)
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
  ggplot(aes(x=sigma2, y=prob, color=grp))+geom_line()+labs(title=title, subtitle = 'nu_0  = 45')+
  geom_vline(xintercept=sigma_0, linetype="dashed", color="blue")+
  geom_vline(xintercept=sigma_n, linetype="dashed", color="red")

ggarrange(p)

## Normal with known mean

# prior
sigma_0 = 2
nu_0 = 9

# data1
data = rnorm(5, 7, 3)
mu = mean(data)
sigma = var(data)
n = length(data)

# data1
data = rnorm(5, 2, 3)
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
