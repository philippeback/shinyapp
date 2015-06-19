library(shiny)
library(stringr)
library(lubridate)


sunspots <- read.table('data/spot_num.txt',header=TRUE)
sunspots[,1]<-as.factor(sunspots[,1])
sunspots[,2]<-as.factor(sunspots[,2])
smry_SSN<-summary(sunspots)[,3]

y0 <- sunspots[, 3] 
x0 <- ymd(paste0(sunspots[,1],str_sub(paste0('0',sunspots[,2]), -2),'01'))


#http://solarscience.msfc.nasa.gov/SunspotCycle.shtml
#http://solarscience.msfc.nasa.gov/greenwch.shtml

selectedData <- function(startYear, endYear) {
  
  start <- ymd(paste0(input$startYear,'-01-01')) # ymd(input$range[1]) # ymd("2010-01-01")
  ending <- ymd(paste0(input$endYear, '-12-31')) #input$range[2])
  
  print(paste('start', start))
  print(paste('end', ending))  
  
  # print(input$range)
  sel<- (x0 >= start) & (x0 <= ending)
  # print(sel)
  x <- x0[ sel ]
  y <- y0[ sel ]
  c(x,y)
}

shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #libr
  #  1) It is "reactive" and therefore should be automatically
  #     re-executed when inputs change
  #  2) Its output type is a plot
  
  #output$dates <- renderText({ 
  #  paste("You have selected", input$range)
  #})
  
  output$distPlot <- renderPlot({
    ssn    <- sunspots[, 3]
    bins <- seq(min(ssn), max(ssn), length.out = input$bins + 1)
    hist(ssn, 
         breaks = bins, 
         col = 'orange', 
         border = 'white',
         xlab="Observed number of Sunspots")
  })
 
  output$dateRangeText  <- renderText({
    paste("input$dateRange is", 
          paste(as.character(input$startYear), 
                as.character(endYear), collapse = " to ")
    )
  })
  
  output$tsPlot <- renderPlot({

    start <- ymd(paste0(input$startYear,'-01-01')) # ymd(input$range[1]) # ymd("2010-01-01")
    ending <- ymd(paste0(input$endYear, '-12-31')) #input$range[2])

    print(paste('start', start))
    print(paste('end', ending))  

    # print(input$range)
    sel<- (x0 >= start) & (x0 <= ending)
    # print(sel)
    x <- x0[ sel ]
    y <- y0[ sel ]
    plot(x,y)
    fit<-lm(y ~ x)
    abline(fit, col="red")
    seq1 <- seq_along(x)
    fit2<-lm(y ~ poly(seq1,4))
    
    pi = 3.141592654
    omega = 1.0/120.0
    sin_comp <- 
    
    "poly(seq1,4)"
    fit2<-lm(y ~ poly(seq1, 3) + sin(2*pi*omega*seq1) + cos(2*pi*omega*seq1))
  
    lines(x,predict(fit2, data.frame(x=seq1)), col="green")
    
  })
  
 
  
})
