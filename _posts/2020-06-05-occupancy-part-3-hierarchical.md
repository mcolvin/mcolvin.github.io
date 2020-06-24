---
layout: post
title: Simulating occupancy part 2 
bigimg: /img/big-img/occ-2.png
comments: true
tags: [tutorial, occupancy,JAGS,optim, likelihood, hierarchical]
---




## Overview

This post builds on the previous 

* [post](https://mcolvin.github.io/2020-05-23-occupancy-1/)
* [post](https://mcolvin.github.io/2020-06-05-occupancy-part-2/)

## Objectives

The objectives of this post is to 

1. Simulate some hierarchical occupancy data assuming homogeneous occupancy rates
2. Fit the occupancy data to a model using
    1. the optim function
    2. Markov Chain Monte Carlo in JAGS

## Assumptions and R script

In this post we are assuming:

* perfect detection (i.e., critters are detected given 
they are present at a site)
* lower level occupancy is conditional higher level occupancy (i.e., a subwatershed cannot
be occupied unless the basin is occupied, and 
* we can perfectly detect occupancy state.  
* [R script for this document](/img/2020-06-05-occupancy-part-2_files/2020-06-XX.R)


## Simulating some hierarchical occupancy data

Stream fish habitat, as well as other aquatic habitat, are easily into hierarchies.
For example, streams are organized as nested watershed or basins and the stream 
within the basin is hierarchically organized into stream, segment, reach, macrohabitat,
and microhabitat. The hierarchy may depend on how the previous terms are defined but the
figure below illustrates this idea. 


Streams are the easy example to demonstrate hierarchies but the same idea can apply to 
lentic habitats. For example oxbow lakes might be nested within basin or glacial lakes
could be nested within underlying geology (assuming the geology is sufficiently large and 
contiguous). Additionally, lake chains or reservoir complexes may be an hierarchy for organizing
individual systems. Heck you can even look at organs nested within a fish. The code below will 
step through a common example where there are multiple 
basins, subbasins that are nested within the basin, streams that are nested within
the subbasin, and stream reaches nested within the stream. 

There are several scales of inference in this example and it is enticing to take existing 
data and shoehorn it into a hierarchical occupancy analysis but bias may occur if randomization
is not sufficient at all levels!

For this example we will assume our study area has 20 basins, with 3 to 5 subbasins 
within each basin, 5 to 10 streams within each subbasin, and we can take 30 samples 
within each subbasin. I am simulating here for ease but in reality we would spin up the
GIS and do this sample allocation right. Also I am using a fixed sample size within each basin 

## Hierarchical occupancy (homogeneous)

### Basin level occupancy 



```r
set.seed(8675309)
library(data.table)
psi<-c(0.3,0.4,0.6,0.8)

x<-data.table(basin=c(1:20))
x[,watershed_psi:=psi[1]]
x[,watershed_occu:=rbinom(nrow(x),1,watershed_psi[1])]
```

### Subbasin level occupancy


```r
x[,subbasin:=round(runif(20,3,5))]
x[,subwatershed_psi:=psi[2]*watershed_occu]
x[,subwatershed_occu:=rbinom(nrow(x),1,subwatershed_psi)]
x<-x[,list(subbasin = rep(seq(subbasin), each = .N),
        watershed_psi,subwatershed_psi,
        watershed_occu,subwatershed_occu), 
    .(basin)]
```

### Stream level occupancy


```r
x[,stream:=round(runif(nrow(x),5,10),0)]
x[,stream_psi:=psi[3]*subwatershed_occu]
x[,stream_occu:=stream_psi]
x<-x[,list(stream = rep(seq(stream), each = .N),
        watershed_psi,subwatershed_psi,stream_psi,
        watershed_occu,subwatershed_occu,stream_occu), 
    .(basin,subbasin)]
```

### Stream reach (100 m) occupancy


```r
# number of 100 m stream units within the stream
x[,stream_unit:=(runif(nrow(x),1,6)*1000)]
x[,stream_unit_psi:=psi[4]*stream_occu]
x[,stream_unit_occu:=rbinom(nrow(x),1,stream_unit_psi)]
# expand for sites within each stream segment
x<-x[,list(stream_unit = rep(seq(stream_unit), each = .N),
        watershed_psi,subwatershed_psi,stream_psi,stream_unit_psi,
        watershed_occu,subwatershed_occu,stream_occu,stream_unit_occu), 
    .(basin,subbasin,stream)]
```

So in the above dataset there are 4 levels: 1) basin, 2) subbasin, 3) stream, and 4) 100 m stream reach
that are nested within the stream. The occupancy state for each level of the hierarchy is depends
on the state of the level above. 



![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6-1.png)







