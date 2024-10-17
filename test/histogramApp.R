#histogramApp

source("/Users/user/github/m14_practical_analysis_app/test/histogram.R")

histogramApp <- function() {
  ui <- fluidPage(
    histogramUI("hist1")
  )
  server <- function(input, output, session) {
    histogramServer("hist1")
  }
  shinyApp(ui, server)  
}

histogramApp()