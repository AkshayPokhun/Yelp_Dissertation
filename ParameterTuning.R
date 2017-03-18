
### Load dataset
	reviews.ds <- read.csv("yelp_academic_dataset_review.csv", stringsAsFactors = FALSE)
	# tip.ds <- read.csv("yelp_academic_dataset_tip.csv", stringsAsFactors = FALSE)
	academic.ds <- read.csv("yelp_academic_dataset_business(Restaurants).csv", stringsAsFactors = FALSE)

### Extract attributes
	#main.dataframe <- data.frame(reviews.ds["business_id"], reviews.ds["text"], reviews.ds["stars"], reviews.ds["user_id"])
	local.dataframe <- read.csv("2.csv")
	
	acc.bid <- as.data.frame(academic.ds$business_id)
	rev.bid <- as.data.frame(reviews.ds$business_id)
	

	
	
	
	
	
	
	for (i in 1:nrow(reviews.ds)) {

	  print(i)
	    if((rev.bid[i,]) %in% as.matrix(acc.bid)){
	      
	      accPosition <- match(rev.bid[i,], as.matrix(acc.bid))
	      newRow <- data.frame(Business_id = reviews.ds$business_id[i], Categories = academic.ds$categories[accPosition], Stars = reviews.ds$stars[i], User_id = reviews.ds$user_id[i], 
	                           Text = reviews.ds$text[i], attributes_Good.for.Kids = academic.ds$attributes_Good.for.Kids[accPosition], attributes_Alcohol = academic.ds$attributes_Alcohol[accPosition],
	                           attributes_Noise.Level = academic.ds$attributes_Noise.Level[accPosition], attributes_Parking = academic.ds$attributes_Parking[accPosition], 
	                           attributes_Price.Range = academic.ds$attributes_Price.Range[accPosition])
	      local.dataframe <- rbind(local.dataframe, newRow)
	      
	      
	    }
	  
	}



