# Week2

### One-parameter Model and Review of Mathematical Statistics



## Topic

1. Poisson Distribution
2. Bayesian Poisson Model
3. Bayesian Normal Model
4. Exponential Families
5. Conjugacy



# Homework

1. FCB Exercises 3.3 : Tumor counts

   cf. [week2\_lab.ipynb](./week2_lab.ipynb) 참고 : Birth rates for Poisson Model (FCB P.48~50)

   

2. Data가 binomial distribution일때, Likelihood를 Exponential Families 형태로 변환해 보기.    또한 왜 Beta distribution이 Conjugacy인지 생각해 보기.

   cf. Appendix 참고

   

3. Relationship between Poisson distribution and Negative Binomial Distribution


   $$
   X \sim NB(r,p)
   $$

   $$
   p(x) = \binom{r-1+x}{x}(1-p)^{r}p^{x}
   $$

   $$
   Let\:mean\:\frac{pr}{1-p}=\lambda\:\:\:\:\:\:\:\to\:\:\:\:\:\:p=\frac{\lambda}{r+\lambda}
   $$

   a. Prove the following.
   $$
   Poi(\lambda) = \lim_{r\to\infin}NB(r,\frac{\lambda}{r+\lambda})
   $$
   b. Compare the variance of each distribution. Show that the Negative Binomial distribution is always overdispersed.

   c. Likewise, prove the following.
   $$
   Y \sim Binom(n,p)
   $$

   $$
   p(y) = \binom{n}{x}p^{y}p^{n-y}
   $$

   $$
   Let\:mean\:np=\lambda\:\:\:\:\:\:\to\:\:\:\:\:\:p=\frac{\lambda}{n}
   $$

   $$
   Poi(\lambda) = \lim_{n\to\infin}Binom(n,\frac{\lambda}{n})
   $$

   