###
### SEMINAR 1: Read data, look at data, model data, predict from model
###
<<<<<<< HEAD
# Load necessary packages
library(tidyverse)
library(here)







### Let us look at some real data!


### Read the relevant data file. 
mydata <- read.csv(file = "./college.csv")



### Inspect the data, structurally
str(mydata)

### Inspect the data, visually
View(mydata)

# Create beautiful plot on the fly
p <- ggplot(data = gapminder, mapping = aes(x = year, y = gdpPercap))
p + geom_line(color="gray70", aes(group = country)) +
    geom_smooth(size = 1.1, method = "loess", se = FALSE) +
    scale_y_log10(labels=scales::dollar) +
    facet_wrap(~ continent, ncol = 5) +
    labs(x = "Year",
         y = "GDP per capita",
         title = "GDP per capita on Five Continents")
=======
library(data.table)
library(tidyverse)
library(here)

mydata <- fread(file = "./college.csv")
>>>>>>> bf146e463bc3508ab757ae0264a453b5afc7e1b6
