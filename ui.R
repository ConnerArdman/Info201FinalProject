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
shinyUI(navbarPage("title here", theme = shinytheme("superhero"), selected = "Map",
   
  tags$head(
     tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
   ), 
                   
  tabPanel("Map",
           # Sidebar with a slider input for number of bins 
           sidebarLayout(
             sidebarPanel(
               radioButtons("county.or.state",
                            "Choose a Map View:",
                            choiceValues = c("State", "County"),
                            choiceNames = c("United States", "Pick A State")),
               conditionalPanel(
                 condition = "input['county.or.state'] == 'County'",
                 textInput("state", "State", "Washington")
                 
               )
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
  tabPanel("Tab Three",
     sidebarLayout(
       sidebarPanel(
         
         selectInput(inputId = "race",
                     label = "Race:",
                     choices = c("Any", "White, non-Hispanic", "Black, non-Hispanic", "Asian", "Native American", "Hispanic", "Other", "Unknown"),
                     selected = "Any"),
         
         selectInput(inputId = "gender",
                     label = "Sex:",
                     choices = c("Any", "Male", "Female", "Unknown"),
                     selected= "Any"),
         
         selectInput(inputId = "threat",
                     label = "Threat level:",
                     choices = c("Any", "Attacking", "Other", "Undetermined"),
                     selected= "Any"),
         
         selectInput(inputId = "armed",
                     label = "Armed:",
                     choices = c("Any", "Firearm", "Other", "Unarmed"),
                     selected= "Any"),
         
         selectInput(inputId = "mental",
                     label = "Signs of Mental Illness:",
                     choices = c("Any", "True", "False"),
                     selected= "Any"),
         
         selectInput(inputId = "fleeing",
                     label = "Was the victim fleeing:",
                     choices = c("Any", "Yes, in a vehicle", "Yes, on foot", "No", "Unknown"),
                     selected= "Any")
         
         
         
       ),
       
       mainPanel(
         
         plotOutput("shootingPlot")
       )
     )

  ),
  # Molly's
  tabPanel("Tab Three"
           
  )
  )
)


