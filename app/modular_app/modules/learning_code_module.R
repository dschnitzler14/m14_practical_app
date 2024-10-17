# learning_code_module.R

learningCodeModuleUI <- function(id) {
  ns <- NS(id)  # Create namespace for the module
  tagList(
    aceEditor(ns("learning_code"), 
              mode = "r", 
              theme = "github", 
              value = "#type your code in here!", 
              height = "200px", 
              fontSize = 14, 
              showLineNumbers = TRUE),
    actionButton(ns("run_learning_code"), "Run Code"),
    actionButton(ns("clear_learning_cache"), "Clear Cache"),
    downloadButton(ns("download_learning_code"), "Download Code")
  )
}

learningCodeModuleServer <- function(id, rv) {
  moduleServer(id, function(input, output, session) {
    
    observeEvent(input$run_learning_code, {
      user_code_learning <- input$learning_code
      user_env_learning <- new.env(parent = globalenv())
      
      output_text <- capture.output({
        tryCatch({
          eval(parse(text = user_code_learning), envir = user_env_learning)
        }, error = function(e) {
          cat("Error: ", e$message, "\n")
        })
      })
      
      rv$code_history_learning <- c(rv$code_history_learning, paste0("> ", user_code_learning), paste(output_text, collapse = "\n"))
      
      output$code_history_learning <- renderPrint({
        cat(rv$code_history_learning, sep = "\n\n")
      })
      
      output$plot_output_learning <- renderPlot({
        tryCatch({
          eval(parse(text = user_code_learning), envir = user_env_learning)
        }, error = function(e) {
          plot.new()
          text(0.5, 0.5, "Error in plot", cex = 1.5)
        })
      })
    })
    
    observeEvent(input$clear_learning_cache, {
      updateAceEditor(session, "learning_code", value = "")
      rv$code_history_learning <- character()
    })
    
    output$download_learning_code <- downloadHandler(
      filename = function() {
        paste("learning_code", Sys.Date(), ".R", sep = "")
      },
      content = function(file) {
        writeLines(input$learning_code, file)
      }
    )
    
  })
}
