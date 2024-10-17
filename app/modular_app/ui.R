library(shiny)
library(shinyAce)
library(bslib)

source("modules/custom_style.R")
source("modules/learning_code_module.R")
source("modules/learning_code_history_module.R")



js <- "
Shiny.addCustomMessageHandler('resetFileInput', function(elementId) {
  var el = document.getElementById(elementId);
  if (el) {
    el.value = '';
  }
});
"
tagList(customStyleUI("custom1", js = js),
      
      page_navbar(
        title = "Data Analysis Tutorial",
        bg = "#FFCC80",
        inverse = FALSE,
        nav_panel(
          title = "Introduction",
          fluidPage(
            fluidRow(
              column(12, markdown("# **What is R and what is this applet?**")),
              accordion(
                accordion_panel(
                  markdown("## Introduction"),
                  includeMarkdown("markdown/nav_panel_introduction/introduction.md")),
                accordion_panel(
                  markdown("## What is R?"),
                  includeMarkdown("markdown/nav_panel_introduction/what_is_R.Rmd")),
                accordion_panel(
                  markdown("## What is this app?"),
                  includeMarkdown("markdown/nav_panel_introduction/what_is_this_app.Rmd")),
                accordion_panel(
                  markdown("## Background"),
                  includeMarkdown("markdown/nav_panel_introduction/background.Rmd")),
                )
              )
            )
          ),
        nav_panel(
          title = "Discovering R",
          fluidPage(
            fluidRow(
              column(4, 
                     markdown("# Let's have a little play with R, shall we?"),
                     accordion(
                       accordion_panel(
                         markdown("## Say hello to the sandbox"),
                         includeMarkdown("markdown/nav_panel_discovering_r/let_play.Rmd")),
                       accordion_panel(
                         markdown("## Assign a Variable"),
                         includeMarkdown("markdown/nav_panel_discovering_r/assign_a_variable.Rmd")),
                     )
              ),
              column(3, 
                     learningCodeModuleUI("learning_code")
              ),
              column(3,
                     learningCodeHistoryModuleUI("learning_code_history")
              ),
            )
          )
        ),
        )
)
      






