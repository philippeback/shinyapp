library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Sunspotter"),

  sidebarLayout(
    sidebarPanel(
      selectInput('startYear',
                  'Start Year',
                  as.character(all_years),
                  selected=as.character(all_years[1]),
                  selectize=FALSE),
      
      selectInput('endYear','End Year',
                  as.character(all_years),
                  selected=as.character(all_years[-1]),
                  selectize=FALSE),
                
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
      includeMarkdown("explain.md")
      
    ),
    
   
    mainPanel(
      
    
      
      textOutput("dateRangeText"),
      plotOutput("tsPlot"),
      plotOutput("distPlot")
      
    )
  )
))
