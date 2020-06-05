---
layout: post
title: Simulating occupancy part 2 
bigimg: /img/big-img/occ-2.png
comments: true
tags: [tutorial, occupancy,JAGS,optim, likelihood]
---






## Overview

This post builds on the previous 
[post](https://mcolvin.github.io/2020-05-23-occupancy-1/)
where the idea of occupancy and how to simulate occupancy data
was presented. We have not yet gotten to imperfect detection and
are still assuming that if one goes out to check a site for 
a critter they will detect the true occupancy state perfectly.
This post will cover how you can fit some models to occupancy 
data (i.e., 0s and 1s) by maximum likelihood. There are certainly
existing functions to do this but the methods presented below
are a DIY approach to increase understanding. 

## Objectives

The objectives of this post is to 

1. Simulate some occupancy data given 2 covariates
2. Fit the occupancy data to a model using
    1. a grid search
    2. the optim function
    3. Markov Chain Monte Carlo in JAGS
3. [R script for this document](/img/2020-06-05-occupancy-part-2_files/2020-05-23-occupancy-1.R)

We will be assuming perfect detection (i.e., critters are detected given 
they are present at a site) and relaxing that in future posts. 


## Simulating some occupancy data

Getting started we will need to simulate some occupancy data for 100 
sites with 2 covariates, temperature and elevation. The code chunk below 
does that. 


```r
N<-500
dat<- data.frame(temperature=runif(N,10,23),
    elevation=runif(N,55,120))
```

We will set the betas for simulating occurrence probabilities.


```r
beta<- c(-3,-0.02,0.03)
```

And then combine the betas and a design matrix to get log odds
and then transform them to a probability.


```r
design_matrix<-model.matrix(~temperature+elevation, dat)
dat$y<-design_matrix%*%beta
dat$p<- plogis(dat$y)
```

Lastly, the `rbinom` function is used to simulate the occurrence
outcome assuming a binomial distribution. 


```r
dat$occurrence<- rbinom(N,1,dat$p)
```


## Fitting a model to occupancy data

Fitting a model to the occupancy data needs the 3 parts discussed in the 
first post: 1) a predictive model, 2) a statistical model that links the 
predictions to observations as probabilistic outcomes, and 3) some 
observed data. In short we will be: 

* trying different combinations of $$\beta_0$$, $$\beta_1$$, and $$\beta_2$$, 
* calculating the sum of the log of the likelihood of the observations 
given the values of $$\beta_0$$, $$\beta_1$$, and $$\beta_2$$, and then 
* returning the values of $$\beta_0$$, $$\beta_1$$, and $$\beta_2$$ that 
maximize the sum of the log likelihood of each site. 


The first thing needed is a function that takes values of $$\beta_0$$, 
$$\beta_1$$, and $$\beta_2$$ and returns the sum of log likelihoods for each 
site. 

First a bit on the likelihood. The likelihood is the probability of an
outcome given a distribution and parameter inputs. For example, 
the outcomes of a binomial process it easy to calculate the 
probability of an outcome. Assume the probability of flipping 
a fair coin is 50:50. Therefore the likelihood of observing
a head is 0.5 and a tail is 0.5. We can specify this in R
as 


```r
head<-1 # success
tail<-0 # failure
p<-0.5 # probability of success
dbinom(head,1,p)
```

```
## [1] 0.5
```

```r
dbinom(tail,1,p)
```

```
## [1] 0.5
```

The likelihoods returned from the `dbinom` function are 0.5 and 0.5 as 
expect for a head or a tail. If the coin was unfair, for example if the
probability of success (getting a head) is 0.7. And suppose there is 
vector of outcomes for 4 trials. The code below will return the likelihood
for each of the outcomes.


```r
head<-1 # success
tail<-0 # failure
p<-0.7 # probability of success
x<-c(head,head,head,tail)
dbinom(x,1,p)
```

```
## [1] 0.7 0.7 0.7 0.3
```

Since these likelihoods represent probabilities the probability of
observing the 4 outcomes is the product of the 4 likelihoods.


