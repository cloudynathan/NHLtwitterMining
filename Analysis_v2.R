#------ Text mining with tidytext

library(twitteR)
library(tidyverse)
library(tidytext)
library(textdata)

#search NHL related tweets
NHLtweets <- searchTwitter("NHL", n=10000, lang="en")

#convert list to vector
text <- sapply(NHLtweets, function(x) x$getText())

#put text in dataframe and convert text column to chr
df <-  data.frame(line = 1:length(text), text = text)
df$text <- as.character(df$text)

#custom stop words
custom_stop_words <- bind_rows(data.frame(word = c("https", 
                                                   "t.co", 
                                                   "0",
                                                   "1",
                                                   "2",
                                                   "3",
                                                   "4",
                                                   "5",
                                                   "6",
                                                   "7",
                                                   "9",
                                                   "10",
                                                   "12",
                                                   "14",
                                                   "17",
                                                   "19",
                                                   "20",
                                                   "22",
                                                   "30",
                                                   "100",
                                                   "200",
                                                   "1000"), 
                                          lexicon = c("custom")), stop_words)

#word count + remove custom stop words, wordcloud
df %>% unnest_tokens(word, text) %>% #break text into inidividual tokens (tokenization)
       count(word, sort = TRUE) %>% #count of words
       anti_join(custom_stop_words) %>% #remove custom stop words
       with(wordcloud(word, 
                      n, 
                      max.words = 100,
                      random.order=F)) #wordcloud
 