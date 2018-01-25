###
### SEMINAR 1: Read data, look at data, model data, predict from model
###
### Run SOS2900 startup script
###
source("http://bit.ly/SOS2900-startup-R")
###
### Load some necessary packages
library(tidyverse)
library(gapminder)
library(here)
library(MLmetrics)
###

### EXAMPLE OF HOW MUCH WORK IS NEEDED TO PRODUCE SOMETHING OF VALUE IN R
### Create beautiful plot on the fly
p <- ggplot(data = gapminder, mapping = aes(x = year, y = gdpPercap))
p + geom_line(color="gray70", aes(group = country)) +
    geom_smooth(size = 1.1, method = "lm", se = FALSE) +
    scale_y_log10(labels=scales::dollar) +
    facet_wrap(~ continent, ncol = 5) +
    labs(x = "Year",
         y = "GDP per capita",
         title = "GDP per capita on Five Continents")


### What data was this? Simple country-comparisons from Gapminder.
# first rows
head(gapminder)
# Describe each variable
summary(gapminder)
# We can also look at the data
View(gapminder)




### Let us look at some other real data!
# Load data
# Inspect data
# Summarize data
# Run regression
# Plot regression
# Predict
# Evaluate prediction
# Run another regression 
# Plot regression
# Predict
# Evaluate prediction

# We'll use data on cars, no less.
mtcars


# What information is included?
colnames(mtcars)

# Summarize
summary(mtcars)

# Look at first few rows
head(mtcars)

# Visualize some data points: mpg and hp
aplot <- ggplot(mtcars, aes(x=hp, y=mpg)) + geom_point()

# That created the plot. Now look at it:
aplot

aplot + geom_smooth(method="lm")

# There seems to be a relationship between hp and mpg. 
# Stronger engines are more efficient??

## LEt us now model the relationship 
## Set up a small, stupid model of mpg
small <- lm(mtcars, formula="mpg ~ hp")
small

# Predict from model, and store in new variable
mtcars$mpg_pred_small <- predict(small)


# Look at the prediction
summary(select(mtcars, mpg, mpg_pred_small))
qplot(data = mtcars, mpg, mpg_pred_small)


# Quantify the precision of the predicted values
R2_Score(mtcars$mpg, mtcars$mpg_pred_small)

RMSE(mtcars$mpg, mtcars$mpg_pred_small)

# Ok, so let us try another model with lots of variables
# Who cares what we put in, asl ong as the prediction is better.
full <- lm(mtcars, formula="mpg ~ cyl + disp + hp + drat + wt + qsec + vs + am + gear + carb")
full

mtcars$mpg_pred_full <- predict(full)
# Look at the prediction
summary(select(mtcars, mpg, mpg_pred_full))
qplot(data = mtcars, mpg, mpg_pred_full)

# Calculate R squared for this model
R2_Score(mtcars$mpg, mtcars$mpg_pred_full)
# Calculate root mean sq error for this model
RMSE(mtcars$mpg, mtcars$mpg_pred_full)


