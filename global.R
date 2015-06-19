# Global variables and functions

library(lubridate)
library(stringr)

sunspots <- read.table('data/spot_num.txt',header=TRUE)
all_years=unique(sunspots[,1])
sunspots[,1]<-as.factor(sunspots[,1])
sunspots[,2]<-as.factor(sunspots[,2])
smry_SSN<-summary(sunspots)[,3]
print(smry_SSN)

y0 <- sunspots[, 3] 
x0 <- ymd(paste0(sunspots[,1],str_sub(paste0('0',sunspots[,2]), -2),'01'))

selectedData <- function(startYear, endYear) {
  
  start <- ymd(paste0(startYear,'-01-01')) # ymd(input$range[1]) # ymd("2010-01-01")
  ending <- ymd(paste0(endYear, '-12-31')) #input$range[2])
  
  print(paste('start', start))
  print(paste('end', ending))  
  
  # print(input$range)

  sel<- (x0 >= start) & (x0 <= ending)
  # print(sel)
  x <- x0[ sel ]
  y <- y0[ sel ]
  return(list(x=x,y=y))
}

#list[x,y]<-selectedData('1999', '2015')
