### ENKEL DEMONSTRASJON AV TWITTERS API, OG HVA MAN KAN LÆRE AV DEN

library(twitteR)
twitter_consumer_key <- "HzQFb7nh8ZCjxgzoCCiuKrPmP"
twitter_consumer_secret <- "OlPLo5sHGJkVSS4UToJkjEBiLZOp3YUaXpTu9Y30e9NswBtNLO"
twitter_access_token <- 	"219098987-TFsTrAN60BexPKKnfHZDQMNvzSm32bZ2WHRH59H0"
twitter_access_token_secret <- "jG4ow1fTvcBH4G5pLEmGKmh4p5a0BbNnWBxUcDzKM4MTW"


setup_twitter_oauth(twitter_consumer_key,
                    twitter_consumer_secret,
                    twitter_access_token,
                    twitter_access_token_secret)

# Vi kan lett søke blant tweets
sometweets <- purrr::map_df(searchTwitter("blurb", n = 100, resultType = "recent"), as.data.frame)


# Her er noen brukernavn. La oss se nærmere på dem.
someusers <- lookupUsers(list("torkildl","sylvilisthaug","konservativ")) -> tusers

# Ser på overflaten uten som tre navn
someusers

# Men bak navnene skjuler det seg data!
str(someusers,1) # Dette er en liste av twitter-bruker-objekter

# Hvilke data om meg?
str(someusers$torkildl)

# La oss se nærmere på denne kontoen...
torkildl <- someusers$torkildl

# Alle konti har et id-nummer.
torkildl$id


# Hvor raskt kan vi hente ut informasjon om hvem-som-følger-hvem?



str(twitteR::getUser(torkildl$getFollowerIDs()[500]))

map_df(torkildl$getFollowerIDs(), as.data.frame) 




