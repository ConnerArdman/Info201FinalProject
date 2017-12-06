#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shiny)
library(plotly)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(navbarPage("title here", theme = shinytheme("superhero"), selected = "tab 1",
   
  tags$head(
     tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
   ), 
                   
  tabPanel("tab 1",
             # Sidebar with a slider input for number of bins 
             sidebarLayout(
               sidebarPanel(
                 radioButtons("county.or.state",
                              "Breakdown by County or State?",
                              choiceValues = c("State", "County"),
                              choiceNames = c("State", "County"))
               ),
               
               # Show a plot of the generated distribution
               mainPanel(
                 plotlyOutput("map")
               )
            )
          ),
  # Tyler's
  tabPanel("Body Cameras",
    h1("Do police act differently when wearing body cameras?"),
    h4("When looking at our dataset of U.S. police shootings, we decided to divide the shootings between those with
       police body cameras and those without, to see if police act differently while wearing the cameras."),
    fluidRow(
      column(
        h4("Police without body cameras"),
        width = 6, plotlyOutput("FleePlotNoBC")),
      column(
        h4("Police with body cameras"),
        width = 6, plotlyOutput("FleePlotBC"))
    ),
    br(),
    fluidRow(
      column(width = 6, plotlyOutput("armedPlotNoBC")),
      column(width = 6, plotlyOutput("armedPlotBC"))
    )
  ),
  # Hari's
  tabPanel("Tab Three"

  ),
  # Molly's
  tabPanel("Tab Three"
           
  )
  )
)


