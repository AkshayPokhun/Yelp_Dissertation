### Libraries
  library(httr)
  library(jsonlite)
  library(mscstexta4r)


### Tutorial link: https://bigdataenthusiast.wordpress.com/2016/10/02/microsoft-cognitive-services-text-analytics-api-in-r/
  
  key <- "https://westus.api.cognitive.microsoft.com/text/analytics/v2.0/"
  url <- "5863e810535e44b691c8e105e3b448bf"
  
  textaInit()
  
  mymatrix <- read.csv("../../Cleansed Data/test.csv")
  text <- mymatrix$Text
  text <- text[1:100]

  
  
  topics <- textaDetectTopics(documents = text,
                    stopWords = NULL,
                    topicsToExclude = NULL,
                    minDocumentsPerWord = NULL,
                    maxDocumentsPerWord = NULL,
                    resultsPollInterval = 0L,
                    resultsTimeout = 1200L,
                    verbose = T
                    )

  docsLanguage <- rep("en", length(text))
  keyphrases <- textaKeyPhrases(documents = text,
                                languages = docsLanguage)
  
  
  request_body <- data.frame(
    # language = c("en","en"),
    id = c("1","2"),
    text = c("This is wasted! I'm angry","This is awesome! Good Job Team! appreciated")
  )
  
  # Converting the Request body(Dataframe) to Request body(JSON)
  
  request_body_json <- toJSON(list(documents = request_body), auto_unbox = TRUE)
  
  # Below we are calling API (Adding Request headers using add_headers)
  
  result <- POST(url,
                 body = request_body_json,
                 add_headers(.headers = c("Content-Type"="application/json","Ocp-Apim-Subscription-Key"=key)))
  Output <- content(result)
  
  # Show Output
  Output
  
  
  
  cls <- function() {
    cat("\014")
  }


