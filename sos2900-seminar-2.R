###
### Seminar 2 regression and prediction using different data
###
source("http://bit.ly/SOS2900-startup-R")
###
### Load some necessary packages
library(tidyverse)
library(gapminder)
library(here)
library(MLmetrics)
library(data.table)

# Plan for seminar 2:
# Do a linear prediction with training/testing split, evaluate the prediction.
# The appliction is to predict communities with high violent crime rates. This result
# may then be used in policing or in social work to reduce violence/crime.
#
# The data are described in detail here: 
# http://archive.ics.uci.edu/ml/machine-learning-databases/communities/communities.names
#

# Load the data on crime and communities
datadesc <- fread("https://raw.githubusercontent.com/torkildl/sos2900-algorithms/master/materials/communities.names", header<=F, skip=75, nrows = 203, drop=1, col.names=c("variable","varlabel"), showProgress = F)
thedata <- fread("https://raw.githubusercontent.com/torkildl/sos2900-algorithms/master/materials/communities.data", na.strings = "?", showProgress = F)
names(thedata) <- datadesc$variable

# Inspect some data
summary(thedata)
head(thedata)

# Lots of variables!
# Choose outcome: violent crime per capita (ViolentCrimesPerPop)
summary(thedata$ViolentCrimesPerPop)

# SPLIT DATA IN TRAINING/TESTING DATA:
# We'll use random numbers from 0 to 1 to split the data
# Every row (community) is given a random number
# The number is then used as a criteria to be included in either training/testing data

# What fraction of the data set will be training data? TYpically 50%, 2/3rds or so.
target <- 0.7
# The variable lottery now contains a random number 0 to 1
thedata$lottery <- runif(n = nrow(thedata))
# Check it out
summary(thedata$lottery)
# Create two new datasets, training and testing, based on the lottery variable
training <- filter(thedata, lottery<target)
testing  <- filter(thedata, lottery>=target)

# These two data sets are not exactly equal in size and sizes will vary for each time 
# the code is run (due to randomness of procedure).
dim(training)
dim(testing)

# Look at training data: violent crimes by median rent
ggplot(data=training, aes(y=ViolentCrimesPerPop, x=MedRent)) + geom_point() + geom_smooth(method="lm")

# Model violent crime rate with a few chosen characteristics
model_train <- lm(data=training, formula="ViolentCrimesPerPop ~ MedRent + pctUrban")

# Examine prediction on training data
summary(model_train)

# Calculate RMSE manually -- last week we used a function (RMSE in MLmetrics library)
training$prediction <- predict(model_train)
training$residual <- training$ViolentCrimesPerPop-training$prediction
rmse_train <- sqrt(mean(training$residual^2))
r2_train <- R2_Score(training$prediction, training$ViolentCrimesPerPop)


# OVER TO TESTING DATA: Use "knowledge about the world" from training data to predict for
# "another world" (the testing data). 

# Predict on testing data: note the difference in code
testing$prediction <- predict(model_train, newdata = testing)
testing$residual <- testing$ViolentCrimesPerPop-testing$prediction
rmse_test <- sqrt(mean(testing$residual^2))
r2_test <- R2_Score(testing$prediction, testing$ViolentCrimesPerPop)


# Evaluate model on the two data sets
rmse_train
rmse_test

r2_train
r2_test

# Model again with a larger set of variables. Students can choose variables.
# 
model_train <- lm(data=training, formula="ViolentCrimesPerPop ~ MedRent + PolicPerPop + pctUrban + NumUnderPov + TotalPctDiv")

# Predict on testing data
# Examine predictions

# Model again using as many as you'd like
# Predict on testing data
# Examine predictions


# ...


# Why not use all the variables available in the data?
# How to deal with overfitting resulting from including a large number of variables?
# This is where tree-based methods enter the equation.
