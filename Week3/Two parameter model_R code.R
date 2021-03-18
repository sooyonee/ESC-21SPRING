# data
D = c(1.64, 1.70, 1.72, 1.74, 1.82, 1.82, 1.82, 1.90, 2.08)
n = length(D); xbar = mean(D); s2 = var(D)

# prior
mu0 = 1.9; kappa0 = 1; s20 = 0.01; nu0 = 1

# posterior
kappa1 = kappa0 + n
nu1 = nu0 + n
mu1 = (kappa0 * mu0 + n * xbar) / kappa1
s21 = (1/ nu1) * (nu0*s20 + (n-1)*s2 + (kappa0*n/kappa1)*(xbar-mu0)^2 )
# visualize
prior = function(theta, sigma2)
  dnorm(theta, mu0, sqrt(sigma2/kappa0)) * dsinvchi(sigma2, nu0, s20)
posterior = function(theta, sigma2)
  dnorm(theta, mu1, sqrt(sigma2/kappa1)) * dsinvchi(sigma2, nu1, s21)
mu = seq(1.6, 2, length.out = 100)
sigma2 = seq(0.001, 0.04, length.out = 100)
cmu = rep(mu, each = length(sigma2))
csigma2 = rep(sigma2, length(mu))
prr_dens = mapply(prior, cmu, csigma2)
post_dens = mapply(posterior, cmu, csigma2)

title1 = "Joint prior"
p1 = data.frame(mu = cmu, sigma2 = csigma2, dens = prr_dens) %>%
  ggplot(aes(x=cmu, y=sigma2))+
  geom_raster(aes(fill = dens, alpha= dens), interpolate= T)+
  geom_contour(aes(z= dens), color = 'black', size= 0.2)+
  scale_fill_gradient(low= "cornflowerblue", high= "cornflowerblue", guide= F)+
  scale_alpha(range= c(0,1), guide=F)+
  labs(title=title1)
title2 = "Joint posterior"
p2 = data.frame(mu = cmu, sigma2 = csigma2, dens = post_dens) %>%
  ggplot(aes(x=cmu, y=sigma2))+
  geom_raster(aes(fill = dens, alpha= dens), interpolate= T)+
  geom_contour(aes(z= dens), color = 'black', size= 0.2)+
  scale_fill_gradient(low= "cornflowerblue", high= "cornflowerblue", guide= F)+
  scale_alpha(range= c(0,1), guide=F)+
  labs(title=title2)

ggarrange(p1, p2)

