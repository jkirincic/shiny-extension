#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(lubridate)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  tags$script(src = "datasource-info.js"),
  tags$script(src = "tableau.extensions.1.latest.js"),
  
   # Application title
   titlePanel("Shiny Extension!"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30),
         actionButton(inputId = "extension-api-init", label = "Rev up those fryers!")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        textOutput("dsh_name_display"),
        plotOutput("distPlot"),
        dataTableOutput("table_output")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
   
   output$dsh_name_display <- renderText({
     validate(
       need(input$dsh_name, "Something's whack, Jack. Summon the hounds.")
     )
   })
    
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- faithful[, 2] 
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
   
   output$table_output <- renderDataTable({
     expr = iris
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

