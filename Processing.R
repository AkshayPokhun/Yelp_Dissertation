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
  
  pos <- data_processed$Business_id == 2
  
  sel <- data_processed[pos,]
  
  
  corpus <- Corpus(VectorSource(sel$Text))
  corpus <- tm_map(corpus, stemDocument, language = "english")
  tdm <- TermDocumentMatrix(corpus)
  dtm_ft <- weightTfIdf(tdm)
  m <- as.matrix(dtm_ft)
  
  View(as.matrix(tdm))
  removeSparseTerms(tdm, 0.6)
  tmp_copy <- tdm
  tdm <- weightTfIdf(tdm)
  
  
  View(as.matrix(tdm))
  
  findFreqTerms(tdm, lowfreq = 5)
  
  k_means <- kmeans(dtm_ft, 5)
  kw_with_cluster <- as.data.frame(cbind(m, K_means$cluster))
  plot(K_means$cluster)
  
  
  ##Finding optimal k
  cost_df <- data.frame()
  
  for(i in 1 :10){
    
    k_means <- kmeans(x=tdm, center=i, iter.max = 10)
    cost_df <- rbind(cost_df, cbind(i, k_means$tot.withinss))
    
  }
  
  
  names(cost_df) <- c("cluster", "cost")
  
  library(fpc)
  k_means <- kmeans(tdm, 4)
  
  plotcluster(tdm, k_means$cluster)
  
  with(dtm_ft, pairs(m, col=c(1:5)[k_means$cluster]))
  
  clusplot(m, k_means$cluster, color=TRUE, shade=TRUE, 
           labels=2, lines=0)
  