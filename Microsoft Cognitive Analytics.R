### Libraries
if(!isNamespaceLoaded("httr")) library(httr)
if(!isNamespaceLoaded("jsonlite"))library(jsonlite)
  
  # library(mscstexta4r)


### Workspace
  
  getTextAnalysis <- function(t){ 
    url <- "https://westus.api.cognitive.microsoft.com/text/analytics/v2.0/keyphrases"
    key <- "5863e810535e44b691c8e105e3b448bf"
    
    
    request_body <- data.frame(
      # language = c("en","en"),
      id = c("1"),
      text = t
    )
    
    # Converting the Request body(Dataframe) to Request body(JSON)
    
    request_body_json <- toJSON(list(documents = request_body), auto_unbox = TRUE)
    
    # Below we are calling API (Adding Request headers using add_headers)
    
    result <- POST(url,
                   body = request_body_json,
                   add_headers(.headers = c("Content-Type"="application/json","Ocp-Apim-Subscription-Key"=key)))
    Output <- content(result)
  
    output_df <- as.data.frame(Output$documents)
    
    matrix <- matrix()
    
    for(i in 1: ncol(output_df)){
      newRow <- as.character(output_df[,i])
      matrix <- rbind(matrix, newRow)
      
    }
  
    # returns Output
    return (matrix)
    
}


# Function returns x object
# z <- x$documents Then view z
  
  
  
  
  
  # textaInit()
  # 
  # mymatrix <- read.csv("../../Cleansed Data/test.csv")
  # text <- mymatrix$Text
  # text <- text[1:100]
  # 
  # 
  # 
  # topics <- textaDetectTopics(documents = text,
  #                   stopWords = NULL,
  #                   topicsToExclude = NULL,
  #                   minDocumentsPerWord = NULL,
  #                   maxDocumentsPerWord = NULL,
  #                   resultsPollInterval = 0L,
  #                   resultsTimeout = 1200L,
  #                   verbose = T
  #                   )
  # 
  # docsLanguage <- rep("en", length(text))
  # keyphrases <- textaKeyPhrases(documents = text,
  #                               languages = docsLanguage)
  # 
  
### Tutorial link: https://bigdataenthusiast.wordpress.com/2016/10/02/microsoft-cognitive-services-text-analytics-api-in-r/

mat <- matrix(ncol=5)

  
  
  
