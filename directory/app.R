library(shiny)
library(tidyverse)

names <- read_csv("names.csv")

ui <- fluidPage(
    numericInput(inputId = "system", label = "System", value = 10, min = 10, max = 986),
    numericInput(inputId = "school", label = "School", value = 2, min = 1, max = 9000),
    textOutput("name")
)

server <- function(input, output, session) {
    
    output$name <- renderText(
        names %>%
            filter(system == input$system, school == input$school) %>%
            transmute(name = paste(system_name, school_name, sep = "/")) %>%
            magrittr::extract2("name")
    )

}

shinyApp(ui = ui, server = server)
