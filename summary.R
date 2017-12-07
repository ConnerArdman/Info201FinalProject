# Summary of all the shooting data
# start by sourcing 
source("data.R")

# load libraries
library(dplyr)
library(tidyr)
library(plotly)
library(RColorBrewer)

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
  summarise(total_by_state = n()) %>% 
  arrange(desc(total_by_state))

# What is the population
# census data uses full state name
state.population <- read.csv("census_data.csv", stringsAsFactors = FALSE) %>% 
  filter(NAME == STNAME) %>% 
  select(NAME, POPESTIMATE2016) %>% 
  rename(full_state_name = NAME) %>% 
  rename(pop_estimate_2016 = POPESTIMATE2016)

# expand the state names from the abbreviation so you can join the tables
x <- shootings.by.state$state
shootings.by.state$full_state_name <- state.name[match(x, state.abb)]
pop.and.shooting.data <- left_join(state.population, shootings.by.state, by="full_state_name") %>% 
  filter(full_state_name != "District of Columbia")

#top ten states by pop: CA TX FL NY IL PA OH GA NC MI
#top ten states by sho: CA TX FL AZ OH CO OK GA NC WA
showStateProportion <- function() {
  titlefont <- list(color = "white")
  plot_ly(data = pop.and.shooting.data, x = ~pop_estimate_2016, y = ~total_by_state, text = ~paste(full_state_name, "", paste0("Population: ", pop_estimate_2016), paste0("Police Shootings: ", total_by_state), sep="</br>"), hoverinfo="text", type = 'scatter',
               mode = 'markers', size = ~pop_estimate_2016, color = ~total_by_state, marker=list(opacity=0.5), colors = brewer.pal(6, "Paired")) %>% 
    layout(title = 'Shootings By State Proportional To Population', titlefont = titlefont, tickfont = titlefont, tickcolor = "white",  margin = list(t = "110"),
           xaxis = list(title = "State Population",titlefont = titlefont, zerolinecolor="000", showgrid = FALSE, showticklabels = TRUE), 
           yaxis = list(title = "Police Shootings since 2015", titlefont = titlefont, zerolinecolor="000", showgrid = FALSE, showticklabels = TRUE), 
           paper_bgcolor = "#4e5d6c")
}