```r
prod(dbinom(x,1,p))
```

```
## [1] 0.1029
```

If you add more data the probability becomes smaller which can 
lead to rounding problems. 


```r
x<-c(head,head,head,tail,tail,tail,head,tail)
prod(dbinom(x,1,p))
```

```
## [1] 0.00194481
```

So by the law of logarithms if you take the log of each probability
they can be summed together which is the same as the product of the 
probability but on log scale. 


```r
x<-c(head,head,head,tail,tail,tail,head,tail)
overall_lik<-prod(dbinom(x,1,p))
overall_log_lik<-sum(dbinom(x,1,p,log=TRUE))
overall_lik
```

```
## [1] 0.00194481
```

```r
overall_log_lik
```

```
## [1] -6.242591
```

```r
exp(overall_log_lik)
```

```
## [1] 0.00194481
```

The log likelihood for the product and the sum are the same when back 
transformed from log scale. 
transformed from log scale. 

### A function to return the likelihood

The function will have 2 inputs, a vector of $$\beta$$ and a dataset of 
observed presence and absences at each site as 0s and 1s an the 
associated site level covariates. The function will return the sum of 
the log likelihood for each site. 



```r
log_likelihood<-function(betas,data)
    {
    occurrence<-data$occurrence
    design_matrix<- model.matrix(~temperature+elevation,data)
    y<-design_matrix%*%betas #some useful matrix multiplication
    p<-plogis(y) #need to convert to a probability
    sum_log_like<- sum(dbinom(occurrence,1,p))
    return(sum_log_like)
    } 
```

The function above takes a vector of betas as an input and some 
data and returns the sum of the log likelihood of each site. Let's give it a try with a vector
of possible values for $$\beta$$. 


```r
log_likelihood(betas=c(-2,0.01,0.02),
    data=dat)
```

```
## [1] 260.6282
```

Let's see what the likelihood is for the true values. 


```r
log_likelihood(betas=c(-3,-0.02,0.03),
    data=dat)
```

```
## [1] 289.2347
```
The value is higher, which is good, it should be as we are trying combinations of
values for $$\beta$$ that maximize the log likelihood.
 

An iterative approach to inputting of values is now needed to identify which $$\beta$$  values 
maximize the log likelihood. 

### Grid search

One way to iterate over the 3 $$\beta$$ values we are interested in is to 
do a grid search. A grid search sets up a all possible combination of 
possible $$\beta$$ values and applies the ˋlog_likelihoodˋ function to each 
combination. Then you find the combination of parameters that resulted in
the highest log likelihood. The code chunk below sets values for each $$\beta$$ 
that varies from -6 to 6 by increments of 0.1 and evaluates each combination. 



```r
vals<-seq(-6,6,by=0.5)
combos<- expand.grid(b0=vals, b1=vals, b2=vals)
combos$ll<-sapply(1:nrow(combos),function(x)
    {
    ll<-log_likelihood(beta=c(unlist(combos[x,])),
        data=dat)
    return(ll)
    })
```


Now identify the combination of $$\beta$$s that maximize the log likihood. 


```r
combos[which.max(combos$ll),]
```

```
##      b0 b1  b2       ll
## 8236 -1 -4 0.5 350.3716
```


The values are not even in the ball park of 
the values used to simulate the data 
and it took a long time to evaluate a 
the combinations even at a relatively coarse
resolution. That is an issue of a grid search,
you need to keep reducing the step size to 
find the combination of $$\beta$$ that maximizes 
the likelihood, but if you stare in the wrong
spot like -6, -5 and 1 you are probably not 
going to get where you need to be. An 
optimization algorithm solves this issue. 

### Maximum likelihood

The ˋoptimˋ function in ˋRˋ will take the log_likelihood 
function and search for the combination of $$\beta$$ that 
maximizes the log likelihood. The ˋoptimˋ function can 
use a number of different optimizers like the Nelder Mead, 
Simulated Annealing, or BFGS to name a couple. The BFGS 
works well in my experience and we will use it below.  



