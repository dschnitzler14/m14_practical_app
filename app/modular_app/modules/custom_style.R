# custom_style.R
customStyleUI <- function(id, js) {
  ns <- NS(id)
  
  tagList(
    tags$head(
      tags$script(HTML(js)),
      tags$style(HTML("
        code {
            display: block;
            padding: 9.5px;
            margin: 0 0 10px;
            margin-top: 10px;
            font-size: 13px;
            line-height: 20px;
            word-break: break-all;
            word-wrap: break-word;
            white-space: pre-wrap;
            background-color: #F5F5F5;
            border: 1px solid rgba(0, 0, 0, 0.15);
            border-radius: 4px; 
            font-family: monospace;
        }"))
    )
  )
}
