library(shiny)


shinyUI(fluidPage(
  
  # Application title
  titlePanel("Sunspotter"),

  sidebarLayout(
    sidebarPanel(
      selectInput('startYear',
                  'Start Year',
                  as.character(sunspots$YEAR),
                  selected=as.character(sunspots$YEAR[1]),
                  selectize=FALSE),
      
      selectInput('endYear','End Year',
                  as.character(sunspots$YEAR),
                  selected=as.character(sunspots$YEAR[-1]),
                  selectize=FALSE),
                
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
      
      # dateRangeInput("range", label = h3("Date range"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      textOutput("dateRangeText"),
      plotOutput("tsPlot"),
      plotOutput("distPlot")
      
    )
  )
))
