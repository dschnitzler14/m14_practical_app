library(shiny)

source("histogram.R")
source("load_data.R")

fluidPage(
  titlePanel("Main Shiny App with Histogram Module"),
  histogramUI("hist1"),
  load_dataUI("data1")
  
  )
