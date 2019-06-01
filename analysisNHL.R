library(twitteR)
library(RCurl)
library(tm)
library(wordcloud)
#load packages

consumer_key <- 'xxxxxxxxxxxxxxxxxxxx'
consumer_secret <- 'xxxxxxxxxxxxxxxxxxxx'
access_token <- 'xxxxxxxxxxxxxxxxxxxx'
access_secret <- 'xxxxxxxxxxxxxxxxxxxx'
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
#twitter API authorization process

NHLtweets <- searchTwitter("NHL", n=1200, lang="en")
#search NHL related tweets

NHLtweets_text <- sapply(NHLtweets, function(x) x$getText())
#convert list to vector

NHLtweets_corpus <- Corpus(VectorSource(NHLtweets_text))
#create corpus from vector of tweets

NHLtweets_clean <- tm_map(NHLtweets_corpus, removePunctuation)
NHLtweets_clean <- tm_map(NHLtweets_clean, content_transformer(tolower))
NHLtweets_clean <- tm_map(NHLtweets_clean, removeWords, stopwords("english"))
NHLtweets_clean <- tm_map(NHLtweets_clean, removeNumbers)
NHLtweets_clean <- tm_map(NHLtweets_clean, stripWhitespace)

inspect(NHLtweets_clean[1])
#lower cases, remove numbers, cut out stopwords, remove punctuation, strip whitespace

wordcloud(NHLtweets_clean, random.order=F, max.words=60, scale=c(5,1), colors = c("navyblue", "gold"))
#wordcloud



