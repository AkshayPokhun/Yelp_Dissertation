### Libraries
  library(rJava)
  library(coreNLP)
  
### Workspace
  initCoreNLP()
  
  review
  
  obj <- annotateString(review)
  token <- getToken(obj)
  
  token$NER
  token$lemma[token$NER == "MISC"]
  