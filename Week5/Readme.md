## Week 5: Hierarchical Model

### Lecturer

정유진, 이재현



### Reading 

필수: FCB p.130~p.143 (8.2 ~ 8.4)

선택: FCB 8장, BDA 5.1~5.3



### Homework

1. Using `RatTumor.R`,

   1. Derive the marginal posterior distribution for (alpha, beta).
      $$
      \begin{align*}
      p(\theta,\psi|y) &\propto p(y|\theta,\psi)p(\theta,\psi) \\
      &= p(y|\theta)p(\theta,\psi) \\
      &= p(y|\theta)p(\theta|\psi)p(\psi)
      \end{align*}
      $$

      $$
      p(\alpha,\beta|y) = \int_{\Theta}p(\theta,\alpha,\beta|y)\:d\theta
      $$

   2. Find the line(s) in the R code that is equivalent to the result 1-1.

2. TBD

3. TBD
