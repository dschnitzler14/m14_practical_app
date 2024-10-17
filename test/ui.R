library(shiny)

fluidPage(
    selectInput("var", "Variable", names(mtcars)),
    numericInput("bins", "bins", 10, min = 1),
    plotOutput("hist")
)

