library(shiny)

source("modules/learning_code_module.R")
source("modules/learning_code_history_module.R")


server <- function(input, output, session) {
  rv <- reactiveValues(
    code_history_learning = character(),
    plot_history_learning = list()
  )
  
  learningCodeModuleServer("learning_code", rv)
  learningCodeHistoryModuleServer("learning_code_history", rv)
  
}