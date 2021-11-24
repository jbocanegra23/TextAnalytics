
##############################################################################
## Title: Simple Jaccard Similarity Score
## Author: Jonathan R Bocanegra
##
## Step 1: Convert string to ngrams 
## Step 2: Jaccard Similarity Score
##############################################################################

## Load necessary packages
library(stringr)
library(dplyr)
library(tidry)


## String to ngrams
string_to_ngrams <- function(initial_string,ngrams) {
  set_1 <- vector()
  string_split <- vector()
  string_split <- str_split(toupper(initial_string), pattern = " ")
  
  for (j in 1:length(string_split[[1]])){
    for (i in 1:(nchar(string_split[[1]][j])-1)) {
      if (nchar(str_sub(string_split[[1]][j], start = i, end = i+(ngrams-1))) >= ngrams) {
        set_1 <- append(set_1, str_sub(string_split[[1]][j], start = i, end = i+(ngrams-1)))
        }
    }
  }
return(set_1)
}

## Jaccard Calculation
jaccard_similarity <- function(ngrams,x,y) {
    stringx_ngrams <- string_to_ngrams(initial_string = x, ngrams=ngrams)
    stringy_ngrams <- string_to_ngrams(initial_string = y, ngrams=ngrams)
  
    intersection <- length(intersect(stringx_ngrams, stringy_ngrams))
    union <- length(union(stringx_ngrams, stringy_ngrams))
  
    score <- ifelse(x==y, 1,ifelse(intersection == 0 & union == 0, 0,
          intersection/union))
    return(score)
}



