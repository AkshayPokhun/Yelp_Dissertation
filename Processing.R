test_file <-read.csv("../../Cleansed Data/test.csv")

  file <- data.frame()

  for(i in 4001 : 5000){
    
    print(i)
    currentRow <- test_file[i,]
    
    result <- getTextAnalysis(test_file$Text[i])
    result <- as.data.frame(result$documents)
    result$id <- NULL
    result <- as.matrix(result)
    result <-toString(result)
    newRow <- data.frame(currentRow$Business_id, currentRow$Categories, result)
    file <- rbind(file, newRow)
    
    
  }

  data_processed <- file_copy
  file_copy <- file
  
  newFrame <- data.frame()
  
  for(i in 1 : nrow(file)){
    
    
    
    
  }
  
  
  ## Replace , with " "
  data_processed$Text <- gsub(",", " ", data_processed$Text)
  text <- as.matrix(data_processed$Text)
  
  
  nlp <- annotationProcess(as.character(file$Text[1]))
  
  nlp$NER
  nlp$lemma[nlp$NER == "MISC"]
  
  
  split <- paste(file$Text, collapse = ",")
  split <- strsplit(split, ",")
  split
  
  
  library(tm)
  corpus <- Corpus(VectorSource(sel))
  tdm <- TermDocumentMatrix(corpus)
  dtm_ft <- weightTfIdf(tdm)
  m <- as.matrix(dtm_ft)
  
  View(as.matrix(tdm))
  removeSparseTerms(tdm, 0.6)
  tmp_copy <- tdm
  tdm <- weightTfIdf(tdm)
  
  pos <- data_processed$Business_id == 2
  
  sel <- data_processed[pos,]
  
  View(as.matrix(tdm))
  