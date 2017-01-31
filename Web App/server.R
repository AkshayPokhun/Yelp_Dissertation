library(leaflet)
library(RColorBrewer)
library(scales)
library(lattice)
library(dplyr)


function(input, output, session) {

  options(shiny.maxRequestSize=100*1024^2)
  
 
  output$ziptable <- DT::renderDataTable({
    if(is.null(input$file)) return(NULL)
    inFile <- input$file
    df <- read.csv(inFile$datapath)

    DT::datatable(df)
  })
  
  
  
  
  
  
  
}
