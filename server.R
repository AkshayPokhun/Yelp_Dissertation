library(leaflet)
library(RColorBrewer)
library(scales)
library(lattice)
library(dplyr)

source("Microsoft Entity Linking.R")
source("CoreNLP.R")
source("Microsoft Cognitive Analytics.R")

function(input, output, session) {

  options(shiny.maxRequestSize=150*1024^2)
  
    rv <- reactiveValues( )
    observeEvent(input$file, {
      rv$data <- input$file
      })
    
  ## CSV Explorer  
  output$csvtable <- DT::renderDataTable({
    if(is.null(input$file)) return(NULL)
    
    inFile <- rv$data
    df <- read.csv(inFile$datapath)
    observeEvent(df, {
      rv$csv <- df
      rv$csvText <- as.data.frame(df$text)
      rv$rowNum <- nrow(rv$csvText)
      })
    
    DT::datatable(df)
    
    })
  
  ## Entity Linking  
  output$analysis <- DT::renderDataTable({

    input$analyzeButton
    
    if(input$analyzeButton == 0) return(NULL)
      
    entityLinkingFrame <- data.frame()
    
    dfText <- rv$csvText
    withProgress(message = 'Sending Data to cloud', value = 0, {
      
    for(i in 1: rv$rowNum){

      newRow <- data.frame(getEntity(as.character(dfText[i,])))
      if(nrow(newRow) == 0) next
      entityLinkingFrame <- rbind(entityLinkingFrame, newRow)
      
      incProgress(1/rv$rowNum, detail = paste("Doing part", i))
      Sys.sleep(0.1)
      
    }
    
   
    })
    DT::datatable(as.data.frame(entityLinkingFrame))
    
    })
  
  ## Core Nlp
  output$corenlptable <- DT::renderDataTable({
    input$corenlpButton
    
    if(input$corenlpButton == 0) return (NULL)
    
    rowNum <- nrow(rv$csvText)
    df <- data.frame()
    
    withProgress(message="Computing data..", value = 0, {
      for(i in 1: rv$rowNum){
        
       newRow <- annotationProcess(as.character(rv$csvText[i,]))
       df <- rbind(df, newRow)
       
      incProgress(1/rv$rowNum, detail = paste("Doing part", i))
      Sys.sleep(0.1)
      }
      
    })
    
    DT::datatable(as.data.frame(df))
    
    
  })
  
  ## Text Analytics
  output$textaTable <- DT::renderDataTable({
    
    input$textaButton
    if(input$textaButton == 0) return(NULL)
    
    matrix <- matrix()
    file <- rv$csvText
    
    withProgress(message = "Analyzing text...", value = 0, {
      
      for(i in 1:rv$rowNum){
        
        newRow <- getTextAnalysis(as.character(file[i,]))
        matrix <- rbind(matrix, newRow)
        
        incProgress(1/rv$rowNum, detail = paste("Doing part", i))
        Sys.sleep(0.1)
        
      }
      
      matrix <- matrix(matrix, ncol = 5)
      
    })
    DT::datatable(as.data.frame(matrix))
    
  })
  
  
}





  
  