```r
log_likelihood<-function(betas,data)
    {
    occurrence<-data$occurrence
    design_matrix<- model.matrix(~temperature+elevation,data)
    y<-design_matrix%*%betas #some useful matrix multiplication
    p<-plogis(y) #need to convert to a probability
    #p<-sapply(p,function(x) min(max(x,0.00001),0.99999))
    sum_log_like<- sum(dbinom(occurrence,1,p,log=TRUE))
    return(-1*sum_log_like)
    }
fit<-optim(par=c(0,0,0),
    fn=log_likelihood,
    data=dat,
    method = "BFGS")
```



Before looking at the parameter estimates we want to make sure the optimization converged. 

Since the convergence value was 0 things are ok for convergence and we can look 
at the parameter estimates. 


```r
fit$convergence
```

```
## [1] 0
```

It returns a 0 so the convergence is good. Below are the parameter  
estimates and the negative log likelihood


```r
fit$par
```

```
## [1] -0.94428320 -0.08871848  0.01897360
```

```r
fit$value
```

```
## [1] 303.3406
```


Those values are darn close to the parameters used to simulate the data, very nice. 

### Maximum likelihood by MCMC

The model can also be fit to data by Markov Chain Monte Carlo sampling 
to find the combinations of parameters that maximize the log likelihood. 
The MCMC can be implemented in JAGS. In simple terms when fitting a 
model using MCMC, prior distributions of each parameter are set and a 
combination of $$\beta$$ is then used to the calculate the likelihood and 
then accepted or rejected given some probability. After a burnin period 
the MCMC should be converged and each iteration represents a draw from 
the posterior distributions of each parameter which will be used for 
inference. JAGS takes a model that can be defined in R and then performs 
the MCMC using an external program JAGS. 


The function below is the model that JAGS will use to estimate the parameters.


```r
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
```

Now the data is set up as a list. There needs to be the following objects in
the list: `N`, `X`, and `occurrence`.


```r
jags_dat<-list(
    X=model.matrix(~temperature+elevation,dat),
    occurrence=dat$occurrence,
    N=length(dat$occurrence))
```

It is also good practice to set initial values for the $$\beta$$ values.


```r
inits<-function(){list(beta=rnorm(3,0,0.1))}
```

Now we can feed this information into JAGS to fit the model.


```r
library(R2jags)
fit<-jags(data=jags_dat, 
    inits=inits, 
    parameters.to.save=c("beta"), 
    model.file=model,
    n.chains=3, 
    n.iter=2000, 
    n.burnin=1000,
    n.thin=1,
    progress.bar = "none")
```

```
## Compiling model graph
##    Resolving undeclared variables
##    Allocating nodes
## Graph information:
##    Observed stochastic nodes: 500
##    Unobserved stochastic nodes: 3
##    Total graph size: 3507
## 
## Initializing model
```

```r
fit
```

```
## Inference for Bugs model at "C:/Users/mcolvin/AppData/Local/Temp/RtmpEBOZLm/model4640f2f1378.txt", fit using jags,
##  3 chains, each with 2000 iterations (first 1000 discarded)
##  n.sims = 3000 iterations saved
##          mu.vect sd.vect    2.5%     25%     50%     75%   97.5%  Rhat
## beta[1]   -0.947   0.694  -2.259  -1.423  -0.947  -0.483   0.408 1.001
## beta[2]   -0.090   0.031  -0.144  -0.108  -0.089  -0.070  -0.036 1.016
## beta[3]    0.019   0.006   0.008   0.015   0.019   0.023   0.030 1.001
## deviance 612.234  56.477 606.913 607.951 609.142 610.898 616.547 1.050
##          n.eff
## beta[1]   2400
## beta[2]   1700
## beta[3]   3000
## deviance  3000
## 
## For each parameter, n.eff is a crude measure of effective sample size,
## and Rhat is the potential scale reduction factor (at convergence, Rhat=1).
## 
## DIC info (using the rule, pD = var(deviance)/2)
## pD = 1595.2 and DIC = 2207.4
## DIC is an estimate of expected predictive error (lower deviance is better).
```
