### Libraries
  library(rJava)
  library(coreNLP)
  
### Workspace
  initCoreNLP()
  
  review <- "The Szechuan Wontons are actually Thai style peanut sauce wontons.  
  The Kung Pao chicken is completely lacking in spice.  The pork fried rice is their own mild concoction, not reminiscent of any particular style. 
  And the brown rice was mushy.  Bland was the only word that came to mind at the end of a $35 take-home dinner.  The $2 egg rolls were the best thing about it, 
  lots of flavor, but still not enough of a reason to choose Baoding over other local options other than the dining room which is huge and cozy.  So three stars for having a 
  nice atmosphere for a sit down dinner.  Now if they can just add some character to the food..."
  
  obj <- annotateString(Output)
  token <- getToken(obj)
  
  token$NER
  token$lemma[token$NER == "NUMBER"]
  