# Summary of all the shooting data

# start by sourcing 
source("data.R")


# load libraries
library(dplyr)
library(ggplot2)

# how have police shootings changed over time? 
shootings.by.year <- raw.data %>% select(name, date) %>%
  separate(date, c("year", "month", "day")) %>% 
  group_by(year) %>% 
  summarise(peryear = n())
#this plot is not that interesting, there's a gradual decline since 2015
#plot(shootings.by.year$year, shootings.by.year$peryear)

shootings.by.month <- raw.data %>% select(name, date) %>%
  separate(date, c("year", "month", "day")) %>% 
  group_by(month) %>% 
  summarise(permonth = n())
#this plot is also boring, it just shows there are less shootings in decemeber on avrage
#but also the data set is missing 2017 dec data because the month just started
#plot(shootings.by.month$month, shootings.by.month$permonth)


# where do shootings occur? is that relative to population? 
shootings.by.state <- raw.data %>% 
  group_by(state) %>% 
  summarise(totalbystate = n()) %>% 
  arrange(desc(totalbystate))

# What is the population
# census data uses full state name
state.population <- read.csv("census_data.csv", stringsAsFactors = FALSE) %>% 
  filter(NAME == STNAME) %>% 
  select(NAME, POPESTIMATE2016) %>% 
  rename(full.state.name = NAME)

# expand the state names from the abbreviation so you can join the tables
x <- shootings.by.state$state
shootings.by.state$full.state.name <- state.name[match(x, state.abb)]
pop.and.shooting.data <- left_join(state.population, shootings.by.state, by="full.state.name")

#TODO decide how to evaluate the number of shootings to the relative population
# show top ten shootings, and top ten populations? ??