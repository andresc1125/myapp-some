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

list_choices <-  unique(msleep$vore)[!is.na(unique(msleep$vore))]
names(list_choices) <- paste(unique(msleep$vore)[!is.na(unique(msleep$vore))],"vore",sep="")

# Define UI for application that draws a histogram
ui <- fluidPage( 
  
  # Application title
  titlePanel("This is a new Shiny app"),
  
  includeMarkdown("references.md"),
  
  selectInput("select", label = h3("Plot by type of alimentation"), 
              choices = list_choices,
              selected = 1),
  
  plotOutput(outputId = "plot")
  
  
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$plot <- renderPlot({
    ggplot(msleep %>% filter(vore == input$select), aes(bodywt, sleep_total, colour = vore)) +
      scale_x_log10() +
      col_scale + geom_point()
  })
}


col_scale <- scale_colour_discrete(limits = unique(msleep$vore))

# Run the application 
shinyApp(ui = ui, server = server)
