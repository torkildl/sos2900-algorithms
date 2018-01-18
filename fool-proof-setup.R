###
### FOOL-PROOF STARTUP IN R FOR SOS2900
###
### GitHub: http://github.com/torkildl/sos2900
###
### This script offers a fool-proof startup in R. It assigns a libPaths to a specific directory,
### it installs a set of packages, if they are not already installed.
### Run once in each R session
if (!exists("SOS2900START")) {

    ### Not run before, but now...
    print("Running SOS2900 startup-script")
    
    ### Get basic system info 
    info <- Sys.info()
    
    ### Directory structure and setup
    
    ### Establish whether we're using a drive letter
    mydrive <- ifelse(info["sysname"]=="Windows","C:","")
    
    # Do we use the Public user folder in Windows
    myuser <- info["user"]
    if (dir.exists(paste(mydrive, "/Users/Public",sep=""))) {
        myuser <- "Public"
    }
    # Build directory
    myhome = paste(mydrive, "/Users/",myuser, sep="")
    mylib <- paste(myhome,"/R/win-library/3.4", sep = "")
    
    ### mylib now points to a reasonable place for an R library
    ### Create the place if it does not exist already
    if (!dir.exists(mylib)) dir.create(mylib, recursive = T)
    
    ### Set library path to mylib
    .libPaths(mylib)
    
    ### Survey what packages are already installed
    myinstalled <- row.names(installed.packages())
    
    ### Required packages for course
    sos2900_packages <- c("tidyverse","gapminder", "here")
    ### What needs to be installed, according to list above?
    to_be_installed <- sos2900_packages[!is.element(sos2900_packages,myinstalled)]
    
    ### Before installing the bulk of packages, make sure those without binaries are installed and compiled.
    # problem_pkgs <- c("pillar","digest")
    # install.packages(pkgs = problem_pkgs, quiet = T, type="source", dependencies=F)
    
    if (length(to_be_installed)>0) {
        print("Trying to install missing packages")
        install.packages(pkgs = to_be_installed, quiet = T, dependencies = c("Depends","Imports"))
    } else {
        print("All required packages are available.")
    }
    rm(list = ls())
    # Evil cleanup
    SOS2900START <- TRUE
} else {
    print("SOS2900 Startup script already run.")
}







    

