source("data.R")

library(dplyr)
library(plotly)

#state.counts <- raw.data %>% group_by(state) %>% summarize(count = n())
city.counts <- raw.data %>% group_by(city, state) %>% summarize(count = n())

state.data.per.capita <- pop.and.shooting.data %>% mutate(per.mill = totalbystate / POPESTIMATE2016 * 1000000)

# specify some map projection/options
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa')
)

# Create a map of the police shootings per million people by state
# TODO make this work with shiny... possibly be able to choose a timeframe and other factors
# TODO does not work with DC
per.mill <- plot_geo(state.data.per.capita, locationmode = 'USA-states') %>%
  add_trace(z = ~per.mill, text = ~paste("Shootings: ", round(per.mill)), locations = ~state,
            color = ~per.mill, colors = 'Reds', hoverinfo = 'text') %>%
  colorbar(title = "Shootings") %>%
  layout(title = 'Shootings Per Million People',geo = g)





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

county.map <- county.data %>%
              group_by(group) %>%
              plot_geo(x = ~long, y = ~lat, #color = ~count, #TODO this doesn't work for some reason :(
                      text = ~paste0(subregion,"\n","Shootings: ", count), hoverinfo = 'text') %>%
              add_polygons(fillcolor = 'transparent',
                           line = list(color = 'black', width = 0.5), showlegend = FALSE) %>%
              layout(title = "Police Shootings By County", geo = geo)



