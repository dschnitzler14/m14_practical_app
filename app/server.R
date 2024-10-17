library(shiny)

server <- function(input, output, session) {
  
  # Initialize a reactiveValues object to store history and the shared environment
  rv <- reactiveValues(
    code_history = character(),
    plot_history = list(),
    code_history_analysis = character(),
    plot_history_analysis = list(),
    code_history_learning = character(),
    plot_history_learning = list(),
    shared_env = new.env(parent = globalenv())
  )
  
  observeEvent(input$run_code, {
    user_code <- input$user_code
    
    if (!is.null(input$file1)) {
      # Read the uploaded file into a data frame
      rv$shared_env$uploaded_file <- read.csv(input$file1$datapath)
    }
    
    output_text <- capture.output({
      tryCatch({
        eval(parse(text = user_code), envir = rv$shared_env)
      }, error = function(e) {
        cat("Error: ", e$message, "\n")
      })
    })
    
    rv$code_history <- c(rv$code_history, paste0("> ", user_code), paste(output_text, collapse = "\n"))
    
    output$code_history <- renderPrint({
      cat(rv$code_history, sep = "\n\n")
    })
    
    output$plot_output <- renderPlot({
      tryCatch({
        eval(parse(text = user_code), envir = rv$shared_env)
      }, error = function(e) {
        # Handle the error gracefully, possibly by showing an empty plot or a message
        plot.new()
        text(0.5, 0.5, "Error in plot", cex = 1.5)
      })
    })
  })
  
  observeEvent(input$clear_history, {
    rv$code_history <- character()
  })
  
  observeEvent(input$clear_cache, {
    # Clear Ace Editor content
    updateAceEditor(session, "user_code", value = "")
    
    # Clear code history
    rv$code_history <- character()
    
    # Reset file input using JavaScript
    session$sendCustomMessage(type = "resetFileInput", message = "file1")
  })
  
  observeEvent(input$run_code_analysis, {
    user_code_analysis <- input$user_code_analysis
    
    output_text <- capture.output({
      tryCatch({
        eval(parse(text = user_code_analysis), envir = rv$shared_env)
      }, error = function(e) {
        cat("Error: ", e$message, "\n")
      })
    })
    
    rv$code_history_analysis <- c(rv$code_history_analysis, paste0("> ", user_code_analysis), paste(output_text, collapse = "\n"))
    
    output$code_history_analysis <- renderPrint({
      cat(rv$code_history_analysis, sep = "\n\n")
    })
    
    output$plot_output_analysis <- renderPlot({
      tryCatch({
        eval(parse(text = user_code_analysis), envir = rv$shared_env)
      }, error = function(e) {
        # Handle the error gracefully, possibly by showing an empty plot or a message
        plot.new()
        text(0.5, 0.5, "Error in plot", cex = 1.5)
      })
    })
  })
  
  observeEvent(input$clear_history_analysis, {
    rv$code_history_analysis <- character()
  })
  
  observeEvent(input$clear_cache_analysis, {
    # Clear Ace Editor content
    updateAceEditor(session, "user_code_analysis", value = "")
    
    # Clear code history
    rv$code_history_analysis <- character()
    
    # Reset file input using JavaScript
    session$sendCustomMessage(type = "resetFileInput", message = "file1")
  })
  
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
        # Handle the error gracefully, possibly by showing an empty plot or a message
        plot.new()
        text(0.5, 0.5, "Error in plot", cex = 1.5)
      })
    })
  })
  
  observeEvent(input$clear_history_learning, {
    rv$code_history_learning <- character()
  })
  
  observeEvent(input$clear_learning_cache, {
    # Clear Ace Editor content
    updateAceEditor(session, "learning_code", value = "")
    
    # Clear code history
    rv$code_history_learning <- character()
  })
  
  # Download handler for exporting the code
  output$download_code <- downloadHandler(
    filename = function() {
      paste("user_code", Sys.Date(), ".R", sep = "")
    },
    content = function(file) {
      writeLines(input$user_code, file)
    }
  )
  
  # Download handler for exporting the analysis code
  output$download_code_analysis <- downloadHandler(
    filename = function() {
      paste("user_code_analysis", Sys.Date(), ".R", sep = "")
    },
    content = function(file) {
      writeLines(input$user_code_analysis, file)
    }
  )
  
  # Download handler for exporting the learning code
  output$download_code_learning <- downloadHandler(
    filename = function() {
      paste("learning_code", Sys.Date(), ".R", sep = "")
    },
    content = function(file) {
      writeLines(input$learning_code, file)
    }
  )
}
