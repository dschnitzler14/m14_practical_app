learningCodeHistoryModuleUI <- function(id) {
  ns <- NS(id)
  tagList(
    actionButton(ns("clear_history_learning"), "Clear History"),
    verbatimTextOutput(ns("code_history_learning"))
  )
}

learningCodeHistoryModuleServer <- function(id, rv) {
  moduleServer(id, function(input, output, session) {
    
    observeEvent(input$clear_history_learning, {
      rv$code_history_learning <- character()
    })
    
    output$code_history_learning <- renderPrint({
      cat(rv$code_history_learning, sep = "\n\n")
    })
  })
}
