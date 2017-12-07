library(dplyr)
library(plotly)

#TODO: , colorbar for counties, conclusion info

# Create a map of the shootings in each county of a given state. 
# If Per is TRUE then use the data per 100,000 people
showCounty <- function(state, per) {
  state.lower <- tolower(state)
  city.counts <- raw.data %>% group_by(city, state) %>% 
    summarize(count = n())
  
  city.lat.long <- read.csv('uscitiesv1.3.csv', stringsAsFactors = FALSE)
  
  # NOTE this is excluding some rows that don't match the city database. 
  # These are mostly very small towns
  city <- inner_join(city.counts, city.lat.long, by = c("city" = "city", "state" = "state_id"))
  
  county <- city %>% group_by(county_name, state_name) %>%
    summarize(count = sum(count), adjusted = (sum(count) / sum(population)) * 100000) %>% 
    mutate(lower_county_name = tolower(county_name), state_name = tolower(state_name))
  
  # Get information about USA counties
  counties <- map_data("county")
  
  county.data <- left_join(counties, county, by = c("subregion" = "lower_county_name", "region" = "state_name"))
  title <- paste("Police Shootings Per 100,000 People By County:", state)
  titlefont <- list(color = "white")
  county.data <- county.data  %>% filter(region == state.lower)
  
  # Replace N/A values with 0
  county.data["count"][is.na(county.data["count"])] <- 0
  county.data["adjusted"][is.na(county.data["adjusted"])] <- 0
  
  if (per) {
    county.data$colorcat <- factor(county.data$adjusted)
  } else {
    county.data$colorcat <- factor(county.data$count)
    title <- paste("Police Shootings By County:", state)
  }
  
  # Render the plot
  county.data %>%
    group_by(group) %>%
    plot_ly(x = ~long, y = ~lat, color = ~colorcat, colors = "Reds", hoverinfo = "none")  %>% 
    add_polygons(line = list(width = 0.4), hoverinfo = "none") %>% 
    add_polygons(
      fillcolor = 'transparent',
      line = list(color = 'black', width = 0.5),
      showlegend = FALSE, hoverinfo = "none")  %>%
    add_trace(type = "scatter", opacity = 0, mode = "markers",
              text = ~paste0(gsub("(?<=\\b)([a-z])", "\\U\\1", subregion, perl=TRUE),
                             "\n","Shootings: ", count, "\nPer 100,000: ", 
                             round(adjusted)), hoverinfo = "text") %>%
    layout(autosize = F, title = title, paper_bgcolor = "#4e5d6c", titlefont = titlefont, 
           margin = list(t = "110"), xaxis = list(title = "", showgrid = FALSE,
                                                  zeroline = FALSE, showticklabels = FALSE), yaxis = list(title = "", showgrid = FALSE,
                                                                                                          zeroline = FALSE, showticklabels = FALSE), showlegend = FALSE)
}


# Create a map of the United States labelings states based on how many police shootings occur there.
# If mill is TRUE, show data porportional to every million people in each state.
showState <- function(mill) {
  # specify some map projection/options
  g <- list(scope = 'usa', projection = list(type = 'albers usa'))
  titlefont <- list(color = "white")
  output.data <- pop.and.shooting.data %>% mutate(data = total_by_state / pop_estimate_2016 * 1000000)
  text <- ~paste(full_state_name,"\nTotal Shootings: ", 
                 total_by_state, "\nShootings Per Million People: ", round(data))
  
  interest <- ~total_by_state
  if (mill) {
    interest <- ~data
  }
  
  # Create a map of the police shootings per million people by state
  plot_geo(output.data, locationmode = 'USA-states') %>%
    add_trace(z = interest, text = text, locations = ~state, 
              color = interest, colors = 'Reds', hoverinfo = 'text') %>%
    colorbar(title = "Shootings", titlefont = titlefont, 
             tickfont = titlefont, tickcolor = "white") %>%
    layout(title = 'Police Shootings Per Million People', geo = g, autosize = F,
           paper_bgcolor = "#4e5d6c", titlefont = titlefont, margin = list(t = "110"))    
}







