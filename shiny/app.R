
# Packages ----------------------------------------------------------------


library(shiny)
library(tidyverse)
library(data.table)
library(lubridate)

# Import Data -------------------------------------------------------------


productive_dat <- as.data.table(productive_dat)



# Shiny App ---------------------------------------------------------------


ui <- fluidPage(
  titlePanel("HBS Report"),
  
  column(4, wellPanel(
    dateRangeInput('dateRange',
                   label = 'Filter by date',
                   start = Sys.Date()-30, 
                   end = Sys.Date()+30,
    )
  )),
  column(4, wellPanel(
    selectInput('campus',
                label = 'Campus',
                choices = c("mb", "parn")
    )
  )),
  column(6,
         dataTableOutput('my_table')
  )
)

server <- function(input, output, session) {
  output$my_table  <- renderDataTable({
    
    # Productive table, filtered by dateRange and campus
    productive_dat %>% 
      group_by(year, month, productive_hour_type) %>% 
      filter(DATE >= input$dateRange[1] & 
               DATE <= input$dateRange[2] &
               campus == input$campus) %>% 
      summarise(sum_hours = sum(sum_hours),
                sum_fte = sum(sum_fte))
    
    # 
    
  })
}

shinyApp(ui = ui, server = server)