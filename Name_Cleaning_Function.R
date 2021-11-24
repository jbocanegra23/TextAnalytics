
##############################################################################
## Title: Email Names Cleaning & Standardization
## Author: Jonathan R Bocanegra
##
## Step 1: Create Custom Functions:
##      --> Suffix Abbreviations
##      --> Removing Middle Initial
##      --> Taking the first person's name in a John & Nora OR John and Nora
## Step 2: Create Name Cleaning Function
##      --> Upper Case
##      --> Remove Digits
##      --> AND/& Names Function
##      --> Remove Punctuation
##      --> Title & Suffix Mapping
##      --> Custom Name Mapping (Needs Specified) 
##      --> Remove Middle Initials
##      --> Trim White-space
##      --> Title Case
##############################################################################

## Test Vectors:
## first_names <- c('jonathan', 'SARAH', 'Kim D.', 'John & Nora', 'bill', 
##                 'E Derek', 'A', 'A J')
## last_names <- c('bocanegra', 'jantausch', 'THOMPSON', 
##                'Alastra', 'jantausch jr.', 'Bocanegra III',
##                'smith iv', 'thompson sr.', 'thompson sr md')

library(tidyverse)
library(stringr)

titleSuffixMapping <- c(
  "JR" = "",
  "JUNIOR" = "",
  "SR" = "",
  "SENIOR" = "",
  "III" = "",
  "II" = "",
  "\\bIV\\b" = "",
  "\\bIV\\b" = "",
  "\\bV$" = "",
  "\\bMD\\b" = "",
  "\\bESQ\\b" = "",
  "ESQUIRE" = "",
  "\\bHON\\b" = "",
  "\\bHONORABLE\\b" = "",
  "\\bJUDGE\\b" = "",
  "\\bMR\\b" = "",
  "\\bMISTER\\b" = "",
  "\\bMRS\\b" = "",
  "\\bMS\\b" = "",
  "\\bMISS\\b" = "",
  "\\bMSGR\\b" = "",
  "\\bPROF\\b" = "",
  "\\bPROFESSOR\\b" = "",
  "\\bRT\\b" = "",
  "\\bST\\b" = "",
  "\\bSAINT\\b" = "",
  "\\bPHD\\b" = "",
  "\\bGEN\\b" = "",
  "GENERAL" = "",
  "\\bSIR\\b" = "",
  "\\bCOMMISSIONER\\b" = "",
  "\\bDR\\b" = "",
  "REVEREND" = "",
  "\\bREV\\b" = "",
  "DOCTOR" = "",
  "\\bMAYOR\\b" = "",
  "COUNCILWOMAN" = "",
  "COUNCILMAN" = "",
  "\\bGOV\\b" = "",
  "GOVERNOR" = "",
  "PRESIDENT" = "",
  "\\bREP\\b" = "",
  "REPRESENTATIVE" = "",
  "SENATOR" = "",
  "\\bSEN\\b" = ""
  )


## Removing a trailing middle initial
middleInitial <- function(x) {ifelse(nchar(x)>3,str_replace_all(x, "\\s\\w{1}\\b",""), x)}


## If there is an "AND" or a "&" then take the proceeding word(s)
andNamesFun <- function(x) {
      ifelse(str_detect(x, '\\bAND\\b'),sub('(^.*?)\\bAND\\b.*', '\\1',x),
            ifelse(str_detect(x,'&'),sub('(^.*?)&.*', '\\1',x),x))}


## Name Cleaning Function
nameCleaning <- function(x, mapping = titleSuffixMapping, name_abbreviations = c("^NULL$" = "NULL"),
                          remove_middle_initial = TRUE) {
    x <- str_to_upper(x)
    x <- str_remove_all(x, '[[:digit:]]')
    x <- lapply(x, andNamesFun)
    x <- str_remove_all(x, "[[:punct:]]|[[:symbol:]]")
    x <- str_replace_all(x, mapping)
    x <- str_replace_all(x, name_abbreviations)
    x <- lapply(x,function(x){ifelse(remove_middle_initial, middleInitial(x), x)})
    x <- trimws(x)
    x <- str_to_title(x)
}
