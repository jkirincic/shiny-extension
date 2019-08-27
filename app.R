#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)
library(tidyverse)
library(lubridate)


# Define UI for application that draws a histogram
ui <- fluidPage(
  useShinyjs(),
  tags$script(src = "datasource-info.js"),
  tags$script(src = "tableau.extensions.1.latest.js"),
  
  titlePanel("Shiny Extension!"),
  
  sidebarLayout(
    sidebarPanel(
      actionButton(inputId = "extension_api_init", label = "Start"),
      runcodeUI(code = "shinyjs::alert('Hello!')")
    ),
  mainPanel(
    textOutput("dsh_name_display"),
    verbatimTextOutput("table")
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
  
  # df <- reactive({
  #   
  #   req(input$data)
  #   
  #   updated_payload <- input$data %>%
  #     `[[`('_data') %>%
  #     map_dfr(
  #       .f = function(x){
  #         map_dfr()
  #       }
  #     ) %>%
  #     head(10)
  #   updated_payload
  # })
  
  # output$table <- DT::renderDT({
  #   req(df())
  #   thing <- df() %>%
  #     DT::datatable()
  #   thing
  # })
  
  output$table <- renderPrint({
    input$data[['_data']] %>% str()
  })
  
  runcodeServer()
  
}

# Run the application. 
shinyApp(ui = ui, server = server)

