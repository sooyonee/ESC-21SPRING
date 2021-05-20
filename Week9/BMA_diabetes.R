#### Diabetes example
load("diabetes.RData")
yf<-diabetes$y
yf<-(yf-mean(yf))/sd(yf)

Xf<-diabetes$X
Xf<-t( (t(Xf)-apply(Xf,2,mean))/apply(Xf,2,sd))
## set up training and test data
n<-length(yf)
set.seed(1)
#write.csv(df1, 'diabetes1.csv', row.names = FALSE)

### Train test split
i.te<-sample(1:n,100)
i.tr<-(1:n)[-i.te]

y<-yf[i.tr] ; y.te<-yf[i.te]
X<-Xf[i.tr,]; X.te<-Xf[i.te,]

#### Bayesian model selection
source("regression_gprior.R")


### Functions
lpy.X<-function(y,X,
                g=length(y),nu0=1,s20=try(summary(lm(y~-1+X))$sigma^2,silent=TRUE)) 
{
  n<-dim(X)[1] ; p<-dim(X)[2] 
  if(p==0) { s20<-mean(y^2) }
  H0<-0 ; if(p>0) { H0<- (g/(g+1)) * X%*%solve(t(X)%*%X)%*%t(X) }
  SS0<- t(y)%*%( diag(1,nrow=n)  - H0 ) %*%y
  
  -.5*n*log(2*pi) +lgamma(.5*(nu0+n)) - lgamma(.5*nu0)  - .5*p*log(1+g) +
    .5*nu0*log(.5*nu0*s20) -.5*(nu0+n)*log(.5*(nu0*s20+SS0))
}

lm.gprior<-function(y,X,g=dim(X)[1],nu0=1,
                    s20=try(summary(lm(y~-1+X))$sigma^2,silent=TRUE),S=1000)
{
  n<-dim(X)[1] ; p<-dim(X)[2]
  Hg<- (g/(g+1)) * X%*%solve(t(X)%*%X)%*%t(X)
  SSRg<- t(y)%*%( diag(1,nrow=n)  - Hg ) %*%y
  
  s2<-1/rgamma(S, (nu0+n)/2, (nu0*s20+SSRg)/2 )
  
  Vb<- g*solve(t(X)%*%X)/(g+1)
  Eb<- Vb%*%t(X)%*%y
  
  E<-matrix(rnorm(S*p,0,sqrt(s2)),S,p)
  beta<-t(  t(E%*%chol(Vb)) +c(Eb))
  
  list(beta=beta,s2=s2)                                
}   

## Don't run it again if you've already run it
runmcmc<-!any(system("ls",intern=TRUE)=="diabetesBMA.RData")
if(!runmcmc){ load("diabetesBMA.RData") }

if(runmcmc){
  
  p<-dim(X)[2]
  S<-10000
  BETA<-Z<-matrix(NA,S,p)
  z<-rep(1,dim(X)[2] )
  lpy.c<-lpy.X(y,X[,z==1,drop=FALSE])
  for(s in 1:S)
  {
    for(j in sample(1:p))
    {
      zp<-z ; zp[j]<-1-zp[j]
      lpy.p<-lpy.X(y,X[,zp==1,drop=FALSE])
      r<- (lpy.p - lpy.c)*(-1)^(zp[j]==0)
      z[j]<-rbinom(1,1,1/(1+exp(-r)))
      if(z[j]==zp[j]) {lpy.c<-lpy.p}
    }
    
    beta<-z
    if(sum(z)>0){beta[z==1]<-lm.gprior(y,X[,z==1,drop=FALSE],S=1)$beta }
    Z[s,]<-z
    BETA[s,]<-beta
    if(s%%10==0)
    { 
      bpm<-apply(BETA[1:s,],2,mean) ; plot(bpm)
      cat(s,mean(z), mean( (y.te-X.te%*%bpm)^2),"\n")
      Zcp<- apply(Z[1:s,,drop=FALSE],2,cumsum)/(1:s)
      plot(c(1,s),range(Zcp),type="n") ; apply(Zcp,2,lines)
    }
  } 
  save(BETA,Z,file="diabetesBMA.RData")
}

Z_mean = apply(Z, 2, mean)
Z_mean %>% { which(. >= 0.5)}

