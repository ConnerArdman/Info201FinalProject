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
source("body_cam.R")

# Define UI for application that draws a histogram
shinyUI(navbarPage("Police Shootings", theme = shinytheme("superhero"), selected = "Map",
   
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
                 textInput("state", "State", "Washington"),
                 checkboxInput("per", "Show Data Per 100,000 People", TRUE),
                 p("Note: May exclude some small counties")
               ),
               conditionalPanel(
                 condition = "input['county.or.state'] == 'State'",
                 checkboxInput("mill", "Show Data Per 1,000,000 People", TRUE)
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
    p(paste0("Out of the ", total.shootings," U.S. police shootings, we decided to divide the shootings between those with
       police body cameras and those without, to see if police act differently while wearing the cameras. The total number of
       recorded shootings with body cameras is ", total.bc.shootings ,", while total number of shootings where officers did not have
      body cameras is ", total.non.bc.shootings ,". After aggregating the data into these two categories, we decided to run the
      numbers to see if officers with bodycams acted differently if a suspect wasn't fleeing or not armed.")),
    fluidRow(
      h4("Suspects shot that weren't fleeing:"),
      column(
        h5("Police without body cameras"),
        width = 6, plotlyOutput("FleePlotNoBC")),
      column(
        h5("Police with body cameras"),
        width = 6, plotlyOutput("FleePlotBC"))
    ),
    br(),
    fluidRow(
      h4("Unarmed suspects who were still shot:"),
      column(
        h5("Police without body cameras"),
        width = 6, plotlyOutput("armedPlotNoBC")),
      column(
        h5("Police with body cameras"),
        width = 6, plotlyOutput("armedPlotBC"))
    ),
    br(),
    h4("Conclusion"),
    p("When comparing the column on the left (no body cameras) to that of the right (body cameras) we can
      conclude that police officer's use of body cameras has little to no recognizable effect on the conditions
      a officer uses deadly force in. However, it is possible body cameras may have an effect on other officer interacitons
      such as frisks or traffic stops.")
  ),
  # Hari's
  tabPanel("Who were the victims?",
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
         plotlyOutput("shootingPlot")
       )
     )

  ),
  # Molly's
  tabPanel("Tab Three"
           
  )
  )
)


