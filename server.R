library(shiny)
library(stringr)
library(lubridate)

shinyServer(function(input, output) {

  output$distPlot <- renderPlot({
    
    data <- selectedData(input$startYear, input$endYear)
    
    ssn    <- data$y
    bins <- seq(min(ssn), max(ssn), length.out = input$bins + 1)
    hist(ssn, 
         breaks = bins, 
         col = 'orange', 
         border = 'white',
         xlab="Observed number of Sunspots",
         title="Histogram of SSN")
  })
 
  output$dateRangeText  <- renderText({
    paste("From ", 
          paste(as.character(input$startYear), 
                as.character(input$endYear), sep = " to ")
    )
  })
  
  output$tsPlot <- renderPlot({

    data <- selectedData(input$startYear, input$endYear)

    x <- data$x
    y <- data$y

    plot(x,y,pch=20)
    
    fit<-lm(y ~ x)
    abline(fit, col="red", lwd="4")
    seq1 <- seq_along(x)
    
    pi = 3.141592654
    omega = 1.0/(12.0 * 11) # 11  years avg period

    fit2<-lm(y ~ poly(seq1, 3) + sin(2*pi*omega*seq1) + cos(2*pi*omega*seq1))
  
    lines(x,predict(fit2, data.frame(x=seq1)), col="green", lwd="4")
    
  })
  
})
