## Here we are going to find which cluster belongs to which region
## 


## Loading Region Data dictionary into the workspace 

  regionDataDictionary <- list(
    
    Asian = read.csv("AsianDataDictionary.csv"),
    American = read.csv("AmericanDataDictionary.csv"),
    Italian = read.csv("ItalianDataDictionary.csv"),
    Mexican = read.csv("MexicanDataDictionary.csv"),
    Japanese = read.csv("JapaneseDataDictionary.csv")
    
  )
  
  clusterFrame <- list() ## Create blank list to hold clusters of different categories
  buffer <- list() ## Variable to hold results found
  
## Classification Method
  clusterClassification <- function(k_list) {
    
    for(i in 1:5){
      
      print(i)
  
      
      x <- as.matrix( (klist[[i]][[3]])$cluster )
      region <- regionDataDictionary[[i]]
      
      x <- data.frame( Words = rownames(x), Cluster =  x[,1] )
      rownames(x) <- c(1:nrow(x))
      
      result <- NULL
      
      for(j in 1:10){  ## 10 Clusters
        print(j)
        pos <- as.matrix(x$Words[j == x$Cluster])
        
        for(k in 1: nrow(pos)){
          w <- pos[k]
          
          search <- grep(paste("\\<", w, sep= ""), region$Features)  ## Search for word in Region Data dictionary
          if( nrow(as.matrix(search)) ){      ## If a match has been found, position will be greater or equals to 1
            
            reg <- region[search,]
            
            newRow <- data.frame(Word = w, ClusterNo = j, Area = reg$Area, Region = reg$Region)
            result <- rbind(result, newRow)
          }
        }
      }
      
      buffer[[i]] <- result
      
    }
    
    return(buffer)
    
  }
  
  
  buffer <- clusterClassification(klist)
  
  
  
  
  
  x <- as.matrix( results$cluster )
  region <- regionDataDictionary[[1]]
  
  x <- data.frame( Words = rownames(x), Cluster =  x[,1] )
  rownames(x) <- c(1:nrow(x))
  
  result <- NULL
  
  for(j in 1:20){  ## 10 Clusters
    print(j)
    pos <- as.matrix(x$Words[j == x$Cluster])
    
    for(k in 1: nrow(pos)){
      w <- pos[k]
      
      search <- grep(paste("\\<", w, sep= ""), region$Features)  ## Search for word in Region Data dictionary
      if( nrow(as.matrix(search)) ){      ## If a match has been found, position will be greater or equals to 1
        
        reg <- region[search,]
        
        newRow <- data.frame(Word = w, ClusterNo = j, Area = reg$Area, Region = reg$Region)
        result <- rbind(result, newRow)
      }
    }
  }
  
  buffer[[1]] <- result
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  