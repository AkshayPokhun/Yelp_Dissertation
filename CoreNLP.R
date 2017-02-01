### Libraries
if(!isNamespaceLoaded("rJava"))  library(rJava)
if(!isNamespaceLoaded("coreNLP")){ 
  library(coreNLP) 
  initCoreNLP()
  }

  
### Workspace


  annotationProcess <- function(text){
    # newFrame <- data.frame()
    # for(i in 1: nrow(df)){
      obj <- annotateString(text)
      token <- getToken(obj)
      return (token)
      # print(token)
      # newFrame <- rbind(f, token)
    }
  
  
    # newFile <- data.frame()
    # 
    # newRow <- newFrame[newFrame$NER == "MISC" | newFrame$POS == "NN",]
    # newFile <- rbind(newFile, newRow)
    # return(newFile)
    
  
  # }
  
  
  
  # token$NER
  # token$lemma[token$NER == "MISC"]
  
  

  