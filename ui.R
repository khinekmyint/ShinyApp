#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Orange Tree Dataset"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    
    sidebarPanel(
      verbatimTextOutput("summary"),
      sliderInput("age",
                  "Orange age:",
                  min = 1,
                  max = 1600,
                  value = 50),
      br(),
      h4("Predicted Circumference of Orange Tree:"),
      textOutput("pred1")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Graph", br(), 
                           plotOutput("distPlot"),
                           em("Growth of orange trees. Trunk circumference at breast
                              height of 5 trees measured at 7 different ages.")),
                  tabPanel("Data Table", br(), dataTableOutput('mytable'))
                           )
      
    )
    )
))
