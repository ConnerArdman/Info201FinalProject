library(dplyr)
library(plotly)

#TODO: style, comments, colorbar for counties, margins/sizing, conclusion info, DC?, name of panel

showCounty <- function(state) {
  state.lower <- tolower(state)
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
  titlefont <- list(color = "white")
  county.data <- county.data  %>% filter(region == state.lower)
  county.data$colorcat <- factor(county.data$count)
  
  county.data %>%
    group_by(group) %>%
    plot_ly(x = ~long, y = ~lat, color = ~colorcat, colors = "Reds"
    ) %>%
    add_polygons(line = list(width = 0.4)) %>%
    add_polygons(
      fillcolor = 'transparent',
      line = list(color = 'black', width = 0.5),
      showlegend = FALSE#, text = ~paste0(subregion,"\n","Shootings: ", count), hoverinfo = "text" TODO hover doesn't work
    ) %>%   
    layout(autosize = F,
           title = paste("Police Shootings By County:", state), paper_bgcolor = "#4e5d6c", titlefont = titlefont, margin = list(t = "110"),    
           xaxis = list(title = "", showgrid = FALSE,
                        zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(title = "", showgrid = FALSE,
                        zeroline = FALSE, showticklabels = FALSE)#, showlegend = FALSE TODO make this legend a colorbar somehow?
    )
}


showState <- function() {
  # specify some map projection/options
  g <- list(scope = 'usa', projection = list(type = 'albers usa'))
  titlefont <- list(color = "white")
  state.data.per.capita <- pop.and.shooting.data %>% mutate(per.mill = total_by_state / pop_estimate_2016 * 1000000)
  
  # Create a map of the police shootings per million people by state
  # TODO does not work with DC
  per.mill <- plot_geo(state.data.per.capita, locationmode = 'USA-states') %>%
    add_trace(z = ~per.mill, text = ~paste(full_state_name,"\nTotal Shootings: ", total_by_state, "\nShootings Per Million People: ", 
                                           round(per.mill)), locations = ~state, color = ~per.mill, colors = 'Reds', hoverinfo = 'text') %>%
    colorbar(title = "Shootings", titlefont = titlefont, tickfont = titlefont, tickcolor = "white") %>%
    layout(title = 'Police Shootings Per Million People', geo = g, 
           paper_bgcolor = "#4e5d6c", titlefont = titlefont, margin = list(t = "110"))    
}







