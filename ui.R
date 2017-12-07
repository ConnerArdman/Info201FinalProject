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
shinyUI(navbarPage("Police Shootings", theme = shinytheme("superhero"), selected = "Where Do Shootings Occur?",
   
  tags$head(
     tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
   ), 
  
  # Conner and Molly
  # Interactive map of nation and individual states and scatterplot plotting each statses total shootings vs.
  # state population.
  tabPanel("Where Do Shootings Occur?",
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
               ),br(),hr(),
               h1("Project Introduction:"),
               p("The purpose of this project is to determine the scope of police shootings (an officer shooting a civilian)
                 in the United States, determine the effectiveness of current solutions (bodycameras), and hopefully
                 provide insight into how a better solution could be devised."), 
               a("More information about this project and the dataset can be found here. 
                 Data ranges from January 1, 2015 to present day.", href= "https://github.com/ConnerArdman/Info201FinalProject"),
               br(),hr(),
               h1("Initial Conclusion:"),
               p("Looking at these maps and the relatively linear pattern to the graph, we have concluded
                 that this issue is spread significantly across all of the states (There are of course outliers
                 such as New York and New Mexico with significantly higher of lower proportions than average).
                 For this reason, we believe that the issue is most relevant at the federal legislative level.")
             ), 
             
             # Show a plot of the generated distribution
             mainPanel(
               plotlyOutput("map", height = "500", width = "700"),
               plotlyOutput("statePlot", width = "700")
             )
           )
  ),  
  
  # Hari
  # Visualization of the data set. Each marker represents a person who was killed.
  tabPanel("Who Were The Victims?",
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
                           choices = c("Any", "Yes, in a vehicle", "Yes, on foot", "No"),
                           selected= "Any")
             ),
             
             mainPanel(
               plotlyOutput("shootingPlot")
             )
           ),
           fluidRow(
             column(width = 1),
             column(width = 10,
                    div(h1("Conclusion:"),
                        p("Overall, we have found that this issue of police shootings is widespread amongst most
                          of our factors. Additionally, we see no clear trend towards improving on this issue. There
                          are however some very interesting data points. For example, police are significantly more likely
                          to shoot a male than a female. Additionally, police are more likely to shoot someone who they claim
                          was attacking them (however this could be due to the clear response bias associated with the officers
                          not wanting to incriminate themselves."),  
                        p("In conclusion, these data clearly demonstrate that this is a major issue that needs to be addressed
                          on a federal level. Police (like all people) carry unconscious biases, and it is imperative to work
                          towards legislation that minimizes these."),
                        style = "background-color:#4e5d6c; padding:10px")
                    ),
             column(width = 1)
           )
  ),
  
  # Tyler
  # Pie charts that display the observed trends related to body cameras from the data.
  tabPanel("Do Body Camera's Prevent Shootings?",
    fluidRow(
      column(width = 1),
      column(width = 10, h1("Do police act differently when wearing body cameras?"),
      div(p(paste0("Out of the ", total.shootings," U.S. police shootings, we decided to divide the shootings between those with
       police body cameras and those without, to see if police act differently while wearing the cameras. The total number of
       recorded shootings with body cameras is ", total.bc.shootings ,", while total number of shootings where officers did not have
      body cameras is ", total.non.bc.shootings ,". After aggregating the data into these two categories, we decided to run the
      numbers to see if officers with bodycams acted differently if a suspect wasn't fleeing or not armed.")), 
      style = "background-color:#4e5d6c; padding:10px")),
      column(width = 1)),
    fluidRow(
      column(width = 1),
      column(width = 10, h3("Proportion of Suspects Shot That Were Fleeing:")),
      column(width = 1)
    ),
    fluidRow(
      column(width = 1),
      column(
        h5("Police without body cameras"),
        width = 5, plotlyOutput("FleePlotNoBC")),
      column(
        h5("Police with body cameras"),
        width = 5, plotlyOutput("FleePlotBC")),
      column(width = 1)
    ),br(),
    fluidRow(
      column(width = 1),
      column(width = 10, h3("Proportion of Suspects Shot That Were Armed:")),
      column(width = 1)
    ),
    fluidRow(
      column(width = 1),
      column(
        h5("Police without body cameras"),
        width = 5, plotlyOutput("armedPlotNoBC")),
      column(
        h5("Police with body cameras"),
        width = 5, plotlyOutput("armedPlotBC")),
      column(width = 1)
    ),
    fluidRow(
      column(width = 1),br(),
      column(width = 10,
             div(h1("Conclusion:"),
                 p("When comparing the column on the left (no body cameras) to that of the right (body cameras) we can
                   conclude that police officer's use of body cameras has little to no recognizable effect on the conditions
                   a officer uses deadly force in. However, it is possible body cameras may have an effect on other officer interacitons
                   such as frisks or traffic stops."),  
                   style = "background-color:#4e5d6c; padding:10px")
            )
      )
  ),

  
  # Footer
  br(),
  hr(),
  p("Conner Ardman, Hari Kaushik, Tyler Van Brocklin, Molly Donohue"),
  a("Raw Data From The Washington Post", href = "https://github.com/washingtonpost/data-police-shootings", style = "color:white")
  )
)


