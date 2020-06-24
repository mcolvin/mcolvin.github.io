## ----setup---- ##
library(knitr)
base.dir <- "C:/Users/mcolvin/Documents/Operations/mcolvin.github.io/"
base.url <- "/"
fig.path <- "img/2020-06-24-bdn-in-r_files/"
opts_knit$set(base.dir = base.dir, base.url = base.url)
opts_chunk$set(fig.path = fig.path)    
 
 
 
## ----unnamed-chunk-1---- ##
library(openxlsx)
 
 
 
## ----unnamed-chunk-2---- ##
A<-read.xlsx("bdn-tables.xlsx",sheet="current number wetlands")
A[,-c(1)]<-A[,-c(1)]/100
 
 
 
## ----unnamed-chunk-3---- ##
A
 
 
 
## ----unnamed-chunk-4---- ##
B<-read.xlsx("bdn-tables.xlsx",sheet="number of wetlands")
B[,-c(1:2)]<-B[,-c(1:2)]/100
C<-read.xlsx("bdn-tables.xlsx",sheet="Current wetland colonization pr")
C[,-1]<-C[,-1]/100
D<-read.xlsx("bdn-tables.xlsx",sheet="Wetland colonization probabilit")
D[,-c(1:2)]<-D[,-c(1:2)]/100
E<-read.xlsx("bdn-tables.xlsx",sheet="Wetland persistence probability")
E[,-1]<-E[,-1]/100
F<-read.xlsx("bdn-tables.xlsx",sheet="prob. spp. persistence")
 
 
 
## ----unnamed-chunk-5---- ##
B
 
 
 
## ----unnamed-chunk-6---- ##
# marginal probabilities for B
B_mp<-t(B[,-c(1,2)])%*%A[,-1] ## probability of each outcome given the inputs
# divide by the sum to 
B_mp<-B_mp/sum(B_mp) # the denominator is the marginal likelihood, serves to normalize and sum to 1
# for easy handling later.
B_mp<-data.frame(state=names(B[,-c(1,2)]),prob=B_mp)
 
 
 
## ----unnamed-chunk-7---- ##
B_mp
 
 
 
## ----unnamed-chunk-8---- ##
# marginal probabilities for D
D_mp<- t(D[,-c(1,2)])%*%C[,-1]
D_mp<-D_mp/sum(D_mp)
D_mp<-data.frame(state=names(D[,-c(1,2)]),prob=D_mp)
D_mp
 
 
 
## ----unnamed-chunk-9---- ##
# marginal probabilities for F
parents<-list(D_mp,B_mp,E)
tmp <- lapply(parents,function(x){1:nrow(x)})
tmp<- expand.grid(tmp)
 
 
 
## ----unnamed-chunk-10---- ##
tmp<- tmp[order(tmp[,1],tmp[,2],tmp[,3]),]
 
 
 
## ----unnamed-chunk-11---- ##
parents_probs<- tmp
parents_probs[,1]<- parents[[1]][tmp[,1],]$prob
parents_probs[,2]<- parents[[2]][tmp[,2],]$prob
parents_probs[,3]<- parents[[3]][tmp[,3],]$prob
 
 
 
## ----unnamed-chunk-12---- ##
sum(apply(parents_probs,1,prod))
 
 
 
## ----unnamed-chunk-13---- ##
F_mp<- t(F[,-c(1:3)])%*%apply(parents_probs,1,prod)
F_mp<-F_mp/sum(F_mp)
F_mp
 
 
 
## ----unnamed-chunk-14---- ##
U<-F_mp*100
U
 
 
 
## ----unnamed-chunk-15---- ##
# utility values: H
U<- rep(0,2) # utility for each decision
 
 
 
## ----unnamed-chunk-16---- ##
## decision == improve connectivity
decision<-"Improve connectivity"
# marginal probabilities for B
dec<-ifelse(B[,1]==decision,1,0)
B_mp<-t(B[,-c(1,2)]*dec)%*%A[,-1]
B_mp<-B_mp/sum(B_mp)
B_mp<-data.frame(state=names(B[,-c(1,2)]),prob=B_mp)
### marginal probabilities for D
dec<-ifelse(D[,1]==decision,1,0)
D_mp<- t(D[,-c(1,2)]*dec)%*%C[,-1]
D_mp<-D_mp/sum(D_mp)
D_mp<-data.frame(state=names(D[,-c(1,2)]),prob=D_mp)
### marginal probabilities for F
parents<-list(D_mp,B_mp,E)
tmp <- lapply(parents,function(x){1:nrow(x)})
tmp<- expand.grid(tmp)
tmp<- tmp[order(tmp[,1],tmp[,2],tmp[,3]),]
parents_probs<- tmp
parents_probs[,1]<- parents[[1]][tmp[,1],]$prob
parents_probs[,2]<- parents[[2]][tmp[,2],]$prob
parents_probs[,3]<- parents[[3]][tmp[,3],]$prob
F_mp<- t(F[,-c(1:3)])%*%apply(parents_probs,1,prod)
F_mp<-F_mp/sum(F_mp)
 
 
 
## ----unnamed-chunk-17---- ##
U[1]<- F_mp[1]*100
 
 
 
## ----unnamed-chunk-18---- ##
## decision == restore wetlands
decision<-"Restore wetlands"
# marginal probabilities for B
dec<-ifelse(B[,1]==decision,1,0)
B_mp<-t(B[,-c(1,2)]*dec)%*%A[,-1]
B_mp<-B_mp/sum(B_mp)
B_mp<-data.frame(state=names(B[,-c(1,2)]),prob=B_mp)
### marginal probabilities for D
dec<-ifelse(D[,1]==decision,1,0)
D_mp<- t(D[,-c(1,2)]*dec)%*%C[,-1]
D_mp<-D_mp/sum(D_mp)
D_mp<-data.frame(state=names(D[,-c(1,2)]),prob=D_mp)
### marginal probabilities for F
parents<-list(D_mp,B_mp,E)
tmp <- lapply(parents,function(x){1:nrow(x)})
tmp<- expand.grid(tmp)
tmp<- tmp[order(tmp[,1],tmp[,2],tmp[,3]),]
parents_probs<- tmp
parents_probs[,1]<- parents[[1]][tmp[,1],]$prob
parents_probs[,2]<- parents[[2]][tmp[,2],]$prob
parents_probs[,3]<- parents[[3]][tmp[,3],]$prob
F_mp<- t(F[,-c(1:3)])%*%apply(parents_probs,1,prod)
F_mp<-F_mp/sum(F_mp)
 
 
 
## ----unnamed-chunk-19---- ##
U[2]<- F_mp[1]*100
 
 
 
## ----unnamed-chunk-20---- ##
U
 
 
 
