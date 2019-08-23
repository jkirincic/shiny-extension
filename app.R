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
  
  titlePanel("Shiny Extension!"),
  
  sidebarLayout(
    actionButton(inputId = "extension-api-init", label = "Rev up those fryers!"),
  mainPanel(
    textOutput("dsh_name_display"),
    dataTableOutput("table_output")
  )
)
)

# Define server logic.
server <- function(input, output, session) {
  
  output$dsh_name_display <- renderText({
    validate(
      need(input$dsh_name, "Something's whack, Jack. Summon the hounds.")
    )
  })
  
  output$table_output <- renderDataTable({
    input$data
  })
}

# Run the application. 
shinyApp(ui = ui, server = server)

