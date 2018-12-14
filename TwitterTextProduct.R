library(twitteR)
library(tm)
library(topicmodels)
library(igraph)
library(ROAuth)
library(tm)
library(SnowballC)
library(wordcloud)
library(dplyr)
library(tidyr)
require(RColorBrewer)

## setup_twitter_oauth()


twitter.function <- function(searchterm, numTweets, remove.words, minFreq, maxWords) {
  twList <- searchTwitter(searchterm, n = numTweets,
                          lang = "en")
  twDF <- twListToDF(twList)
  myCorpus <- Corpus(VectorSource(twDF$text))
  myCorpus <- tm_map(myCorpus, content_transformer(tolower))
  removeHandles <- function(x) gsub("@•\\s", "", x)
  myCorpus <- tm_map(myCorpus, content_transformer(removeHandles))
  removeNumPunct <- function(x) gsub("[^[:alpha:][:space:]]*","",x)
  myCorpus <- tm_map(myCorpus, content_transformer(removeNumPunct))
  myCorpus <- tm_map(myCorpus, removePunctuation)
  myCorpus <- tm_map(myCorpus, removeNumbers)
  myCorpus <- tm_map(myCorpus, removeWords, stopwords("english"))
  myCorpus <- tm_map(myCorpus, stripWhitespace)
  myCorpus <- tm_map(myCorpus, removeWords, remove.words)
  dtm <- TermDocumentMatrix(myCorpus)
  m <- as.matrix(dtm)
  v <- sort(rowSums(m), decreasing = TRUE)
  d <- data.frame(word = names(v), freq = v)
  set.seed(1234)
  wordcloud2(d, color = 'random-light', backgroundColor = "dark blue")
}

### Example ###
twitter.function("dewine", numTweets = 5000, 
                 remove.words = c("mike dewine", "dewine", 
                                  "mike", "ohio"))
