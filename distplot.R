library(dplyr)
library(plotly)
source("data.R")

# Create a plot of each shooting based on given input.
# NOTE: Some data points are ommitted based on missing information
showDistPlot <- function(input) {
  is.na(raw.data) <- raw.data==''
  
  # Filter by the given race
  if(input$race == "White, non-Hispanic") {
    plot.data <- raw.data %>% filter(race == "W")
  } else if (input$race == "Black, non-Hispanic") {
    plot.data <- raw.data %>% filter(race == "B")
  } else if (input$race == "Asian") {
    plot.data <- raw.data %>% filter(race == "A")
  } else if (input$race == "Native American") {
    plot.data <- raw.data %>% filter(race == "N")
  } else if (input$race == "Hispanic") {
    plot.data <- raw.data %>% filter(race == "H")
  } else if (input$race == "Other") {
    plot.data <- raw.data %>% filter(race == "O")
  } else {
    plot.data <- raw.data
  }
  
  # Filter by the given gender
  if(input$gender == "Male") {
    plot.data <- plot.data %>% filter(gender == "M")
  } else if (input$gender == "Female") {
    plot.data <- plot.data %>% filter(gender == "F")
  } else if (input$gender == "Unkown") {
    plot.data <- plot.data %>% filter(gender == "None")
  } else {
    plot.data <- plot.data
  }
  
  # Filter by whether or not the person shot was threatening the police officer
  if(input$threat == "Attacking") {
    plot.data <- plot.data %>% filter(threat_level == "attack")
  } else if (input$threat == "Other") {
    plot.data <- plot.data %>% filter(threat_level == "other")
  } else if (input$threat == "Undetermined") {
    plot.data <- plot.data %>% filter(threat_level == "undetermined")
  } else {
    plot.data <- plot.data
  }
  
  # Filter by whether or not the person shot was armed
  if(input$armed == "Firearm") {
    plot.data <- plot.data %>% filter(armed == "gun")
  } else if (input$armed == "Other") {
    plot.data <- plot.data %>% filter(armed != "gun" | armed != "unarmed" | armed != "toy weapon")
  } else if (input$armed == "Unarmed") {
    plot.data <- plot.data %>% filter(armed == "unarmed" | armed == "toy weapon")
  } else {
    plot.data <- plot.data
  }
  
  # Filter by whether or not the person shot was fleeing
  if(input$fleeing == "Yes, on foot") {
    plot.data <- plot.data %>% filter(flee == "Foot")
  } else if (input$fleeing == "Yes, in a vehicle") {
    plot.data <- plot.data %>% filter(flee == "Car")
  } else if (input$fleeing == "No") {
    plot.data <- plot.data %>% filter(flee == "Not fleeing")
  } else {
    plot.data <- plot.data
  }
  
  # Filter by whether or not the person shot had a mental illness
  if(input$mental == "True") {
    plot.data <- plot.data %>% filter(signs_of_mental_illness == "True")
  } else if (input$mental == "False") {
    plot.data <- plot.data %>% filter(signs_of_mental_illness == "False")
  } else {
    plot.data <- plot.data
  }
  
  # Create the plot
  plot.data$age <- sub("^$", 0, plot.data$age)
  dist.plot <- plot_ly(plot.data, x = ~date, y = ~age, type = 'scatter', mode = 'markers',
                       color = ~race, text = ~paste(date, paste0(city, ", ", state), paste0(name), age,
                                                    sep = "<br />"), hoverinfo = "text") %>%
    layout(title = 'Police shooting incidents since January 1st, 2015', margin = list(t = "110"),
           xaxis = list(title = 'Date', zeroline = FALSE, nticks = 4),
           yaxis = list(title = 'Age', zeroline = FALSE, nticks = 8))
}