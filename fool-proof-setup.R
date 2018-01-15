###
### FOOL-PROOF STARTUP IN R FOR SOS2900
###
### GitHub: http://github.com/torkildl/sos2900
###
### This script offers a fool-proof startup in R. It assigns a libPaths to a specific directory,
### it installs a set of packages, if they are not already installed.

### Directory structure and setup

### Is this a Mac or a windows box?
info <- Sys.info()

### 
mydrive <- ifelse(info["sysname"]=="Windows","C:","")

myuser <- info["user"]
if (dir.exists(paste(mydrive, "/Users/Public",sep=""))) {
    myuser <- "Public"
}

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
sos2900_packages <- c("ggplot2","dplyr","tidyr","stringi","stringr","broom","janeaustenr")
### What needs to be installed, according to list above?
to_be_installed <- sos2900_packages[!is.element(sos2900_packages,myinstalled)]

if (length(to_be_installed)>0) {
    print(paste("Trying to install missing packages: ",to_be_installed))
    install.packages(pkgs = to_be_installed, quiet = T)
} else {
    print("All required packages are available.")
}






    

