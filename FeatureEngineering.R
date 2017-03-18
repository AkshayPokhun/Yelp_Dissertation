
featureEngineering <- function(ds){
  
  
  mymatrix <- ds
  busID <- data.frame(Business_id = c(as.matrix(mymatrix$Business_id)))
  userID <- data.frame(User_id = c(as.matrix(mymatrix$User_id)))  
  
  ### Business_id
  
  existing <- data.frame()
  
  
  for(i in 1:nrow(userID)){
    
    user <- as.character(userID[i,])
    print(user)
    if(user %in% as.matrix(existing)) { 
      print("Exists") 
      next 
    }
    
    newRow <- data.frame(User_id = c(user), User_NID = c(nrow(existing) + 1))
    print(newRow)
    existing <- rbind(existing, newRow)
    
  }
  

  arrayBID <- data.frame()
  for(i in 1:nrow(existing)){
    print(i)
    pos <- regexpr(existing$User_id[i], mymatrix$User_id) == 1
    if (1 %in% pos) {
      mymatrix$User_id[pos] <- existing$User_NID[i]
    }
  }
  

 
###  Attributes.Good.forkids
 
  attrKids <- mymatrix$attributes_Good.for.Kids
  kids <- attrKids
  

  if( "TRUE" %in% is.na(kids)){
    index <- is.na(kids)
    kids[index] <- FALSE
  }
 
  kids <- as.numeric(kids)
  mymatrix$attributes_Good.for.Kids <- kids
  
  
### Alcohol
  
  alcohol <- mymatrix$attributes_Alcohol
  index <- regexpr("none", alcohol) == TRUE
  alcohol[index] <- 0
  
  index <- alcohol == ""
  alcohol[index] <- 0
  
  index <- regexpr("full_bar", alcohol) == TRUE
  alcohol[index] <- 10
  
  index <- regexpr("beer_and_wine", alcohol) == TRUE
  alcohol[index] <- 5
  
  alc <- data.frame(attributes_Alcohol = c("none", "beer_and_wine", 'full_bar'), attributes_Alcohol_ID = c(0, 5, 10))
  mymatrix$attributes_Alcohol <- alcohol
    
### Noise level
  
  noise <- mymatrix$attributes_Noise.Level
  index <- regexpr("quiet", noise) == TRUE
  noise[index] <- 10
  
  index <- noise == ""
  noise[index] <- 10
  
  index <- regexpr("loud", noise) == TRUE
  noise[index] <- 20
  
  index <- regexpr("average", noise) == TRUE
  noise[index] <- 30
  
  index <- regexpr("very_loud", noise) == TRUE
  noise[index] <- 40
  
  noise_csv <- data.frame(attributes_Noise.Level = c("quiet", "loud", "average", "very_loud"), attributes_Noise.Level_ID = c(10, 20, 30, 40))
  mymatrix$attributes_Noise.Level <- noise
  
  write.csv(mymatrix, "matrix.csv")
  
### categories
  
  categories <- mymatrix$Categories

  categ <- as.data.frame(table(categories))
  
  for(i in 1:nrow(categ)){
    categ$Freq[i] <- i
  }
  
  categ <- data.frame(Categories = categ$categories, Categories_ID = c(categ$Freq))
  # write.csv(categ, "categories_ID.csv")
  
  for(i in 1:nrow(categ)){
    print(i)
    index <- categ$Categories[i] == categories
    categories[index] <- categ$Categories[i]
  }
  
  mymatrix$Categories <- categories
  
  # tdm <- tm_map(categories, PlainTextDocument)
  # reviews.tdm <- TermDocumentMatrix(categories, control = list(wordLengths=c(1, Inf)))
  # 
  # corpus <- tm_map(corpus, content_transformer(tolower))
  # corpus <- tm_map(corpus, removePunctuation)
  # corpus <- tm_map(corpus, stripWhitespace)
  # corpus <- tm_map(corpus, removeWords, stopwords("english"))
  # 
  # dtm <- DocumentTermMatrix(corpus)
  # dtm2 <- as.matrix(dtm)
  # 
  # frequency <- colSums(dtm2)
  # 
  # splitCat
  # nrow(splitCat)
  # ncol(splitCat)
  # 
  # sum(splitCat == '"Fast Food"')

### Parking
  
  parking <- as.data.frame(mymatrix$attributes_Parking, stringsAsFactors = FALSE)
  
  for(i in 1: nrow(parking)){
    print(i)
    
    park <- parking[i,]
    park <- gsub("[^[:alnum:][:blank:],]", "", park)
    park <- gsub("ugarage ", "", park)
    park <- gsub("ustreet ", "", park)
    park <- gsub("uvalidated ", "", park)
    park <- gsub("ulot ", "", park)
    park <- gsub("uvalet ", "", park)
    
    park <- gsub("True", "1", park)
    park <- gsub("False", "0", park)
    
    parking[i,] <- park
  }

  mat <- mymatrix
  mymatrix$attributes_Parking <- parking
  
  
}
  

