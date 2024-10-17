library(shiny)
library(shinyAce)
library(bslib)

js <- "
Shiny.addCustomMessageHandler('resetFileInput', function(elementId) {
  var el = document.getElementById(elementId);
  if (el) {
    el.value = '';
  }
});
"

ui <- tagList(
  tags$head(tags$script(HTML(js)),
            tags$style(HTML("
            code {
                display:block;
                padding:9.5px;
                margin:0 0 10px;
                margin-top:10px;
                font-size:13px;
                line-height:20px;
                word-break:break-all;
                word-wrap:break-word;
                white-space:pre-wrap;
                background-color:#F5F5F5;
                border:1px solid rgba(0,0,0,0.15);
                border-radius:4px; 
                font-family:monospace;
            }"))),
  page_navbar(
    title = "Data Analysis Tutorial",
    bg = "#FFCC80",
    inverse = FALSE,
    nav_panel(
      title = "Introduction",
      fluidPage(
        fluidRow(
          column(12, "What is R and what is this applet?"),
          accordion(
            accordion_panel(
              "Introduction",
              strong("Welcome to this Data Analysis and R Tutorial."),
              em("There are many, many tutorials to learn data analysis and R, ranging from beginner to advanced, so why make a new one?"),
              p("Well, we think that one of the best ways to learn something is to do something. So, we have created this app for you, that guides you through the bascis of R using your own data and allows you to explore what it it can do. This app creates a 'mock R' environment that works just like the real R, but it a little less overwhelming.")
            ),
            accordion_panel(
              "What is R?",
              p("At its most fundamental level, R is a programming language, just like Python, JavaScript, or C. However, it was developed for statistical analysis and data visualisations. What you use it for is pretty much up to you! In fact, this app is written using an R feature, called 'Shiny'!"),
              p("With so many possibilities, it can be easy to feel overwhelmed, especially if you have never written a single line of code before or are learning the basics of statistical analysis!"),
              p("But don't worry, we've got you. This app will guide you through the basics and help you get started. The best thing about R is the amount of support available online from other R users!")
            ),
            accordion_panel(
              "What is this app?",
              p("This app has been developed to guide you through the basics of R and how to you use it to analyse your own data! You will first learn how to run basic commands in R and you will have the chance to play around with the code in a 'sandbox', before we move on to loading your data, examining it, analysing it, and finally reaching the final stage of interpretation. At any stage of this tutorial, you can download the script you have generated and open it in R Studio"),
        
            ),
            accordion_panel(
              "Background",
              p("Most of the teaching material here is from a virtual video textbook that is freely available in the resources link at the top, however we will also include additonal resources for your to use!")
            )
          )
        )
      )
    ),
    nav_panel(
      title = "Discovering R",
      fluidPage(
        fluidRow(
          column(4, 
                 strong("Let's have a little play with R, shall we?"),
          accordion(
            accordion_panel(
              "Say hello to the sandbox",
              p("See that box to the right of this? That is your coding screen. You can type any code you want in there, hit 'run code' and see what it does."),
              p("The ", tags$code("#"), "symbol is used to comment out lines you don't want to run"),
              p("Let's start with something simple. Type in ", tags$code("2+2"), " hit run code, and see what happens")
              
            ),
            accordion_panel(
              "Assign a Variable",
              p("We can save the result as a variable to be called later. Try this: ", tags$code("sum_result <- 2+2"), " "),
              p("Then try calling that variable by running ", tags$code("sum_result"), ""),
              p("Now, you can use that variable for future operations. For example ", tags$code("added_sum_result <- sum_result +2"), " ")
              )
          )
        ),
        column(3, 
               aceEditor("learning_code", 
                         mode = "r", 
                         theme = "github", 
                         value = "#type your code in here!", 
                         height = "200px", 
                         fontSize = 14, 
                         showLineNumbers = TRUE),
               actionButton("run_learning_code", "Run Code"),
               actionButton("clear_learning_cache", "Clear Cache"),
               downloadButton("download_learning_code", "Download Code")
        ),
        column(3,
               actionButton("clear_history_learning", "Clear History"),
               verbatimTextOutput("code_history_learning")),
      )
    )
    ),
    nav_panel(
      title = "Examine Data",
      fluidPage(
        fluidRow(
          column(5,
                 strong("First, let's take a look at the data we have!"),
                 accordion(
                   accordion_panel(
                     "1. Loading Data",
                     p("Let's load the data first. Use the uploader to load your .csv file"),
                     fileInput("file1", "Choose CSV File", accept = ".csv")
                   ),
                   accordion_panel(
                     "2. Intro to R code",
                     p("The code box allows you to write R code and see what it does. Why not give it a try?"),
                     em("type in ", tags$code("2+2"), " hit run code, and see what happens")
                   ),
                   accordion_panel(
                     "3. Step 1: Processing Data",
                     p("Now, let's get stuck in with our data. First, let's look at what we are working with"),
                     p("Type in: ", tags$code("data <- uploaded_file"), " and then hit run code."),
                     p("Where is the data? Find out by calling ", tags$code("data"), " and hitting run code again.")
                   ),
                   accordion_panel(
                     "4. Step 2: Processing Data",
                     p("Great! Now our data is loaded into our mock R!"),
                     p("What should we do next? I think getting an average of our technical replicates would be a good place to start. \n
                       So, type in (or copy) this: ", tags$code("data_with_average <- data %>%
  mutate(avg_rep = rowMeans(select(., rep1:rep3)))"), " and then hit run code."),
                     p("Call this new variable with ", tags$code("data_with_average"), " and hitting run code again.")
                   )
                 )
          ),
          column(3, 
                 aceEditor("user_code", 
                           mode = "r", 
                           theme = "github", 
                           value = "#type your code in here!", 
                           height = "200px", 
                           fontSize = 14, 
                           showLineNumbers = TRUE),
                 actionButton("run_code", "Run Code"),
                 actionButton("clear_cache", "Clear Cache"),
                 downloadButton("download_code", "Download Code")
          ),
          column(6,
                 actionButton("clear_history", "Clear History"),
                 verbatimTextOutput("code_history")
          )
        ),
        fluidRow(
          column(12,
                 plotOutput("plot_output")
          )
        )
      )
    ),
    nav_panel(
      title = "Analysis",
      fluidPage(
        fluidRow(
          column(3,
                 strong("Now, let's move on the the analysis!"),
                 accordion(
                   accordion_panel(
                     "1. Step 1",
                     
                   ),
                   accordion_panel(
                     "2. Step 2",
                     
                   ),
                   accordion_panel(
                     "3. Step 3",
                     
                   ),
                   accordion_panel(
                     "4. Step 4",
                     
                   )
                 )
          ),
          column(3, 
                 aceEditor("user_code_analysis", 
                           mode = "r", 
                           theme = "github", 
                           value = "#type your code in here!", 
                           height = "200px", 
                           fontSize = 14, 
                           showLineNumbers = TRUE),
                 actionButton("run_code_analysis", "Run Code"),
                 actionButton("clear_cache_analysis", "Clear Cache"),
                 downloadButton("download_code_analysis", "Download Code")
          ),
          column(6,
                 actionButton("clear_history_analysis", "Clear History"),
                 verbatimTextOutput("code_history_analysis")
          )
        ),
        fluidRow(
          column(12,
                 plotOutput("plot_output_analysis")
          )
        )
      )
    ),
    nav_spacer(),
    nav_menu(
      title = "Links",
      align = "right",
      nav_item(tags$a("Posit", href = "https://posit.co")),
      nav_item(tags$a("Shiny", href = "https://shiny.posit.co"))
    )
  )
)
