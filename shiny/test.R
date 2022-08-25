# Test environment for tidy syntax ----------------------------------------

library(shiny)
library(tidyverse)
library(data.table)

productive_dat <- as.data.table(productive_dat)

ui <- fluidPage(
  titlePanel("HBS Report"),
  
  column(4, wellPanel(
    dateRangeInput('dateRange',
                   label = 'Filter crimes by date',
                   start = as.Date('2021-01-01') , end = as.Date('2022-06-01')
    )
  )),
  column(6,
         dataTableOutput('my_table')
  )
)

server <- function(input, output, session) {
  output$my_table  <- renderDataTable({
    
    data <- productive_dat[,.("Total Hours" = sum(HOURS),
                              "FTE Equivilance" = round(sum(fte_equiv),0)),
                           .(DATE, campus, productive_hour_type)]
  
    # Filter the data
    data %>% filter(DATE >= input$dateRange[1] & DATE <= input$dateRange[2])
  })
}

shinyApp(ui = ui, server = server)