#### Put data into list form. This is different from in the book. 
Y<-list()
YM<-NULL
J<-max(Y.school.mathscore[,1])
n<-ybar<-ymed<-s2<-rep(0,J)
for(j in 1:J) {
  Y[[j]]<-Y.school.mathscore[ Y.school.mathscore[,1]==j,2] 
  ybar[j]<-mean(Y[[j]])
  ymed[j]<-median(Y[[j]])
  n[j]<-length(Y[[j]])
  s2[j]<-var(Y[[j]])
  YM<-rbind( YM, cbind( rep(j,n[j]), Y[[j]] ))
}

## YM is like Y.school.mathscore in the book. 
colnames(YM)<-c("school","mathscore")

#######여기부터 중요
## weakly informative priors
nu0<-1  ; s20<-100
eta0<-1 ; t20<-100
mu0<-50 ; g20<-25

## starting values
m<-length(Y) 
n<-sv<-ybar<-rep(NA,m) 
for(j in 1:m) 
{ 
  ybar[j]<-mean(Y[[j]])
  sv[j]<-var(Y[[j]])
  n[j]<-length(Y[[j]]) 
}

#100개 학교 theta
theta<-ybar
#동일한 sigma2
sigma2<-mean(sv)
#mu, tau2-> theta의 평균 분산(hyper parameter)
mu<-mean(theta)
tau2<-var(theta)

## setup MCMC
set.seed(1)
S<-5000
THETA<-matrix( nrow=S,ncol=m)
MST<-matrix( nrow=S,ncol=3)

## MCMC algorithm
for(s in 1:S) 
{
  
  # sample new values of the thetas
  for(j in 1:m) 
  {
    vtheta<-1/(n[j]/sigma2+1/tau2)
    #theta의 conditional posterior mean
    etheta<-vtheta*(ybar[j]*n[j]/sigma2+mu*tau2)
      theta[j]<-rnorm(1,etheta,sqrt(vtheta))
  }
  
  #sample new value of sigma2
  nun<-nu0+sum(n)
  ss<-nu0*s20;for(j in 1:m){ss<-ss+sum((Y[[j]]-theta[j])^2)}
  sigma2<-1/rgamma(1,nun/2,ss/2)
  
  #sample a new value of mu
  #mu의 conditional posterior variance
  vmu<- 1/(m/tau2+1/g20)
    emu<- vmu*(m*mean(theta)/tau2 + mu0/g20)
  mu<-rnorm(1,emu,sqrt(vmu)) 
  
  # sample a new value of tau2
  etam<-eta0+m
  #tau2의 conditional posterior
  ss<- eta0*t20+sum((theta-mu)^2)
    tau2<-1/rgamma(1,etam/2,ss/2)
  
  #store results
  #theta
  THETA[s,]<-theta
  #mu,sigma2,tau2
  MST[s,]<-c(mu,sigma2,tau2)
  
} 
#gibbs sampling 결과 저장
mcmc1<-list(THETA=THETA,MST=MST)



###교재에 있는 plot 그려보기
#### Figure 8.7
par(mfrow=c(1,3),mar=c(2.75,2.75,.5,.5),mgp=c(1.7,.7,0))
plot(density(MST[,1],adj=2),xlab=expression(mu),main="",lwd=2,
     ylab=expression(paste(italic("p("),mu,"|",italic(y[1]),"...",italic(y[m]),")")))
abline( v=quantile(MST[,1],c(.025,.5,.975)),col="gray",lty=c(3,2,3) )
plot(density(MST[,2],adj=2),xlab=expression(sigma^2),main="", lwd=2,
     ylab=expression(paste(italic("p("),sigma^2,"|",italic(y[1]),"...",italic(y[m]),")")))
abline( v=quantile(MST[,2],c(.025,.5,.975)),col="gray",lty=c(3,2,3) )
plot(density(MST[,3],adj=2),xlab=expression(tau^2),main="",lwd=2,
     ylab=expression(paste(italic("p("),tau^2,"|",italic(y[1]),"...",italic(y[m]),")")))
abline( v=quantile(MST[,3],c(.025,.5,.975)),col="gray",lty=c(3,2,3) )
dev.off()

#### Figure 8.8
par(mar=c(3,3,1,1),mgp=c(1.75,.75,0))
par(mfrow=c(1,2))

theta.hat<-apply(THETA,2,mean)
plot(ybar,theta.hat,xlab=expression(bar(italic(y))),ylab=expression(hat(theta)))
abline(0,1)
plot(n,ybar-theta.hat,ylab=expression( bar(italic(y))-hat(theta) ),xlab="sample size")
abline(h=0)
dev.off()