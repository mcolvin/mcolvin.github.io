## ----setup---- ##
library(knitr)
#opts_chunk$set(fig.path = "/img/2020-05-23-occupancy-1_files/", dev='png')
# define paths
base.dir <- "C:/Users/mcolvin/Documents/Operations/mcolvin.github.io/"
base.url <- "/"
fig.path <- "img/2020-05-23-occupancy-1_files/"

# set knitr parameters
opts_knit$set(base.dir = base.dir, base.url = base.url)
opts_chunk$set(fig.path = fig.path)    
 
 
 
## ----unnamed-chunk-1---- ##
set.seed(8675309)
 
 
 
## ----unnamed-chunk-2---- ##
# predictive model
beta0<-10
# uncertainty
sigma<-10
# number of outcomes to simulate
N<-1000
# the prediction, using a design matrix
dat<- data.frame(site=rep(1,N))
design_matrix<-model.matrix(~1,dat)
Y_hat<- design_matrix %*% beta0
# some outcomes given the inputs
Y<- rnorm(N,Y_hat,sigma)
 
 
 
## ----unnamed-chunk-3---- ##
hist(Y,xlab="Values")
 
 
 
## ----unnamed-chunk-4---- ##
# uncertainty
sigma<-10
# number of outcomes to simulate
N<-1000
# the prediction, using a design matrix
dat<- data.frame(site=rep(1,N),
    type=sample(c("low","mod","high"),N,replace=TRUE),
    cov=runif(N,-2,2))
dat$type<-as.factor(dat$type)
 
 
 
## ----unnamed-chunk-5---- ##
design_matrix<-model.matrix(~type+cov,dat)
head(design_matrix,10)
 
 
 
## ----unnamed-chunk-6---- ##
betas<-c(10,0.2,-0.5,-0.3)
Y_hat<- design_matrix %*% betas
# some outcomes given the inputs
Y<- rnorm(N,Y_hat,sigma)
 
 
 
## ----unnamed-chunk-7---- ##
# predictive model
beta0<-0.2
# uncertainty
sigma<-10
# number of outcomes to simulate
N<-1000
# the prediction, using a design matrix
dat<- data.frame(site=rep(1,N))
design_matrix<-model.matrix(~1,dat)
Y_hat<- design_matrix %*% beta0
psi<-plogis(Y_hat)
# some outcomes given the inputs
Y<- rbinom(N,1,psi)
 
 
 
## ----unnamed-chunk-8---- ##
table(Y)
 
 
 
## ----unnamed-chunk-9---- ##
# number of outcomes to simulate
N<-1000
# the prediction, using a design matrix
dat<- data.frame(site=rep(1,N),
    type=sample(c("low","mod","high"),N,replace=TRUE),
    cov=runif(N,-2,2))
dat$type<-as.factor(dat$type)
betas<-c(0.2,0.2,-0.5,-0.3)
Y_hat<- design_matrix %*% betas
# some outcomes given the inputs
design_matrix<-model.matrix(~type+cov,dat)
Y_hat<- design_matrix %*% betas
psi<-plogis(Y_hat)
# some outcomes given the inputs
Y<- rbinom(N,1,psi)
 
 
 
## ----unnamed-chunk-10---- ##
table(Y)
 
 
 
## ----unnamed-chunk-11---- ##
hist(psi)
 
 
 
