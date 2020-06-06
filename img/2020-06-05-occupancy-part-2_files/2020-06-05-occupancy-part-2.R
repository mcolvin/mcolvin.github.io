## ----setup---- ##
library(knitr)
base.dir <- "C:/Users/mcolvin/Documents/Operations/mcolvin.github.io/"
base.url <- "/"
fig.path <- "img/2020-06-05-occupancy-part-2_files/"
opts_knit$set(base.dir = base.dir, base.url = base.url)
opts_chunk$set(fig.path = fig.path)    
 
 
 
## ----unnamed-chunk-1---- ##
N<-500
dat<- data.frame(temperature=runif(N,10,23),
    elevation=runif(N,55,120))
 
 
 
## ----unnamed-chunk-2---- ##
beta<- c(-3,-0.02,0.03)
 
 
 
## ----unnamed-chunk-3---- ##
design_matrix<-model.matrix(~temperature+elevation, dat)
dat$y<-design_matrix%*%beta
dat$p<- plogis(dat$y)
 
 
 
## ----unnamed-chunk-4---- ##
dat$occurrence<- rbinom(N,1,dat$p)
 
 
 
## ----unnamed-chunk-5---- ##
head<-1 # success
tail<-0 # failure
p<-0.5 # probability of success
dbinom(head,1,p)
dbinom(tail,1,p)
 
 
 
## ----unnamed-chunk-6---- ##
head<-1 # success
tail<-0 # failure
p<-0.7 # probability of success
x<-c(head,head,head,tail)
dbinom(x,1,p)
 
 
 
## ----unnamed-chunk-7---- ##
prod(dbinom(x,1,p))
 
 
 
## ----unnamed-chunk-8---- ##
x<-c(head,head,head,tail,tail,tail,head,tail)
prod(dbinom(x,1,p))
 
 
 
## ----unnamed-chunk-9---- ##
x<-c(head,head,head,tail,tail,tail,head,tail)
overall_lik<-prod(dbinom(x,1,p))
overall_log_lik<-sum(dbinom(x,1,p,log=TRUE))
overall_lik
overall_log_lik
exp(overall_log_lik)
 
 
 
## ----unnamed-chunk-10---- ##
log_likelihood<-function(betas,data)
    {
    occurrence<-data$occurrence
    design_matrix<- model.matrix(~temperature+elevation,data)
    y<-design_matrix%*%betas #some useful matrix multiplication
    p<-plogis(y) #need to convert to a probability
    sum_log_like<- sum(dbinom(occurrence,1,p,log=TRUE))
    return(sum_log_like)
    } 
 
 
 
## ----unnamed-chunk-11---- ##
log_likelihood(betas=c(-2,0.01,0.02),
    data=dat)
 
 
 
## ----unnamed-chunk-12---- ##
log_likelihood(betas=c(-3,-0.02,0.03),
    data=dat)
 
 
 
## ----unnamed-chunk-13---- ##
vals<-seq(-6,6,by=0.5)
combos<- expand.grid(b0=vals, b1=vals, b2=vals)
combos$ll<-sapply(1:nrow(combos),function(x)
    {
    ll<-log_likelihood(beta=c(unlist(combos[x,])),
        data=dat)
    return(ll)
    })
 
 
 
## ----unnamed-chunk-14---- ##
combos[which.max(combos$ll),]
 
 
 
## ----unnamed-chunk-15---- ##
log_likelihood<-function(betas,data)
    {
    occurrence<-data$occurrence
    design_matrix<- model.matrix(~temperature+elevation,data)
    y<-design_matrix%*%betas #some useful matrix multiplication
    p<-plogis(y) #need to convert to a probability
    sum_log_like<- sum(dbinom(occurrence,1,p,log=TRUE))
    return(-1*sum_log_like)
    }
fit<-optim(par=c(0,0,0),
    fn=log_likelihood,
    data=dat,
    method = "BFGS")
 
 
 
## ----unnamed-chunk-16---- ##
fit$convergence
 
 
 
## ----unnamed-chunk-17---- ##
fit$par
fit$value
 
 
 
## ----unnamed-chunk-18---- ##
model<-function()
    {
    for(i in 1:N)
        {
        # predict the probability of occurrence
        logit(p[i])<- inprod(X[i,],beta[])
        # observation model 
        occurrence[i]~dbern(p[i])
        }
    # priors for beta
    for(k in 1:3)
        {
        beta[k]~dnorm(0,0.001)
        }
    } 
 
 
 
## ----unnamed-chunk-19---- ##
jags_dat<-list(
    X=model.matrix(~temperature+elevation,dat),
    occurrence=dat$occurrence,
    N=length(dat$occurrence))
 
 
 
## ----unnamed-chunk-20---- ##
inits<-function(){list(beta=rnorm(3,0,0.1))}
 
 
 
## ----unnamed-chunk-21---- ##
library(R2jags)
jags_fit<-jags(data=jags_dat, 
    inits=inits, 
    parameters.to.save=c("beta"), 
    model.file=model,
    n.chains=3, 
    n.iter=2000, 
    n.burnin=1000,
    n.thin=1,
    progress.bar = "none")
jags_fit
jags_fit$BUGSoutput$mean
 
 
 
