---
layout: post
title: Spatial polygons
subtitle: How to make and sample a polygon
bigimg: /img/big-img/enid.png
tags: [sampling, R, bluff lake]
---



Generating sampling points in a polygon, like a lake can be done in R.
Alternatively it can be done in a GIS like ARCgis, but I find that I use
GIS so infrequently that I often forget how to do all the mouse clicks
to replicate the process. Additionally, folks may not have access to
tools like ARCgis.

Setting up sampling locations on a lake is something we commonly do and
this script outlines the code needed to

1.  Convert a series of coordinates to a projected polygon,
2.  Do a spatial transformation of the polygon to different coordinate
    system, and
3.  Put a grid of points down on the polygon.

First we are going to need the `sp` package.

    library(sp) 

Now we need some coordinates that represent the polygon. In some cases
these can be mapped by a person from an existing shapefile or in many
cases I make a polygon in Google Earth and then extract the coordinates
from the KML or KMZ file. The inputs needed are the latitude and
longitude in decimal degrees in a 2 column matrix.

    xy<-matrix(c(   
        -89.77289828816011,34.12873397365311,
        -89.76774994101028,34.12668478124235,
        -89.76266944254215,34.12628818013323,
        -89.75931113396815,34.12712965948358,
        -89.75832500358763,34.12898146027732,
        -89.75875790900869,34.13012770412038,
        -89.75956198837545,34.13306528303878,
        -89.76032752522802,34.13562525651049,
        -89.76099817993331,34.13790799169687,
        -89.76312565910443,34.13926482932697, 
        -89.76556160304746,34.14136708399852,
        -89.76617598985348,34.14324607146693,
        -89.76878432735586,34.14479967335202,
        -89.77492333746093,34.14640413252697,
        -89.77555592736375,34.14431798895685,
        -89.77643367333054,34.14200220172483,
        -89.77738235493442,34.13842937845001,
        -89.77747288929112,34.13526043231848,
        -89.77289828816011,34.12873397365311),
            ncol=2, byrow=TRUE) 

Note that the first and last rows of the matrix must be the same.

Let's check and make sure

    xy[1,] ## first row

    ## [1] -89.77290  34.12873

    xy[nrow(xy),] ## last row

    ## [1] -89.77290  34.12873

We can use R to make sure.

    xy[1,] == xy[nrow(xy),]

    ## [1] TRUE TRUE

Yep the first and last rows are the same, the polygon will be closed.

Now using the `Polygon()` function to make a polygon from the
coordinates.

    xy<- Polygon(xy)

Now the `SpatialPolygons()` function requires a list of polygons. In
this case we only have one polygon, but if you had more than 1 this
function will do it.

    xy<- Polygons(list(Polygon(xy)), ID=1)

The code above makes a list of polygons with some meta data, an ID in
this case for each polygon.

Now the`SpatialPolygons()` function take the list of polygons and
defines the spatial projection.

    ## MAKE THE COORDINATES INTO A POLYGON   
    xy <- SpatialPolygons(list(xy),
        proj4string=CRS("+proj=longlat +datum=NAD83"))

Now you can do nice things like plot the polygon.

    plot(xy,axes=TRUE)

![](/img/2018-12-15-making-a-spatial-polygon/unnamed-chunk-9-1.png)

You can even work among different projection systems. The code below
projects the polygon to UTM zone 16.

    xy_utm<-spTransform(xy, 
        CRS("+proj=utm +zone=17 +datum=NAD83"))

Using the `spsample()` function you can sample the polygon in varying
ways, below is a regular sample from a random initial location.

    xy.points.reg <- spsample(xy_utm, n = 23, type = "regular") # n is sample size

You can look at the sites on the lake.

    plot(xy_utm,axes=TRUE)
    points(xy.points.reg)

![](/img/2018-12-15-making-a-spatial-polygon/unnamed-chunk-12-1.png)

You can also look at the xy coordinates and upload them to your GPS!

    xy.points.reg

    ## SpatialPoints:
    ##              x1      x2
    ##  [1,] -309685.0 3811284
    ##  [2,] -309341.8 3811284
    ##  [3,] -308998.6 3811284
    ##  [4,] -310028.2 3811627
    ##  [5,] -309685.0 3811627
    ##  [6,] -309341.8 3811627
    ##  [7,] -308998.6 3811627
    ##  [8,] -310371.4 3811970
    ##  [9,] -310028.2 3811970
    ## [10,] -309685.0 3811970
    ## [11,] -309341.8 3811970
    ## [12,] -308998.6 3811970
    ## [13,] -310371.4 3812313
    ## [14,] -310028.2 3812313
    ## [15,] -309685.0 3812313
    ## [16,] -309341.8 3812313
    ## [17,] -308998.6 3812313
    ## [18,] -310371.4 3812657
    ## [19,] -310028.2 3812657
    ## [20,] -309685.0 3812657
    ## [21,] -309341.8 3812657
    ## [22,] -310028.2 3813000
    ## [23,] -309685.0 3813000
    ## Coordinate Reference System (CRS) arguments: +proj=utm +zone=17
    ## +datum=NAD83 +ellps=GRS80 +towgs84=0,0,0
