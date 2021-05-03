### Library

library(ggplot2)
theme_set(theme_minimal())
library(gridExtra)
library(tidyr)
library(latex2exp)

### Raw data

num_diseased <- c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,
                  2,1,5,2,5,3,2,7,7,3,3,2,9,10,4,4,4,4,4,4,4,10,4,4,4,5,11,12,
                  5,5,6,5,6,6,6,6,16,15,15,9,4)
num_of_obs <- c(20,20,20,20,20,20,20,19,19,19,19,18,18,17,20,20,20,20,19,19,18,18,25,24,
                23,20,20,20,20,20,20,10,49,19,46,27,17,49,47,20,20,13,48,50,20,20,20,20,
                20,20,20,48,19,19,19,22,46,49,20,20,23,19,22,20,20,20,52,46,47,24,14)

### Data frame

DF <- data.frame(cbind(num_diseased,num_of_obs))
colnames(DF) <- c("y","n")
DF$ybar = DF$y/DF$n


### theta's uniform prior: beta(1,1)

DF$postmean = (DF$y + 1) / (DF$n + 1)
DF$lb = mapply(function(y, n) qbeta(0.025, y + 1, n - y + 1), DF$y, DF$n)
DF$ub = mapply(function(y, n) qbeta(1 - 0.025, y + 1, n - y + 1), DF$y, DF$n)
title1 = expression(paste("95% Posterior interval, ", beta(1, 1), " prior"))
p1 = ggplot(DF, aes(x = ybar, ymin = lb, ymax = ub)) +
  geom_linerange() + geom_point(aes(y = postmean)) +
  geom_abline(slope = 1, intercept = 0) +
  labs(title = title1, x = "observed mean", y = "posterior mean")
p1

### Hierarchical model using theta's prior: beta(alpha,beta)

griddens = 1e2
A = seq(0.5, 6, length.out = griddens)
B = seq(3, 33, length.out = griddens)
cA = rep(A, each = length(B))
cB = rep(B, length(A))

#1-2 Á¤´ä
lpfun = function(a, b, y, n) # marginal posterior
  (-5/2)* log(a+b) + sum(lgamma(a+b) - lgamma(a) - lgamma(b) + lgamma(a+y) + lgamma(b+n-y) - lgamma(a+b+n))

lp = mapply(lpfun, cA, cB, MoreArgs = list(DF$y, DF$n))
df_marg = data.frame(alpha= cA, beta= cB, posterior = exp(lp)/sum(exp(lp)))
title2 = TeX('The marginal of $\\alpha$ and $\\beta$')
p2 = ggplot(data = df_marg, aes(x=alpha, y=beta))+
  geom_raster(aes(fill = posterior, alpha= posterior), interpolate= T)+
  geom_contour(aes(z= posterior), color = 'black', size= 0.2)+
  coord_cartesian(xlim= c(1,5), ylim= c(4,26))+
  labs(x = TeX('$\\alpha$'), y= TeX('$\\beta$'), title= title2)+
  scale_fill_gradient(low= "cornflowerblue", high= "navy", guide= F)+
  scale_alpha(range= c(0,1), guide=F)
p2

### Grid sampling to generate posterior samples of alpha, beta

# (re)settings
DF <- data.frame(cbind(num_diseased,num_of_obs))
colnames(DF) <- c("y","n")
DF$ybar = DF$y/DF$n
DF$postmean = DF$ub = DF$lb = rep(NA, nrow(DF))
Nsamp = 1e3
set.seed(101)

# sample alpha, beta
samp_idx = sample(length(df_marg$posterior),
                  size = Nsamp, replace=T, prob = df_marg$posterior)
samp_A = cA[samp_idx]
samp_B = cB[samp_idx]

# sample theta_j for each j
for(i in 1:nrow(DF)){
  n = DF$n[i]; y = DF$y[i]
  theta_j = mapply(function(a, b, n, y) rbeta(1, y+a, n-y+b),
                   samp_A, samp_B, MoreArgs = list(n=n, y=y))
  DF$lb[i] = quantile(theta_j, 0.025)
  DF$ub[i] = quantile(theta_j, 1-0.025)
  DF$postmean[i] = mean(theta_j)
}

# 95% posterior interval
title3 = TeX('95% posterior interval, uninformative $\\alpha$, $\\beta$ prior')
p3 = ggplot(DF, aes(x=ybar, ymin=lb, ymax=ub))+
  geom_linerange()+geom_point(aes(y=postmean))+geom_abline(slope = 1, intercept = 0)+
  labs(title=title3, x="observed mean", y="posterior mean")
p3

# compare
grid.arrange(p1, p3)
