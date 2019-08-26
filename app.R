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
    DT::DTOutput("rslt")
  )
)
)

# Define server logic.
server <- function(input, output, session) {
  
  json_dump <- reactiveVal()
  
  df <- reactive({
    result <- json_dump(input$data) %>%
      jsonlite::fromJSON() %>%
      `[[`('_data') %>%
      map_dfr(
        .f = function(x){
          pull(x, `_formattedValue`) %>%
            t() %>%
            as_tibble()
        }
      )
    return(DT::datatable(result))
  })
  
  output$dsh_name_display <- renderText({
    validate(
      need(input$dsh_name, "Something's whack, Jack. Summon the hounds.")
    )
  })
  
  output$rslt <- DT::renderDT({
    df()
  })
  
  runcodeServer()
  
}

# Run the application. 
shinyApp(ui = ui, server = server)

