# Summary of all the shooting data

# start by sourcing 
source("data.R")

# load libraries
library(dplyr)
library(ggplot2)

# how have police shootings changed over time? 
# start by wrangling the data to be organized by month
# which i will do later :) 
trend.data <- raw.data %>% select(name, date) %>% 
  group_by(date) %>% 
  summarise(total = n())
