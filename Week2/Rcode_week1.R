library(usmap);library(ggplot2) #This is a motivating example for Bayesian analysis. This example basically comes from Section 2.7 of BDA3 (estimation of kidney cancer rates). I have copied most of the R code from Robin Ryder's blog post (google this).  


d = read.csv("KidneyCancerClean.csv", skip = 4) 
head(d, 5)
# only relevant columns   are dc, dc.2, pop and pop.2. dc and dc.2 are the death counts due to kidney cancer in 1980-84 and 1985-89 respectively. 
# Also pop and pop.2 are some measure of the population in 1980-84 and 1985-89 respectively. 


#let us combine the death and population counts for the two periods 80-84 and 85-89
d$dct = d$dc + d$dc.2 #total death count
d$popm = (d$pop + d$pop.2)/2 #average population (obviously does not make sense to add the populations)



#The naive (frequentist) estimate of theta is simply death count/pop
d$thetahat = d$dct/d$popm #BDA3 further divide by 10 to get the per year rate (this is not done here)
q = quantile(d$thetahat, c(.1, .9)) ; q

d$cancerlow = d$thetahat <= q[1] #counties with low cancer rate : bottom 90%
d$cancerhigh = d$thetahat >= q[2] #counties with high cancer rate : top 10%





plot_usmap("counties", data = d, values = "cancerhigh", include = statepop$full[-2]) + scale_fill_discrete(h.start = 200, name = "High rate of kidney cancer deaths") #Plotting the high cancer rate counties

#the include = statepop$full[-2] clause is included to exclude counties in the state of Alaska for which data are missing (no big deal)

quartz()
plot_usmap("counties", data = d, values = "cancerlow", include = statepop$full[-2]) + scale_fill_discrete(h.start = 200, name = "Low rate of kidney cancer deaths") #Plotting the low cancer rate counties

summary(d$thetahat) # Let's figure out the magic behind the cancer rate counties being too similar.

#These maps are surprising because the counties with the highest kidney cancer death rate and those with the lowest kidney cancer death rates are somewhat similar
#mostly counties in the middle of the map!

#The reason for this pattern (as explained in page 47 of BDA3) is that these are counties with a low population. 
#Indeed, a typical value of thetahat_j is around 0.0001 (the mean of the thetahat_js equals 0.0001081647).

#Take a county with a population of 1000. It is likely to have no kidney cancer deaths giving thetahat_j = 0 and putting it in the first decile. 
# But if it happens to have a single death, the estimated rate jumps to thetahat_j = 0.001 (10 times the average rate) putting the county in the highest decile. 










#Histogram of the naive frequentist estimates
hist(d$thetahat, breaks = 30)
#an interesting point is that the shape of the histogram crucially depends on the number of breaks
quartz()
hist(d$thetahat, breaks = 1000)
hist(d$thetahat, breaks = 100) #this is probably close to the plot given in page 51 of BDA3 (although the x-axis scaling is off compared to BDA3)







#Now, Bayesian estimation

#First, some heuristics to get the right prior (estimate parameters of the prior using the Method of Moments)
uu = d$thetahat[d$popm > 300000]#these are the naive estimates for large counties (population larger than 200000)
#How do we fit a Beta density to these values? 
#The mean of Beta(alpha, beta) is alpha/(alpha + beta) and variance is (alpha beta)/((alpha + beta)^2 (alpha + beta + 1)). We can just equate these to the sample mean and sample variance of the uu values. 
c(mean(uu), var(uu))

# Just need to solve :
# 1. alpha/(alpha + beta) = mean(uu) 
# 2. (alpha beta)/((alpha + beta)^2 (alpha + beta + 1)) = var(uu). 
# Note that mean(uu) is very small (= 9.79e-05) which means that we will have to take alpha << beta (i.e., alpha should be much smaller than beta). In that case, we can simplify the equations slightly by simply taking alpha + beta ~ beta and alpha + beta + 1 ~ beta. This gives simpler equations alpha/beta = mean(uu) and alpha/beta^2 = var(uu). From here alpha and beta can be obtained via: 
alpha = (mean(uu)*mean(uu))/var(uu)
beta = mean(uu)/var(uu)
c(alpha, beta)

#One can check that these also satisfy approximately the original moment equations alpha/(alpha + beta) = mean(uu) and (alpha beta)/((alpha + beta)^2 (alpha + beta + 1)) = var(uu): 
c(alpha/(alpha + beta), (alpha * beta)/((alpha + beta)^2 * (alpha + beta + 1)))
c(mean(uu), var(uu))

#We can check that the resulting Beta(alpha, beta) density pretty closely tracks the distribution of the naive estimates for large counties: 
plot(density(d$thetahat[d$popm > 300000]), ylim = c(0, 18000), main = "Beta density against estimated density for naive estimates (large counties)")
xx = seq(0, 8e-4, 1e-6)
points(xx, dbeta(xx, alpha, beta), type = "l", col = "red")

