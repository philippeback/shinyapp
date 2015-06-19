library(shiny)
library(stringr)
library(lubridate)

shinyServer(function(input, output) {

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

    data <- selectedData(input$startYear, input$endYear)
    
    # print(head(data))
    x <- data$x
    y <- data$y
    
    # print(head(x))

    #print(head(y))
    
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
