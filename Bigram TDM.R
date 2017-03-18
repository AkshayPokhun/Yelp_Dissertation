library(tm)
library(RWeka)
data(crude)


BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
txtTdmBi <- TermDocumentMatrix(corpus, control = list(tokenize = BigramTokenizer))


dtm_ft <- weightTfIdf(txtTdmBi)
m <- as.matrix(txtTdmBi)

rownames(m) <- 1:nrow(m)

norm_eucl <- function(m)
  m/apply(m, 1, function(x) sum(x^2)^.5)

m_norm <- norm_eucl(m)

random.imp <- function (a){
  missing <- is.na(a)
  n.missing <- sum(missing)
  a.obs <- a[!missing]
  imputed <- a
  imputed[missing] <- sample (a.obs, n.missing, replace=TRUE)
  return (imputed)
}

results <- kmeans(dtm_ft, 20) ## Good clusters
results1 <- kmeans(txtTdmBi, 20)

clusplot(as.matrix(m_norm), results$cluster, color=TRUE, shade=TRUE, 
         labels=2, lines=0)


rownames(m_normCopy) <- rownames(dtm_ft)

frequency <- colSums(m)

View(as.matrix(results1$cluster))


c("Hartigan-Wong", 
  "Lloyd", "Forgy", "MacQueen")


