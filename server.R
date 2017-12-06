# Conner Ardman

library(shiny)
library(dplyr)
library(plotly)
source("summary.R")

shinyServer(function(input, output) {

  # Output a plot called "plot"
  output$map <- renderPlotly({
    
    if (input$county.or.state == "County") {
      showCounty()
    } else if (input$county.or.state == "State") {
      showState()
    }
    
  })
  
  #PUT YOUR SERVER FUNCTIONS HERE
  
})



showCounty <- function() {
  city.counts <- raw.data %>% group_by(city, state) %>% summarize(count = n())
  
  city.lat.long <- read.csv('uscitiesv1.3.csv', stringsAsFactors = FALSE)
  # NOTE this is excluding about 300 rows that don't match the city database. These are mostly very small
  # towns
  city <- inner_join(city.counts, city.lat.long, by = c("city" = "city", "state" = "state_id"))
  
  county <- city %>% group_by(county_name, state_name) %>%
    summarize(count = sum(count)) %>% 
    mutate(lower_county_name = tolower(county_name), state_name = tolower(state_name))
  
  counties <- map_data("county")
  
  county.data <- left_join(counties, county, by = c("subregion" = "lower_county_name", "region" = "state_name"))
  
  
  county.data["count"][is.na(county.data["count"])] <- 0
  geo <- list(
    scope = 'usa',
    showland = TRUE,
    landcolor = toRGB("gray95"),
    countrycolor = toRGB("gray80")
  )
  titlefont <- list(color = "white")
  
  
  county.map <- county.data %>%
    group_by(group) %>%
    plot_geo(x = ~long, y = ~lat, #color = ~count, #TODO this doesn't work for some reason :(
             text = ~paste0(subregion,"\n","Shootings: ", count), hoverinfo = 'text') %>%
    add_polygons(fillcolor = 'transparent', line = list(color = 'black', width = 0.5), showlegend = FALSE) %>%
    layout(title = "Police Shootings By County", geo = geo, paper_bgcolor = "#4e5d6c", 
           titlefont = titlefont, margin = list(t = "110"))
}



showState <- function() {
  # specify some map projection/options
  g <- list(scope = 'usa', projection = list(type = 'albers usa'))
  titlefont <- list(color = "white")
  state.data.per.capita <- pop.and.shooting.data %>% mutate(per.mill = total_by_state / pop_estimate_2016 * 1000000)
  
  # Create a map of the police shootings per million people by state
  # TODO does not work with DC
  per.mill <- plot_geo(state.data.per.capita, locationmode = 'USA-states') %>%
    add_trace(z = ~per.mill, text = ~paste(full_state_name,"\nShootings: ", round(per.mill)), locations = ~state,
              color = ~per.mill, colors = 'Reds', hoverinfo = 'text') %>%
    colorbar(title = "Shootings", titlefont = titlefont, tickfont = titlefont, tickcolor = "white") %>%
    layout(title = 'Police Shootings Per Million People', geo = g, 
           paper_bgcolor = "#4e5d6c", titlefont = titlefont, margin = list(t = "110"))    
}