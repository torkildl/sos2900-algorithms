###
### SEMINAR 1: Read data, look at data, model data, predict from model
###
library(data.table)
library(tidyverse)
library(here)

mydata <- fread(file = "./college.csv")
