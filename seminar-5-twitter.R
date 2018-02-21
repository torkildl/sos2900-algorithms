###
### Twitter scraping in R
###
###


library(dplyr)
library(purrr)
library(twitteR)

# You'd need to set global options with an authenticated app
setup_twitter_oauth(getOption("twitter_consumer_key"),
                    getOption("twitter_consumer_secret"),
                    getOption("twitter_access_token"),
                    getOption("twitter_access_token_secret"))

# We can request only 3200 tweets at a time; it will return fewer
# depending on the API
trump_tweets <- userTimeline("realDonaldTrump", n = 3200)
trump_tweets_df <- tbl_df(map_df(trump_tweets, as.data.frame))

### Load data?
# if you want to follow along without setting up Twitter authentication,
# just use my dataset:
# load(url("http://varianceexplained.org/files/trump_tweets_df.rda"))

###
library(tidyr)
tweets <- trump_tweets_df %>%
    select(id, statusSource, text, created) %>%
    extract(statusSource, "source", "Twitter for (.*?)<") %>%
    filter(source %in% c("iPhone", "Android"))


### When does Trump tweet?
library(lubridate)
library(scales)

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


#
library(tidytext)

reg <- "([^A-Za-z\\d#@']|'(?![A-Za-z\\d#@]))"
tweet_words <- tweets %>%
    filter(!str_detect(text, '^"')) %>%
    mutate(text = str_replace_all(text, "https://t.co/[A-Za-z\\d]+|&amp;", "")) %>%
    unnest_tokens(word, text, token = "regex", pattern = reg) %>%
    filter(!word %in% stop_words$word,
           str_detect(word, "[a-z]"))

tweet_words
