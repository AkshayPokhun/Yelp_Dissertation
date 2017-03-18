

  categName <- read.csv("../../Cleansed Data/categories_ID.csv")

  categID <- data_processed$Categories
  
  names(dp) <- c("Business_id", "Categories_id", "Categories_Name", "Text")
  
  freq <- as.data.frame(table(data_processed$Categories_id))
  data_processed <- dp

  ##Check if frame has blank reviews
  
  data_processed <- data_processed[data_processed$Text != "",]
  
  
  ## Retrieve Category Name
  newthing <- NULL
  for(i in 1: nrow(freq)){
    print(i)
    currentRow <- freq$Var1[i]
  
    
    pos <- grep(currentRow, dp$Categories_id)
    dp[pos,]$newthing <- as.character(categName$Categories[categName$Categories_ID == currentRow])
    
    newthing <- rbind(newthing)
   
    
  }
  
  
    temp <- as.data.frame(dp$newthing)
    dp$newthing <- dp$Text
    dp$Text <- temp
    
    
    
    
    
extraction <- function(df){
  
  df_Copy <- df
  # countryNames <- read.csv("Data/Countries-Continents-csv.csv")
  # 
  # continent <- data.frame(Continent = table(countryNames$Continent))
  
  newFrame <- df_Copy[grep("Asian", df_Copy$Categories_Name),]
  newFrame <- rbind(newFrame, df_Copy[grep("American", df_Copy$Categories_Name),])
  newFrame <- rbind(newFrame, df_Copy[grep("Italian", df_Copy$Categories_Name),])
  newFrame <- rbind(newFrame, df_Copy[grep("Mexican", df_Copy$Categories_Name),])
  newFrame <- rbind(newFrame, df_Copy[grep("Japanese", df_Copy$Categories_Name),])
  
  return(newFrame)
  
  
}


val <- extraction(data_processed)

f <- function() {
  
  frame1 <- data_processed[grep("Asian", data_processed$Categories_Name),]
  frame2 <- data_processed[grep("American", data_processed$Categories_Name),]
  frame3 <- data_processed[grep("Italian", data_processed$Categories_Name),]
  frame4 <- data_processed[grep("Mexican", data_processed$Categories_Name),]
  frame5 <- data_processed[grep("Japanese", data_processed$Categories_Name),]
  
  
  frame1$Text <- tolower(frame1$Text)
  frame2$Text <- tolower(frame2$Text)
  frame3$Text <- tolower(frame3$Text)
  frame4$Text <- tolower(frame4$Text)
  frame5$Text <- tolower(frame5$Text)
  
}


getCountryName <- function() {
  
  # countryIndex <- grep("Value", daframe)
  
  
}


tdm1 <- TermDocumentMatrix(Corpus(VectorSource(frame1$Text)))
tdm2 <- TermDocumentMatrix(Corpus(VectorSource(frame2$Text)))
tdm3 <- TermDocumentMatrix(Corpus(VectorSource(frame3$Text)))
tdm4 <- TermDocumentMatrix(Corpus(VectorSource(frame4$Text)))
tdm5 <- TermDocumentMatrix(Corpus(VectorSource(frame5$Text)))

tdm1mat <- (tdm1$dimnames)$Terms
tdm1mat <- as.matrix(tdm1mat)

tdm2mat <- (tdm2$dimnames)$Terms
tdm2mat <- as.matrix(tdm2mat)

tdm3mat <- (tdm3$dimnames)$Terms
tdm3mat <- as.matrix(tdm3mat)

tdm4mat <- (tdm4$dimnames)$Terms
tdm4mat <- as.matrix(tdm4mat)

