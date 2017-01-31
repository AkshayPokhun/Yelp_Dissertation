library(leaflet)
library(RColorBrewer)
library(scales)
library(lattice)
library(dplyr)

source("Microsoft Entity Linking.R")

function(input, output, session) {

  options(shiny.maxRequestSize=150*1024^2)
  
    rv <- reactiveValues( )
    observeEvent(input$file, {rv$data <- input$file})
  
  output$csvtable <- DT::renderDataTable({
    if(is.null(input$file)) return(NULL)
    # style <- isolate(input$style)
    # withProgress(message = 'Creating plot', style = style, value = 0.1, {
    #   Sys.sleep(0.25)
    #   # })
    inFile <- rv$data
    df <- read.csv(inFile$datapath)
    observeEvent(df, {rv$csv <- df})
    
    DT::datatable(df)
    
    })
  
  output$analysis <- DT::renderDataTable({

    input$analyzeButton
    
    if(input$analyzeButton == 0) return(NULL)
      
    entityLinkingFrame <- data.frame()
    df <- rv$csv
    dfText <- df$text
    withProgress(message = 'Sending Data to cloud', value = 0, {
      
    for(i in 1: 5){

      newRow <- data.frame(getEntity(as.character(dfText[i])))
      if(nrow(newRow) == 0) next
      rbind(entityLinkingFrame, newRow)
      
      incProgress(1/nrow(df), detail = paste("Doing part", i))
      Sys.sleep(0.1)
      
    }
    
   
    })
    DT::datatable(as.data.frame(entityLinkingFrame))
    
    })

  
  
}


  
  