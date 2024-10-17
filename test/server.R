library(shiny)

source("histogram.R")

function(input, output, session) {
    histogramServer("hist1")
}