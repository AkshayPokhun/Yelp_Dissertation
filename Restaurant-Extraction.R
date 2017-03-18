restaurantExtraction <- function(data1, data2){
  
  ##  Importing Yelp dataset
  reviewsData <- data1
  businessData <- data2  
  
  ##  Selecting Attribute Categories from the academic dataset
  categories <- as.matrix(businessData$categories)
  
  ##  Retrieving the positions where categories == Restaurants
  vectorPosition <- grep("Restaurants", categories)
  
  ##  Extracting the Restaurants data based on the position found above
  restaurantsData <- businessData[vectorPosition,]

  ##  Extract the businessID of restaurant in Reviews.ds and Accademic.ds   
  ##  To reduce load time (To avoy reading the entire ds each time)
  businessID <- as.matrix(restaurantsData$business_id)
  reviewsData.bid <- as.matrix(reviewsData$business_id)
  
  ##  Initialize the vectorPosition to save the extracted row
  vectorPosition <- NULL
  
  ##  Begin loop
  for(i in 1:nrow(reviewsData)){
    print(i)
    ##
    ##  The row number/index is save in newROw and converted as matrix
    ##  To be able to read from a specifix index
    newRow <- as.matrix(grep(businessID[i], reviewsData.bid))
    
      for( j in 1 : nrow(newRow)){
        
        currenIndex <- restaurantsData[i,]
        currentReview <- reviewsData[newRow[j],]
        
        newRow1 <- data.frame(
          Business_id = businessID[i], 
          Categories = currenIndex$categories, 
          Stars = currentReview$stars, 
          User_id = currentReview$user_id, 
          Text = currentReview$text, 
          attributes_Good.for.Kids = currenIndex$attributes_Good.for.Kids, 
          attributes_Alcohol = currenIndex$attributes_Alcohol,
          attributes_Noise.Level = currenIndex$attributes_Noise.Level, 
          attributes_Parking = currenIndex$attributes_Parking, 
          attributes_Price.Range = currenIndex$attributes_Price.Range
        )
        
        vectorPosition <- rbind(vectorPosition, newRow1)
        
      }
  
  }
  
  ##  Create a copy of the data and then return it
  restaurantDataSelection <- vectorPosition
  
  return(restaurantDataSelection)
  
}

