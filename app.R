
library(shiny)
library(shinyjs)
library(V8)
library(tidyverse)
library(lubridate)
library(vroom)

ui <- fluidPage(
  useShinyjs(),
  extendShinyjs(script = 'js/read_tds.js'),
  # tags$script(src = "datasource-info.js"),
  tags$script(src = "tableau.extensions.1.latest.js"),
  
  titlePanel("Shiny Extension!"),
  
  inputPanel(
    dateRangeInput(inputId = 'date_range', label = 'Date Range'),
    selectInput(inputId = 'chain_id', label = 'Chain', choices = list(`Select` = 0L)),
    selectInput(inputId = 'hierarchy_path', label = 'Region', choices = list(`Select` = 0L)),
    selectInput(inputId = 'org_id', label = 'Organization', choices = list(`Select` = 0L)),
    #uiOutput('group_id'),
    downloadButton(outputId = 'download_data')
  ),
  sidebarLayout(
    sidebarPanel(
      fluidRow(
        column(width = 6, uiOutput("dimensions")),
        column(width = 6, uiOutput("measures"))
      )
    ),
    
    mainPanel(
      # verbatimTextOutput('selected_dimensions'),
      # verbatimTextOutput('reduced_tbl'),
      # verbatimTextOutput('piece'),
      #verbatimTextOutput("piece2"),
      tableOutput('table')
    )
  )
)

# Define server logic.
server <- function(input, output, session) {
  
  tds <- reactive({
    
    vals <- input$data[['_data']] %>%
      map_dfr(
        .x = .,
        .f = function(x){
          x %>%
            map_dfc(
              .x = .,
              .f = function(x){
                x[['_formattedValue']]
              }
            )
        }
      )
    
    names(vals) <- input$data[['_columns']] %>%
      map_chr(
        .x = .,
        .f = function(x){
          x[['_fieldName']]
        }
      )
    
    vals
  })
  
  # output$piece <- renderPrint({
  #   input$data[['_columns']]
  # })
  
  # output$piece2 <- renderPrint({
  #   tds() %>% head()
  # })
  
  # json_dump <- jsonlite::fromJSON("tableau-datasource-dump.json")
  # 
  # ds <- json_dump %>%
  #   `[[`('_data') %>%
  #   map_dfr(
  #     .x = .,
  #     .f = function(x){
  #       pull(x, `_formattedValue`) %>%
  #         t() %>%
  #         as_tibble()
  #     }
  #   )
  # 
  # names(ds) <- json_dump[['_columns']][['_fieldName']]

  fields <- reactive({
    req(tds())
    names(tds())
  })
  
  output$dimensions <- renderUI({
    checkboxGroupInput(inputId = 'chosen_dimensions', label = 'Dimensions', choices = fields())
  })
  
  output$measures <- renderUI({
    checkboxGroupInput(inputId = 'chosen_measures', label = 'Measures', choices = fields())
  })
  
  # output$group_id <- renderUI({
  #   req(fields())
  #   vals <- pull(tds(), `Group ID`) %>% unique()
  #   selectInput(inputId = 'chosen_group_id', label = 'Group ID', choices = vals)
  # })
  
  # output$table <- DT::renderDT({
  #   DT::datatable(tds())
  # })
  
  # output$selected_dimensions <- renderPrint({
  #   input$chosen_dimensions
  # })
  
  # output$reduced_tbl <- renderPrint({
  #   validate(need(fields(), "Select fields to see the reduced table."))
  #   tds() %>%
  #     select(one_of(input$chosen_dimensions)) %>%
  #     head()
  # })
  
  payload <- reactive({
    validate(need(input$chosen_dimensions != 0L, 'Pick a dimension to display a snapshot table.'))
    pl <- tds() %>%
      select(one_of(input$chosen_dimensions))
    pl
  })
  
  output$table <- renderTable({
    payload() %>% head(10)
  })
  
  output$download_data <- downloadHandler(
    filename = function() {
      paste("data-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      vroom_write(payload(), delim = ",", file)
    },
    contentType = "text/csv"
  )
  
}

# Run the application. 
shinyApp(ui = ui, server = server)

