### Libraries

library(jsonlite)
library(httr)


# Converting the Request body(Dataframe) to Request body(JSON)

getEntity <- function(text) {
  
  
  
  url <- "https://westus.api.cognitive.microsoft.com/entitylinking/v1.0/link"
    key <- "d21e5cfe59a646079793f840814dd0e2"
    
    result <- POST(url,
                   body = text,
                   add_headers(.headers = c("Content-Type"="text/plain","Ocp-Apim-Subscription-Key"=key)))
    Output <- content(result)
    return(Output) 
    
  }

  # Output
  
# Show Output
      


### 
  # review <- toString(mymatrix$Text[15233])
  # getEntity(review)
  

