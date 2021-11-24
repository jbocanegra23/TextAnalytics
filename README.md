# TextAnalytics

### Twitter Text Wordclouds

This code creates a simple process to reduce the steps of pulling tweet data, 
cleaning the text, and then creating a wordcloud for visualization all in a function that can 
be customizable within the function. 

Using Wordcloud2 there are more opportunities for customization. It is possible to consider
splitting this function into two steps. First cleaning the data into a simple 2 column data 
frame and then a function for the wordcloud.

### Text Cleaning

The design for this code was motivated by a client request to clean up an email file. The email names field was a free-form field which contained many variants of names. The code is designed standardize all of the name fields contained in the file. 

### Jaccard Similarity Score

I've used this similarity score for many fuzzy matching processes, typically done in python. Decided to take some time to create the function in R for future fuzzy matching use cases that may come down the line. 
