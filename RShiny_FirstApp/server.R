library(readr)
library(DT)
library(ggplot2)
library(shiny)
library(shinydashboard)
library(rsconnect)
library(dplyr)

setwd("D:/DataScience/RShiny Projects/FirstApp/")

survey <- read_csv("EMP_ENG_DATA.csv", col_names = TRUE)
employee <- read_csv("HEADCOUNT ANALYTICS.csv", col_names = TRUE)

mergedata <-  survey %>% inner_join(employee, by = c("EMPID", "BRANCH", "FUNCTION"))

server <- function(input, output) {
  plotfunct <- reactive({
    if (input$size)
    {
      ggplot(data = mergedata, aes_string(x = input$xaxis, y = input$yaxis)) +
        geom_point(aes_string(
          color = input$color,
          size = factor(mergedata$EXP)
        ), alpha = input$alpha)+
        labs(title = paste0("Change in ", input$yaxis, " for change in ", input$xaxis))
    }
    else
    {
      ggplot(data = mergedata, aes_string(x = input$xaxis, y = input$yaxis)) +
        geom_point(aes_string(color = input$color), alpha = input$alpha) +
        # geom_line(stat = "summary",fun.y=quantile,probs=.4,linetype=2,color="red")+
        labs(title = paste0("Change in ", input$yaxis, " for change in ", input$xaxis))
      
    }
    
  })
  
  plotfuncthis <- reactive({
    if (input$hist)
    {
      ggplot(data = mergedata, aes_string(x = input$histselect)) +
        geom_histogram(aes_string(fill = input$color),binwidth=input$binwidth,position = "dodge")
    }
  })
  
  output$plot1 <- renderPlot({
    plotfunct()
  })
  output$plot2 <-
    renderPlot({
      ggplot(data = mergedata, aes_string(x = input$xaxis, y = input$yaxis)) +
        geom_line(aes_string(group = input$color, color = input$color)) +
        labs(title = paste0("Change in ", input$yaxis, " for change in ", input$xaxis))
      
    })
  
  output$plot3 <- renderPlot({
    plotfuncthis()
  })
  
  output$datatable <-renderDataTable({
    mergedata
  })
  
}
 
# rsconnect::deployApp('D:/DataScience/RShiny Projects/FirstApp')
