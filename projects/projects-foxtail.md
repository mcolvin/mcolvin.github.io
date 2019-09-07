---
layout: page
title: Modeling Giant foxtail populations in varying crop rotations
bigimg: /img/foxtail.jpg
---



This is a collaborative project with Robin Gomez a PhD student in 
Agronomy at Iowa State University. We are using periodic matrix models 
to evaluate the sensitivity of the giant foxtail seed bank to varying 
crop rotation length (2 and 4 year) and cover crop type (corn, soybean, 
alfalfa, small grain). 

The first work is targeted to be published in Weed Science
Some useful code

    twoYearMatPerm<- function(xx){                                                                                                                     <br>
        startIndex<- match(xx, c(1:12))                                                                                                                <br>
        permOrder<- 0                                                                                                                                  <br>
        if(startIndex==1){permOrder<-c(12:startIndex)}                                                                                                 <br>
        if(startIndex!=1){permOrder<-c(c((startIndex-1):1),c(12:startIndex))}                                                                          <br>
        B<- two_year[,,permOrder[1]]%*% two_year[,,permOrder[2]]%*% two_year[,,permOrder[3]]%*%                                                        <br>
            two_year[,,permOrder[4]]%*% two_year[,,permOrder[5]]%*% two_year[,,permOrder[6]]%*%                                                        <br>
            two_year[,,permOrder[7]]%*% two_year[,,permOrder[8]]%*% two_year[,,permOrder[9]]%*%                                                        <br>
            two_year[,,permOrder[10]]%*% two_year[,,permOrder[11]]%*% two_year[,,permOrder[12]]	                                                       <br>
        return(B)                                                                                                                                      <br>
        }                                                                                                                                              <br>
                                                                                                                                                       <br>
    twoYearMatPerm_D <- function(xx){                                                                                                                  <br>
        startIndex<- match(xx, c(1:12))                                                                                                                <br>
        permOrder<- 0                                                                                                                                  <br>
        if(startIndex==1){permOrder<-c(12:startIndex)}                                                                                                 <br>
        if(startIndex!=1){permOrder<-c(c((startIndex-1):1),c(12:startIndex))}                                                                          <br>
        permOrder = permOrder[-12]                                                                                                                     <br>
        D<- two_year[,,permOrder[1]]%*% two_year[,,permOrder[2]]%*% two_year[,,permOrder[3]]%*%                                                        <br>
            two_year[,,permOrder[4]]%*% two_year[,,permOrder[5]]%*% two_year[,,permOrder[6]]%*%                                                        <br>
            two_year[,,permOrder[7]]%*% two_year[,,permOrder[8]]%*% two_year[,,permOrder[9]]%*%                                                        <br>
            two_year[,,permOrder[10]]%*% two_year[,,permOrder[11]]	                                                                                   <br>
        return(D)                                                                                                                                      <br>
        }                                                                                                                                              <br>
                                                                                                                                                       <br>
    twoYear_s_e<- function(period){                                                                                                                    <br>
        B<- inputMatrix<- twoYearMatPerm(period)                                                                                                       <br>
        w=eigen(B)$vectors[,1]; w=w/sum(w);                                                                                                            <br>
        v=eigen(t(B))$vectors[,1]; v=v/v[1];                                                                                                           <br>
        s_B<- outer(v,w)/sum(v*w);                                                                                                                     <br>
        D<- twoYearMatPerm_D(period)                                                                                                                   <br>
        s_B<- t(D)%*%s_B                                                                                                                               <br>
        e_B<- (1/lambda_two_year) * two_year[,,period]  * s_B	                                                                                       <br>
        return(list(elasticity= e_B))                                                                                                                  <br>
        }                                                                                                                                              <br>
                                                                                                                                                       <br>
    fourYearMatPerm<- function(xx){                                                                                                                    <br>
        startIndex<- match(xx, c(1:24))                                                                                                                <br>
        permOrder<- 0                                                                                                                                  <br>
        if(startIndex==1){permOrder<-c(24:startIndex)}                                                                                                 <br>
        if(startIndex!=1){permOrder<-c(c((startIndex-1):1),c(24:startIndex))}                                                                          <br>
        B<- four_year[,,permOrder[1]] %*% four_year[,,permOrder[2]] %*% four_year[,,permOrder[3]] %*%                                                  <br>
            four_year[,,permOrder[4]] %*% four_year[,,permOrder[5]] %*% four_year[,,permOrder[6]] %*%                                                  <br>
            four_year[,,permOrder[7]] %*% four_year[,,permOrder[8]] %*% four_year[,,permOrder[9]] %*%                                                  <br>
            four_year[,,permOrder[10]]%*% four_year[,,permOrder[11]]%*% four_year[,,permOrder[12]]%*%	                                               <br>
            four_year[,,permOrder[13]]%*% four_year[,,permOrder[14]]%*% four_year[,,permOrder[15]]%*%	                                               <br>
            four_year[,,permOrder[16]]%*% four_year[,,permOrder[17]]%*% four_year[,,permOrder[18]]%*%	                                               <br>
            four_year[,,permOrder[19]]%*% four_year[,,permOrder[20]]%*% four_year[,,permOrder[21]]%*%	                                               <br>
            four_year[,,permOrder[22]]%*% four_year[,,permOrder[23]]%*% four_year[,,permOrder[24]]	                                                   <br>
        return(B)                                                                                                                                      <br>
        }                                                                                                                                              <br>
                                                                                                                                                       <br>
    fourYearMatPerm_D<- function(xx){                                                                                                                  <br>
        startIndex<- match(xx, c(1:24))                                                                                                                <br>
        permOrder<- 0                                                                                                                                  <br>
        if(startIndex==1){permOrder<-c(24:startIndex)}                                                                                                 <br>
        if(startIndex!=1){permOrder<-c(c((startIndex-1):1),c(24:startIndex))}                                                                          <br>
        permOrder= permOrder[-24]                                                                                                                      <br>
        B<- four_year[,,permOrder[1]] %*% four_year[,,permOrder[2]] %*% four_year[,,permOrder[3]] %*%                                                  <br>
            four_year[,,permOrder[4]] %*% four_year[,,permOrder[5]] %*% four_year[,,permOrder[6]] %*%                                                  <br>
            four_year[,,permOrder[7]] %*% four_year[,,permOrder[8]] %*% four_year[,,permOrder[9]] %*%                                                  <br>
            four_year[,,permOrder[10]]%*% four_year[,,permOrder[11]]%*% four_year[,,permOrder[12]]%*%	                                               <br>
            four_year[,,permOrder[13]]%*% four_year[,,permOrder[14]]%*% four_year[,,permOrder[15]]%*%	                                               <br>
            four_year[,,permOrder[16]]%*% four_year[,,permOrder[17]]%*% four_year[,,permOrder[18]]%*%	                                               <br>
            four_year[,,permOrder[19]]%*% four_year[,,permOrder[20]]%*% four_year[,,permOrder[21]]%*%	                                               <br>
            four_year[,,permOrder[22]]%*% four_year[,,permOrder[23]]                                                                                   <br>
        return(B)                                                                                                                                      <br>
        }                                                                                                                                              <br>
                                                                                                                                                       <br>
    fourYear_s_e<- function(period){                                                                                                                   <br>
        B<- inputMatrix<- fourYearMatPerm(period)                                                                                                      <br>
        w=eigen(B)$vectors[,1]; w=w/sum(w);                                                                                                            <br>
        v=eigen(t(B))$vectors[,1]; v=v/v[1];                                                                                                           <br>
        s_B<- outer(v,w)/sum(v*w);                                                                                                                     <br>
        D<- fourYearMatPerm_D(period)                                                                                                                  <br>
        s_B<- t(D)%*%s_B                                                                                                                               <br>
        e_B<- (1/lambda_four_year) * four_year[,,period]  * s_B	                                                                                       <br>
        return(list(elasticity= e_B))                                                                                                                  <br>
        }                                                                                                                                              <br>
                                                                                                                                                       <br>
    fourYearReproductiveValues<- function(period){                                                                                                     <br>
        B<- inputMatrix<- fourYearMatPerm(period)                                                                                                      <br>
        w=eigen(B)$vectors[,1]; 	# EXTRACT RIGHT EIGENVECTOR (STABLE AGE DISTRIBUTION)                                                              <br>
        w=w/sum(w);					# NORMALIZE RIGHT EIGENVECTOR TO SUM TO ONE                                                                        <br>
        v=eigen(t(B))$vectors[,1]; 	# EXTRACT LEFT EIGENVECTOR (REPRODUCTIVE VALUE OF SEED LAYER)                                                      <br>
        v=v/v[1];					# LEFT EIGENVECTOR RELATIVE TO FIRST LAYER                                                                         <br>
        x<- data.frame(Rotation = "4 year", Phase = period,Layer=c("Surface","1-10 cm","11-20 cm"), DepthDistriubtion = w[1:3], ReproductiveValaue = v[<br>1:3])
        return(x)                                                                                                                                      <br>
        }                                                                                                                                              <br>
                                                                                                                                                       <br>
    two_year_sim<- function(startingVector, nrotations){                                                                                               <br>
        XX<- matrix(0,nrow=5, ncol=(nrotations*12+1))                                                                                                  <br>
        XX[,1]<- startingVector                                                                                                                        <br>
        j<- 1;	i<- 2                                                                                                                                  <br>
        for(j in 1:nrotations) {                                                                                                                       <br>
            XX[,i]<- two_year[,,1]%*%XX[,i-1]                                                                                                          <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- two_year[,,2]%*%XX[,i-1]                                                                                                          <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- two_year[,,3]%*%XX[,i-1]                                                                                                          <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- two_year[,,4]%*%XX[,i-1]                                                                                                          <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- two_year[,,5]%*%XX[,i-1]                                                                                                          <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- two_year[,,6]%*%XX[,i-1]                                                                                                          <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- two_year[,,7]%*%XX[,i-1]                                                                                                          <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- two_year[,,8]%*%XX[,i-1]                                                                                                          <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- two_year[,,9]%*%XX[,i-1]                                                                                                          <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- two_year[,,10]%*%XX[,i-1]                                                                                                         <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- two_year[,,11]%*%XX[,i-1]                                                                                                         <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- two_year[,,12]%*%XX[,i-1]                                                                                                         <br>
                i<- i+1                                                                                                                                <br>
            }                                                                                                                                          <br>
        ret<- XX[,c(1:(12*nrotations))]                                                                                                                <br>
        # SET UP SOME MONTHS FOR PLOTTING PURPOSES                                                                                                     <br>
        tim<- data.frame(time=sort(rep(seq(0,nrotations*2-1,by=2),12)))                                                                                <br>
        tim$time<- tim$time+ rep(c(                                                                                                                    <br>
        1+10/12,1+11/12,1+12/12,2+4/12,2+6/12,2+10/12,                                                                                                 <br>
        2+10/12,2+11/12,2+12/12,3+4/12,3+6/12,3+10/12),nrotations)                                                                                     <br>
        tim$crop<- rep(c(rep("corn",6),rep("soybeans",6)),nrotations)                                                                                  <br>
        dat<- data.frame(cbind(tim, t(ret)))                                                                                                           <br>
        dat$Seq<- rep(rep(c(1:6),2),nrotations)                                                                                                        <br>
        names(dat)<- c("Time","Crop","surfaceSeeds","seedsTen","seedsTwenty","Seedlings","maturePlants","Seq")                                         <br>
        return(dat)                                                                                                                                    <br>
        }                                                                                                                                              <br>
                                                                                                                                                       <br>
    four_year_sim<- function(startingVector, nrotations){                                                                                              <br>
        XX<- matrix(0,nrow=5, ncol=(nrotations*24+1))                                                                                                  <br>
        XX[,1]<- startingVector                                                                                                                        <br>
        j<- 1;	i<- 2                                                                                                                                  <br>
        for(j in 1:nrotations) {                                                                                                                       <br>
            # CORN                                                                                                                                     <br>
            XX[,i]<- four_year[,,1]%*%XX[,i-1]                                                                                                         <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- four_year[,,2]%*%XX[,i-1]                                                                                                         <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- four_year[,,3]%*%XX[,i-1]                                                                                                         <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- four_year[,,4]%*%XX[,i-1]                                                                                                         <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- four_year[,,5]%*%XX[,i-1]                                                                                                         <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- four_year[,,6]%*%XX[,i-1]                                                                                                         <br>
                i<- i+1                                                                                                                                <br>
            # SOYBEAN                                                                                                                                  <br>
            XX[,i]<- four_year[,,7]%*%XX[,i-1]                                                                                                         <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- four_year[,,8]%*%XX[,i-1]                                                                                                         <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- four_year[,,9]%*%XX[,i-1]                                                                                                         <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- four_year[,,10]%*%XX[,i-1]                                                                                                        <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- four_year[,,11]%*%XX[,i-1]                                                                                                        <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- four_year[,,12]%*%XX[,i-1]                                                                                                        <br>
                i<- i+1                                                                                                                                <br>
            # SMALL GRAIN/ALFALFA                                                                                                                      <br>
            XX[,i]<- four_year[,,13]%*%XX[,i-1]                                                                                                        <br>
                i<- i+1			                                                                                                                       <br>
            XX[,i]<- four_year[,,14]%*%XX[,i-1]                                                                                                        <br>
                i<- i+1			                                                                                                                       <br>
            XX[,i]<- four_year[,,15]%*%XX[,i-1]                                                                                                        <br>
                i<- i+1			                                                                                                                       <br>
            XX[,i]<- four_year[,,16]%*%XX[,i-1]                                                                                                        <br>
                i<- i+1			                                                                                                                       <br>
            XX[,i]<- four_year[,,17]%*%XX[,i-1]                                                                                                        <br>
                i<- i+1			                                                                                                                       <br>
            XX[,i]<- four_year[,,18]%*%XX[,i-1]                                                                                                        <br>
                i<- i+1		                                                                                                                           <br>
            # ALFALFA                                                                                                                                  <br>
            XX[,i]<- four_year[,,19]%*%XX[,i-1]                                                                                                        <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- four_year[,,20]%*%XX[,i-1]                                                                                                        <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- four_year[,,21]%*%XX[,i-1]                                                                                                        <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- four_year[,,22]%*%XX[,i-1]                                                                                                        <br>
                i<- i+1			                                                                                                                       <br>
            XX[,i]<- four_year[,,23]%*%XX[,i-1]                                                                                                        <br>
                i<- i+1                                                                                                                                <br>
            XX[,i]<- four_year[,,24]%*%XX[,i-1]                                                                                                        <br>
                i<- i+1		                                                                                                                           <br>
            }	                                                                                                                                       <br>
        ret<- XX[,c(1:(24*nrotations))]                                                                                                                <br>
        # SET UP SOME MONTHS FOR PLOTTING PURPOSES                                                                                                     <br>
        tim<- data.frame(time=sort(rep(seq(0,nrotations*4-1,by=4),24)))                                                                                <br>
        tim$time<- tim$time+ rep(c(                                                                                                                    <br>
        1+10/12,1+11/12,1+12/12,2+4/12,2+6/12,2+10/12,                                                                                                 <br>
        2+10/12,2+11/12,2+12/12,3+4/12,3+6/12,3+10/12,                                                                                                 <br>
        3+10/12,3+11/12,3+12/12,4+4/12,4+6/12,4+10/12,	                                                                                               <br>
        4+10/12,4+11/12,4+12/12,5+4/12,5+6/12,5+10/12),nrotations)                                                                                     <br>
        tim$crop<- rep(c(rep("corn",6),rep("soybeans",6),rep("small grain/alfalfa",6), rep("alfalfa",6)),nrotations)                                   <br>
        dat<- data.frame(cbind(tim, t(ret)))                                                                                                           <br>
        dat$Seq<- rep(rep(c(1:6),4),nrotations)                                                                                                        <br>
        names(dat)<- c("Time","Crop","surfaceSeeds","seedsTen","seedsTwenty","Seedlings","maturePlants","Seq")                                         <br>
        return(dat)                                                                                                                                    <br>
        }                                                                                                                                              <br>
                                                                                                                                                       <br>
    twoYearReproductiveValues<- function(period){                                                                                                      <br>
        B<- inputMatrix<- twoYearMatPerm(period)                                                                                                       <br>
        w=eigen(B)$vectors[,1]		# EXTRACT RIGHT EIGENVECTOR (STABLE AGE DISTRIBUTION)                                                              <br>
        w=w/sum(w)					# NORMALIZE RIGHT EIGENVECTOR TO SUM TO ONE                                                                        <br>
        v=eigen(t(B))$vectors[,1]	# EXTRACT LEFT EIGENVECTOR (REPRODUCTIVE VALUE OF SEED LAYER)                                                      <br>
        v=v/v[1]					# LEFT EIGENVECTOR RELATIVE TO FIRST LAYER                                                                         <br>
        x<- data.frame(Rotation="2 year", Phase = period,Layer=c("Surface","1-10 cm","11-20 cm"), DepthDistriubtion = w[1:3], ReproductiveValaue = v[1:<br>3])
        return(x)                                                                                                                                      <br>
        }   
        