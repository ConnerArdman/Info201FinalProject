# start by sourcing 
source("data.R")
source("summary.R")

# load libraries
library(dplyr)


# Remove the town/city identifier from each row
state.data <- read.csv("census_data.csv", stringsAsFactors = FALSE) %>% 
  rename(full_state_name = STNAME) %>% 
  rename(pop_estimate_2016 = POPESTIMATE2016)

cities <- state.data[grep(" city", state.data$NAME), ]
trimmed.cities <- gsub(" city", "", cities$NAME)
towns <- state.data[grep(" town", state.data$NAME), ]
trimmed.towns <- gsub(" town", "", towns$NAME)
cities$NAME <- trimmed.cities
towns$NAME <- trimmed.towns

abbr.state <- shootings.by.state %>% select(state, full_state_name)

# Change state to abbreviations and add complete locations
cities <- left_join(cities, abbr.state, by="full_state_name") %>% 
          mutate(loc = paste0(NAME, ", ", state))

towns <- left_join(towns, abbr.state, by="full_state_name") %>% 
  mutate(loc = paste0(NAME, ", ", state))

places <- rbind(cities, towns) %>% 
          filter(pop_estimate_2016 > 1) %>% 
          select(loc, pop_estimate_2016)

raw.full.location <- raw.data %>% mutate(loc = paste0(city, ", ", state))
data.with.census <- left_join(raw.full.location, places, by = "loc")