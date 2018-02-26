###
### Twitter data in R
###
###
.libPaths("C:/Users/Public/R/win-library/3.4")
#install.packages(c("tidyverse", "ggplot2","twitteR","lubridate","scales","tidytext","broom", "randomForest"))
             
library(tidyverse)
library(ggplot2)
library(purrr)
library(twitteR)
library(lubridate)
library(scales)
library(tidytext)
library(broom)
# 
# 
# # We can request only 3200 tweets at a time; it will return fewer
# # depending on the API
# trump_tweets <- userTimeline("realDonaldTrump", n = 3200)
# trump_tweets_df <- tbl_df(map_df(trump_tweets, as.data.frame))
# 
### Load data?
# if you want to follow along without setting up Twitter authentication,
# just use my dataset:

load(url("http://varianceexplained.org/files/trump_tweets_df.rda"))

### 
tweets <- trump_tweets_df %>%
    select(id, statusSource, text, created) %>%
    extract(statusSource, "source", "Twitter for (.*?)<") %>%
    filter(source %in% c("iPhone", "Android"))


### When does Trump tweet?

tweets %>%
    count(source, hour = hour(with_tz(created, "EST"))) %>%
    mutate(percent = n / sum(n)) %>%
    ggplot(aes(hour, percent, color = source)) +
    geom_line() +
    scale_y_continuous(labels = percent_format()) +
    labs(x = "Hour of day (EST)",
         y = "% of tweets",
         color = "")


### What does Trump tweet?
tweet_picture_counts <- tweets %>%
    filter(!str_detect(text, '^"')) %>%
    count(source,
            picture = ifelse(str_detect(text, "t.co"),
                           "Picture/link", "No picture/link"))
ggplot(tweet_picture_counts, aes(source, n, fill = picture)) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(x = "", y = "Number of tweets", fill = "")


# Content of tweets
reg <- "([^A-Za-z\\d#@']|'(?![A-Za-z\\d#@]))"
tweet_words <- tweets %>%
    filter(!str_detect(text, '^"')) %>%
    mutate(text = str_replace_all(text, "https://t.co/[A-Za-z\\d]+|&amp;", "")) %>%
    unnest_tokens(word, text, token = "regex", pattern = reg) %>%
    filter(!word %in% stop_words$word,
           str_detect(word, "[a-z]"))



# Android vs. iPhone
android_iphone_ratios <- tweet_words %>%
    count(word, source) %>%
    filter(sum(n) >= 5) %>%
    spread(source, n, fill = 0) %>%
    ungroup() %>%
    mutate_each(funs((. + 1) / sum(. + 1)), -word) %>%
    mutate(logratio = log2(Android / iPhone)) %>%
    arrange(desc(logratio))


### Sentiment analysis
# using tidytext's dictionary
nrc <- sentiments %>%
    filter(lexicon == "nrc") %>%
    dplyr::select(word, sentiment)
nrc

sources <- tweet_words %>%
    group_by(source) %>%
    mutate(total_words = n()) %>%
    ungroup() %>%
    distinct(id, source, total_words)

by_source_sentiment <- tweet_words %>%
    inner_join(nrc, by = "word") %>%
    count(sentiment, id) %>%
    ungroup() %>%
    complete(sentiment, id, fill = list(n = 0)) %>%
    inner_join(sources) %>%
    group_by(source, sentiment, total_words) %>%
    summarize(words = sum(n)) %>%
    ungroup()

head(by_source_sentiment)


# Sentiment model

sentiment_differences <- by_source_sentiment %>%
    group_by(sentiment) %>%
    do(tidy(poisson.test(.$words, .$total_words)))

sentiment_differences

sentiment_differences %>%
    ungroup() %>%
    mutate(sentiment = reorder(sentiment, estimate)) %>%
    mutate_each(funs(. - 1), estimate, conf.low, conf.high) %>%
    ggplot(aes(estimate, sentiment)) +
    geom_point() +
    geom_errorbarh(aes(xmin = conf.low, xmax = conf.high)) +
    scale_x_continuous(labels = percent_format()) +
    labs(x = "% increase in Android relative to iPhone",
         y = "Sentiment")





### SOS2900 ADD-ON:
### We will train a model on data on individual tweets, and then try to predict how 
### well we can identify the Donald's digital utterances

# First we create a data set with tweet words and their associated sentiments
feelings_words <- tweet_words %>% 
    left_join(nrc, by=c("word")) %>%
    # Some words do not have associated sentiments.
    # Let us impute a neutral non-sentiment for those.
    mutate(sentiment = ifelse(is.na(sentiment), "neutral",sentiment))


# Now we have a dataset of words with sentiments. We want to classify tweets, and therefore need to summarize the information into a dataset of tweets.
all_feelings <- factor(unique(feelings_words$sentiment))

df <- feelings_words %>%
    select(id, source, sentiment) %>%
    group_by(id,sentiment) %>%
    summarize(num = n()) %>%
    ungroup %>%
    arrange(id, sentiment) %>%
    spread(key=sentiment, value=num, fill = 0) %>%
    group_by(id) %>%
    summarize_all(sum) %>%
    mutate(numwords = rowSums(.[2:ncol(.)])) %>%
    left_join(select(tweets, source, id, created), by="id") %>%
    mutate(random= runif(n=nrow(.),min = 0, max = 1)) %>%
    mutate(donald = ifelse(source=="Android",1,0)) %>%
    mutate_at(vars(c("donald",levels(all_feelings))), as.factor) %>%
    mutate(yearmonth = year(created)*100 + (month(created)-(month(created) %% 3)))



###
### STUDENT ASSIGNMENT IN CLASS
library(randomForest)

# Split the data set into training and testing data (30/70 or so)

# Train an RF model to classify tweets as donaldic or undonaldic

# Use as predictors only the factor variables relating to feelings.

# DISCUSSION: Consider for a second how well your own online persona could be identified using otherwise non-identifiable data?



    
    
