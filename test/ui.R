library(shiny)

source("histogram.R")

fluidPage(
  titlePanel("Main Shiny App with Histogram Module"),
  histogramUI("hist1")
  )
