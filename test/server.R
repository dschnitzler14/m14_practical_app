library(shiny)

source("histogram.R")
source("load_data.R")

function(input, output, session) {
  histogramServer("hist1")
  data <- load_dataServer("data1")
  
  observe({
    print(head(data()))
  })
}