#Let us look at the Bayes estimates with this Beta prior: (x+alpha)/(n + alpha + beta)
d$thetabayes = (d$dct + alpha)/(d$popm + alpha + beta)
hist(d$thetabayes, breaks = 30)







#Plotting the counties with high / low rates
qb = quantile(d$thetabayes, c(.1, .9))
qb
d$bayeslow = d$thetabayes <= qb[1] #counties with low cancer rate
d$bayeshigh = d$thetabayes >= qb[2] #counties with high cancer rate

#Plotting the counties with high rates
plot_usmap("counties", data = d, values = "bayeshigh", include = statepop$full[-2]) + scale_fill_discrete(h.start = 200, name = "High rate of deaths (Bayesian)")

#lotting the counties with low rates
quartz()
plot_usmap("counties", data = d, values = "bayeslow", include = statepop$full[-2]) + scale_fill_discrete(h.start = 200, name = "Low rate of deaths (Bayesian)")
#the include = statepop$full[-2] clause is included to exclude counties in the state of Alaska for which data are missing
#Now the plots look much different. 



table(d[d$bayeslow,"state"])
table(d[d$bayeshigh,"state"]) 
#This table shows that there are quite a few differences between the high and low counties. For example, Florida has quite a few high rate counties. 



#let us see how the Bayes rule converts prior to posterior for some specific counties:

#Consider the county in row 1682 of the dataset: 
d[1682,] #this is McPherson County in Nebraska with a population (popm) of 1448 and a death count of 1. The naive estimate will classify this as a high risk county. 
#For this county: 
xx = seq(0, 8e-4, 1e-6)
plot(xx, dbeta(xx, alpha, beta), type = "l", col = "red" , main = "prior : red, posterior : black, simple ratio : blue") #prior
#posterior is Beta(x + alpha, n-x + beta) with n = 1448 and x = 1
points(xx, dbeta(xx, (1+alpha), (1448-1+beta)), type = "l") #note how little the posterior changes compared to the prior
abline(v = 1/1448, col = "blue")








# Case study 1: County in row 1625 : Arthur County in Nebraska with a population of 1295 and a death count of 0. The naive estimate will classify this as a low risk county
d[1625,]
xx = seq(0, 8e-4, 1e-6)
plot(xx, dbeta(xx, alpha, beta), type = "l", col = "red", main = 'prior : red, posterior : black') #prior
#posterior is Beta(x + alpha, n-x + beta) with n = 1295 and x = 0
points(xx, dbeta(xx, (0+alpha), (1295-0+beta)), type = "l") #the prior has hardly moved





# Case study 2 :county in row 347 : Sarasota County in Florida with a population of 485595 (roughly half a million) and a death count  of 120. 
xx = seq(0, 8e-4, 1e-6)
plot(xx, dbeta(xx, alpha, beta), type = "l", col = "red", ylim = c(0, 22000)) #prior
#posterior is Beta(x + alpha, n-x + beta) with n = 485595 and x = 120
points(xx, dbeta(xx, (120+alpha), (485595-120+beta)), type = "l") 
abline(v = 120/485595, col = "blue") #Here the prior has moved quite a bit in the direction of the frequency estimate (because this is a large county).



# lesson : if n is low, the posterior approximates the prior while if n is high, the posterior approximates the likelihood.






#the Bayesian estimates are often said to "perform shrinkage". They shrink the frequentist estimates towards the prior. Overall the variability of the Bayes estimates is quite a bit smaller than that of the frequentist estimates: 
h1 = hist(d$thetahat, breaks = 100)
h2 = hist(d$thetabayes, breaks = 100)
plot(h1, main = "Histograms of the Frequentist and Bayesian estimates", xlab = "Estimates")
plot(h2, col = "red", add = TRUE)












#These plots make it clear that the Bayesian estimates are better than the naive ones.

#Repeat the analysis with just the data from 1980-84 and predict the cancer rates for the 1985-89 (
#naive estimates
d$thetahat1 = d$dc/d$pop
#Bayes estimates
#First estimate the prior
uu = d$thetahat1[d$pop > 300000] #these are the naive estimates for large counties (population larger than 200000)
alpha1 = (mean(uu)*mean(uu))/var(uu)
beta1 = mean(uu)/var(uu)
#Bayes estimates with this Beta prior: (x+alpha)/(n + alpha + beta)
d$thetabayes1 = (d$dc + alpha1)/(d$pop + alpha1 + beta1)

#the rates from the second half of the data:
d$thetahat2 = d$dc.2/d$pop.2
c(sum(abs(d$thetahat1 - d$thetahat2)), sum(abs(d$thetabayes1 - d$thetahat2))) #there is an improvement (slight) in the prediction using the Bayes estimates as opposed to the naive estimates.
