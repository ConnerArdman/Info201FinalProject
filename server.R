# Conner Ardman

library(shiny)
library(dplyr)
library(plotly)
source("summary.R")
source("body_cam.R")
source("map.R")
source("distplot.R")

shinyServer(function(input, output) {

  # Output a plot called "plot"
  output$map <- renderPlotly({
    
    if (input$county.or.state == "County") {
      showCounty(input$state)
    } else if (input$county.or.state == "State") {
      showState()
    }
    
  })
  
  output$FleePlotNoBC <- renderPlotly({
    showFleePlotNoBC()
  })
  output$FleePlotBC <- renderPlotly({
    showFleePlotBC()
  })
  output$armedPlotNoBC <- renderPlotly({
    showArmedPlotNoBC()
  })
  output$armedPlotBC <- renderPlotly({
    showArmedPlotBC()
  })
  
  output$shootingPlot <- renderPlotly({
    showDistPlot(input)
  })
  #PUT YOUR SERVER FUNCTIONS HERE
  
})