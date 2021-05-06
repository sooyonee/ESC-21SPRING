#mixture model: p(y|theta,sigma^2) = 0.31*dnorm(y,theta,sigma)+0.46*dnorm(2theta1,2sigma)+0.23*dnorm(y,3theta1,3sigma)

#posterior distribution of parameters
#sigma^2 ~ inverse gamma(10,2.5)
#theta|sigma^2 ~ normal(4.1,sigma^2/20)

#(a)
Sigma=matrix(1/rgamma(80,10,2.5))
Sigma
Theta=matrix()
for (i in 1:80){
  sigma=Sigma[i]
  Theta[i] = rnorm(1, 4.1, sigma/20)
} 
Theta=matrix(Theta)
Theta

Y=matrix(nrow=80, ncol=80)
for (i in 1:80){
  sigma=Sigma[i]
  for (j in 1:80){
    theta=Theta[j]
    Y[j,i]=0.31*rnorm(1, theta, sqrt(sigma))+0.46*rnorm(1, 2*theta, 2*sqrt(sigma))+0.23*rnorm(1, 3*theta, 3*sqrt(sigma))
  }
}
dim(Y)
head(Y)
#(b)
q=quantile(Y, probs=c(0.125, 0.875))
q


#(c)-1
den=density(Y)
den
sum(den[['y']])
den[['y']]=den[['y']]/sum(den[['y']])
sum(den[['y']])

#(c)-2
p=den[['y']][order(den[['y']], decreasing=TRUE)]
sum(p)
head(p)

#(c)-3
plot(den)
abline(v=q[1], col='red')
abline(v=q[2], col='red')

i=1
t=0
while (t<0.75){
  t=t+p[i]
  i=i+1
}
t;i
q1=den[['x']][den[['y']]==p[i-1]]
q2=den[['x']][den[['y']]==p[i]]
abline(v=q1, col='blue')
abline(v=q2, col='blue') 

#(d) 모르겠습니다ㅠ

