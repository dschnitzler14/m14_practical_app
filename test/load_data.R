# load data

load_dataUI <- function(id){
  ns <- NS(id)
  
  tagList(
    fileInput(ns("file"), label = "Upload CSV file here")
  )
}

load_dataServer <- function(id){
  moduleServer(id, function(input, output, session) {
    
    data <- reactive({
      req(input$file)
      read.csv(input$file$datapath)
    })
    
    return(data)
  })
}