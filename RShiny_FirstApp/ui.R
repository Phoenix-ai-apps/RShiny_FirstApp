#RShiny
library(shiny)

ui <- fluidPage(
  titlePanel("Abhishek's Dashboard", windowTitle = "Dashboard"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "xaxis",
        label = "X axis variable",
        choices = c(
          "Employee Engagement Score" = "EES",
          "Rewards and Recognition" = "RR",
          "Career Growth" = "CG",
          "Leadership Team" = "LT"
        ),
        selected = "EES"
      ),
      
      selectInput(
        inputId = "yaxis",
        label = "Y axis variable",
        choices = c(
          "Employee Engagement Score" = "EES",
          "Rewards and Recognition" = "RR",
          "Career Growth" = "CG",
          "Leadership Team" = "LT"
        ),
        selected = "RR"
      ),
      radioButtons(
        inputId = "color",
        label = "Color plot by:",
        choices = c(
          "Branch" = "BRANCH",
          "Department" = "FUNCTION",
          "Gender" = "GENDER",
          "Qualification" = "EDUQUAL",
          "Work experience" = "EXP"
        ),
        selected = "BRANCH"
      ),
      checkboxInput(
        inputId = "size",
        label = "Set size by Work Experience:",
        value = FALSE
      ),
      sliderInput(
        inputId = "alpha",
        label = "Transparency",
        min = 0,
        max = 1,
        value = 0.5
      ),
      wellPanel(
        checkboxInput(
          inputId = "hist",
          label = "Show histogram:",
          value = FALSE
        ),
        conditionalPanel(
          "input.hist==true",
          radioButtons(
            inputId = "histselect",
            label = "Select type of histogram",
            choices = list(
              "Employee Engagement Score" = "EES",
              "Rewards and Recognition" = "RR",
              "Career Growth" = "CG",
              "Leadership Team" = "LT"
            )
          ),
          sliderInput(inputId = "binwidth",
                      label = "Set binwidth:",
                      min=1,max=30,value = 15)
          
        )
      )),
    mainPanel(tabsetPanel(
      type = "tabs",
      tabPanel("Plot",
               fluidRow(
                 splitLayout(
                   cellWidths = c("50%", "50%"),
                   plotOutput(outputId = "plot1"),
                   plotOutput(outputId = "plot2")
                 )
               ),fluidRow(
                 splitLayout(
                   cellWidths = c("50%", "50%"),
                   plotOutput(outputId = "plot3"),
                   plotOutput(outputId = "plot4")
                 )
               )
      ),
      tabPanel("Data Table", dataTableOutput(outputId = "datatable"))
    ))
  )
)