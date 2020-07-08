---
layout: post
title: Back that computer up
subtitle: Fire up the *.BAT signal
bigimg: /img/big-img/bat.png
comments: true
tags: [bat files,operations, best practice, back ups]
---

## TL;DR

* Back up your systems to the cloud or an external drive
* If you are using an external drive then you can use a `*.bat`
file to make backing up a 1 click effort or set it up to
run automatically as a scheduled task

## Introduction

Last week was a good one for electronics. My cell phone was finally
roasted, a hot July afternoon on Panther Creek and it overheated 
and finally just wouldn't turn on. Also turns out that 2 laptops 
went down as well. Backing up your machine should be a part of 
your daily routine. Frequent back ups are supposed to occur often
throughout the semester. It is specified as part of the [research
credits syllabus](https://mcolvin.github.io/WFA8000-Research-Credits/syllabus.html), it is that important.
It is important because the data contained in your files is the 
culmination of much work! Therefore it is really, really, really,
important!

## Rationale for local syncing

Most people now are backing up to some sort of cloud. If you 
are that is great. This post is for folks that don't want to
back up to the cloud but use a local external hard drive. Why 
would you find yourself in a position like this? In my case,
using tools like OneDrive don't conform with my work flow. Plus
if you do simulation intensive work you may find yourself generating
10s of gigabytes of output daily. Syncing that much data to the cloud
is slow and likely going to cost some money. Alternatively, you 
can get external hard drives pretty cheaply now and they can 
be an alternative to cloud backups. 

The problem with locally syncing files is that you need some 
software to mirror what is on your system with your backup. 
I have tried a few things in the past and the best way I 
have come up is to hard code a backup script as a `bat` file.
A `bat` file is a small script that executes some DOS code. It 
is convenient because you can double click the `bat` file and it 
runs through the script and then disappears, if you want it to.

## Making a *.bat file
To make a bat file is simple assuming you have the necessary DOS
code. First you copy the DOS code to a text file and then save 
the text file as `filename.bat`. Where filename is whatever you
want it to be. 

## Some code for a *.bat file

The code below demonstrates using the `robocopy` function
to mirror directors on my laptop to 2 external hard drives. 

  
    echo ### Backing up Desktop...To portable
    robocopy "%USERPROFILE%\Desktop" Q:\backup\desktop /MIR  /np /nfl /njh /njs /ndl /nc /ns

    echo ### Backing up Desktop...To book
    robocopy "%USERPROFILE%\Desktop" D:\backup\desktop /MIR   /np /nfl /njh /njs /ndl /nc /ns

    echo ### Backing up Google Drive...To portable
    robocopy "%USERPROFILE%\Google Drive" "Q:\backup\Google Drive" /MIR  /np /nfl  /njh /njs /ndl /nc /ns

    echo ### Backing up Google Drive...To book
    robocopy "%USERPROFILE%\Google Drive" "D:\backup\Google Drive" /MIR   /np /nfl /njh /njs /ndl /nc /ns


    echo ### Backing up One Drive...To portable
    robocopy "%USERPROFILE%\OneDrive - Mississippi State University" "Q:\backup\OneDrive" /MIR  /np  /nfl /njh /njs /ndl /nc /ns

    echo ### Backing up One Drive...To book
    robocopy "%USERPROFILE%\OneDrive - Mississippi State University" "D:\backup\OneDrive" /MIR  /np   /nfl /njh /njs /ndl /nc /ns


    echo ### Backing Documents...To book
    robocopy "%USERPROFILE%\Documents" "D:\backup\Documents" /MIR  /np   /nfl /njh /njs /ndl /nc /ns

    echo ### Backing up Documents...To portable
    robocopy "%USERPROFILE%\Documents" Q:\backup\Documents /MIR  /np /nfl /njh /njs /ndl /nc /ns


## Code breakdown

The code above copies several folders I have on my laptop to corresponding folders on 2
external drives, by `D:` and `Q:` drive. Using this it is good to map your drive so 
the letter doesn't change on you. 

* The echo command simply returns some useful descriptive text to the console.
* The robocopy command copies `from directory` `to directory`
* The `\MIR` tells robocopy to mirror the from and the to directories. Be careful here
as if you delete something on your external drive it will remove that file on your local
machine. 
* The remaining flags are things you can toggle on and off and descriptions can be 
found [here](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy).

## Your everyday carry

* The bat file can be scheduled using windows scheduler to run every day
at lunch or midnight, or whenever you want it to. 
* Robocopy is not the fastest copying at least the way it is set up in the code above but
it has yet to fail me. 