tdm5mat <- (tdm5$dimnames)$Terms
tdm5mat <- as.matrix(tdm5mat)





  
  findCommonWords <- function() {
    

    for(i in 1:nrow(tdm1mat)){
      print(i)
      currentWord <- as.character(tdm1mat[i,2])
      
      if(currentWord %in% tdm1mat & currentWord %in% tdm2mat & currentWord %in% tdm3mat & currentWord %in% 
         tdm4mat & currentWord %in% tdm5mat == TRUE |
         currentWord %in% tdm1mat & currentWord %in% tdm2mat & currentWord %in% tdm3mat & currentWord %in% 
         tdm4mat == TRUE |
         currentWord %in% tdm1mat & currentWord %in% tdm2mat & currentWord %in% tdm3mat & 
         currentWord %in% tdm5mat == TRUE |
         currentWord %in% tdm1mat & currentWord %in% tdm2mat & currentWord %in% 
         tdm4mat & currentWord %in% tdm5mat == TRUE |
         currentWord %in% tdm1mat & currentWord %in% tdm3mat & currentWord %in% 
         tdm4mat & currentWord %in% tdm5mat == TRUE |
         currentWord %in% tdm2mat & currentWord %in% tdm3mat & currentWord %in% 
         tdm4mat & currentWord %in% tdm5mat == TRUE
      ){
        
        if(currentWord %in% wordNotToBeRemoved){ next }
        newList <- rbind(newList, as.character(tdm1mat[i,2]))
      }
      
    }
    
    return(newList)
    
  }
  


  ## Stemming of words in frame

  myList <- list(frame1, frame2, frame3, frame4, frame5)
  myList2 <- list(tdm1mat,tdm2mat,tdm3mat,tdm4mat,tdm5mat)

  stemming <- function() {
    
    require(Rstem)
    
    tdm1mat <- cbind(tdm1mat, as.matrix(wordStem(tdm1mat, language="english")))
    tdm2mat <- cbind(tdm2mat,as.matrix(wordStem(tdm2mat, language="english")))
    tdm3mat <- cbind(tdm3mat,as.matrix(wordStem(tdm3mat, language="english")))
    tdm4mat <- cbind(tdm4mat,as.matrix(wordStem(tdm4mat, language="english")))
    tdm5mat <- cbind(tdm5mat,as.matrix(wordStem(tdm5mat, language="english")))
    
    
  
    for(i in 1 : length(myList)){
      print(i)
      current <- myList[[i]]
      
      for(j in 1:nrow(myList2[[i]])){
        
        currentList <- myList2[[i]]
        current$Text <- gsub(currentList[j,1], currentList[j, (2)], current$Text)
        
        
        
        
        
        
      }
      
      myList[[i]] <- current
      
    }
    
    
    
    
      return(myList)
    
  }
    
  

  frame1 <- myList[[1]] 
  frame2 <- myList[[2]]
  frame3 <- myList[[3]]
  frame4 <- myList[[4]]
  frame5 <- myList[[5]]

    

  myList2[[1]][(myList2[[1]])[,1] %in% (myList2[[1]])[,2]]

 
  temp <- as.matrix( myList2[[1]][((myList2[[1]])[,1] != (myList2[[1]])[,2]), 2])
  
  newList <- rbind(newList, temp)
  
  newList <- NULL  ## WordFilter list
  ## Check stemmed and normal
  for(i in 1:length(myList2)){
    ls <- NULL
    
    currentList <- myList2[[i]]
    temp <- as.matrix( currentList[((currentList)[,1] != (currentList)[,2]), 2])
    
    newRow <- as.matrix(temp[is.na(match(temp, newRow))]) 
    
    for(i in 1: nrow(newRow)){
      if(newRow[i] %in% currentList[,1]){
        print(i)
        ls <- rbind(ls, i)
      }
    }
    
    wordNotToBeRemoved <- rbind(wordNotToBeRemoved, as.matrix(newRow[ls]))
    
    newRow <- as.matrix(newRow[-ls])
    newList <- rbind(newList, newRow)
  
  }
  
  
      
  write.csv(newList, "wordFilteringList.csv")

  
  ##Check if wordFilteringList has  coubntry Names
  checkFilteringList <- function(wordList) {
    
    # countryNames <- read.csv("Data/Countries-Continents-csv.csv")
    # continent <- data.frame(Continent = table(countryNames$Continent))
    
    for(i in 1:nrow(newList)){
     
      # if(nrow(as.matrix(grep(newList[i], tolower(data_processed$Categories_Name)))) > 0){
      #   print(i)
      #   newListCopy <- rbind()
    
        w <- newList[i]
        
        sbstr <- substr(w, 0, (nchar(w)/2)+1)
        
        if(nrow(as.matrix(grep(sbstr, tolower(countryNames$Continent)))) == 0){
          
          if(nrow(as.matrix(grep(sbstr, tolower(countryNames$Country)))) > 0){
            newListCopy <- rbind(newListCopy, w)
          }
          next
        }
        
        newListCopy <- rbind(newListCopy, w)
        
        
        
      # }
  
    }
    
    newListCopy <- as.matrix(newListCopy)
    
    
    return(newListCopy)
    
  }

  
  ##Filtering words < 3
  
  # voidIndex <- NULL
  # 
  # for(i in 1 : length(myList)){
  #   print(i)
  #   current <- myList[[i]]
  #   
  #   for(j in 1:nrow(current)){
  #     
  #     print(cat("Inner loop", j))
  #     
  #     x <- current[j,]$Text
  #     
  #     if(x == "") next
  #     
  #     x <- strsplit(x, " ")
  #     x <- as.data.frame(x)
  # 
  #     voidIndex <- (x == "")
  #     if( T %in% voidIndex ){
  #       
  #       voidIndex <- as.matrix(grep("T", voidIndex))
  #       if(nrow(voidIndex) == nrow(x)) next 
  #       x <- data.frame(Text = x[-voidIndex,])
  #       
  #     }
  #     
  #     wordIndex <- NULL
  #     
  #       for(k in 1: nrow(x)){
  #         
  #         word <- as.character(x[k,])
  # 
  #         if(nchar(word) < 3){
  #           wordIndex <- rbind(wordIndex, k)
  #         } 
  #         
  #       }
  #     
  #     if(is.null(wordIndex)) next 
  #       
  #     current[j,]$Text <- paste(x[-wordIndex,], collapse = " ")
  #     
  #     
  #   }
  #  
  #   myList[[i]] <- current
  #   
  # }
  
  
  

  

  ## Words not be removed
  wordNotToBeRemoved <- list("sandwich", "san")
  if(wordNotToBeRemoved %in% newList == TRUE){
    
    pos <- match(wordNotToBeRemoved, newList)
    newList <- as.matrix(newList[-pos])
    
  }
  
  ## Compress all categories into 1
  
  for(i in 1:length(myList)){
  
  samp <- myList[[i]]
  
  print(i)
  sampCategories <- as.matrix(as.character((as.data.frame((table(as.matrix(samp$Categories_Name)))))[,1]))
  
  if(nrow(sampCategories) == 1) next
  
  val <- NULL
  
  for(j in 1:nrow(sampCategories)){
    print(j)
    pos <- grep(sampCategories[j,], samp$Categories_Name, fixed=T)
    pos1 <-  match(sampCategories[j], samp$Categories_Name)
    pos1 <- samp[pos1,]
    text <- paste(as.character(samp[pos,]$Text), collapse = " ")
    
    if(is.na(match("FALSE", strsplit(text,' ')[[1]] == ""))) next
    
    
    newRow <- data.frame(pos1[,1:3], Text = text)
    val <- rbind(val, newRow)
    
    
  }
  
  myList[[i]] <- val
  
  }
  
  
  
  wordFilteringList <- newList
  
  ## Check for Stemming, WordFilterList & Common words
  
  require(Rstem)
  for(i in 1:5){
    
    currentList <- myList[[i]]
    
    for(k in 1:nrow(myList[[i]])) {
      
    print(k)
    
    currentReview <- (myList[[i]])$Text[k]
    
    currentReviewMatrix <- as.data.frame(strsplit(currentReview, ","))
    currentReviewMatrix <- as.data.frame(strsplit(currentReview, " "))
    
    for(j in 1:nrow(currentReviewMatrix)){
      
      ##Check Stemmed and normal
      word <- as.character(currentReviewMatrix[j,])
      s_word <- wordStem(word)
      
      
      if(nchar(word) < 3) {
        currentReviewMatrix[j,] <- ""
        next
      }
      
      if(s_word == word | s_word %in% myList2[[i]][,1] ){
        if(s_word %in% wordFilteringList){
          currentReviewMatrix[j,] <- ""
        }
        next
      } else if(s_word %in% wordFilteringList){
        currentReviewMatrix[j,] <- ""
        next
      }
 
      currentReviewMatrix[j,] <- ""
      
    }
    
    currentReviewMatrix <- paste(currentReviewMatrix[currentReviewMatrix != ""], collapse = " ")
    currentList[k,]$Text <- currentReviewMatrix

    }
    
    currentList <- currentList[currentList$Text != "",]
    
    myList[[i]] <- currentList
    
  }
  
  
  reviewsList <- myList
  
  myList <- reviewsList
  
  

