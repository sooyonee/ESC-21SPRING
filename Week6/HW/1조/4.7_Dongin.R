#(a)
Sigma=matrix(1/rgamma(75,10,2.5))

Theta=matrix()
for (i in 1:75){
  sigma=Sigma[i]
  Theta[i] = rnorm(1, 4.1, sigma/20)
} 
Theta=matrix(Theta)

Y=matrix(nrow=75, ncol=75)
for (i in 1:75){
  sigma=Sigma[i]
  for (j in 1:75){
    theta=Theta[j]
    Y[j,i]=0.31*rnorm(1, theta, sqrt(sigma))+0.46*rnorm(1, 2*theta, 2*sqrt(sigma))+0.23*rnorm(1, 3*theta, 3*sqrt(sigma))
  }
}

#(b)
q=quantile(Y, probs=c(0.125, 0.875))


#(c)-1
den=density(Y)
sum(den[['y']])
den[['y']]=den[['y']]/sum(den[['y']])
sum(den[['y']])

#(c)-2
p=den[['y']][order(den[['y']], decreasing=TRUE)]
sum(p)

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
q1=den[['x']][den[['y']]==p[i-1]]
q2=den[['x']][den[['y']]==p[i]]
abline(v=q1, col='blue')
abline(v=q2, col='blue')
