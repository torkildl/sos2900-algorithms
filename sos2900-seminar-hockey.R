###
### Seminar 2 regression and prediction using hockey data
### More R features, and different applications
###
source("http://bit.ly/SOS2900-startup-R")
###
### Load some necessary packages
library(tidyverse)
library(gapminder)
library(here)
library(MLmetrics)
library(data.table)

# Read in the data set -- original.
hockey_train <- fread("./materials/hockey_train.csv", header=T)
hockey_test <- bind_cols(fread("./materials/hockey_test.csv", header=T), fread("./materials/hockey_test_salaries.csv", header=T))
hockey <- bind_rows(hockey_train, hockey_test)
tsplit <- c(rep("training", nrow(hockey_train)),rep("testing",nrow(hockey_test)))
cn <- colnames(hockey) %>%
        gsub(pattern="%",replacement="pct") %>%
        gsub(pattern=" ", replacement="_") %>%
        gsub(pattern="\\+/-", replacement="plusminus") %>%
        gsub(pattern="/", replacement="per")
colnames(hockey) <- cn

###
### Split data set into testing and training
###
dfs <- split(hockey, tsplit)
training <- dfs$training
testing <- dfs$testing



# Look at outcome variable
summary(training$Salary)
ggplot(data=training, aes(x=Salary)) + geom_histogram()
ggplot(data=training, aes(x=log(Salary))) + geom_histogram()


# Model and predict outcome using training data

... 

# Check prediction using testing data

... 


# DESCRIPTION OF THE VARIABLES
# COLUMN - DESCRIPTION

# pctFOT - Percentage of all on - ice faceoffs taken by this player.
# plusminus - Plus minus
# 1G - First goals of a game
# Aper60 - Events Against per 60 minutes, defaults to Corsi, but can be set to another stat
# A1 - First assists, primary assists
# A2 - Second assists, secondary assists
# BLKpct -Percentage of all opposing shot attempts blocked by this player
# Born - Birth date
# C.Close - A player shot attempt (Corsi) differential when the game was close
# C.Down - A player shot attempt (Corsi) differential when the team was trailing
# C.Tied - A player shot attempt (Corsi) differential when the team was tied
# C.Up - A player shot attempt (Corsi) differential when the team was in the lead
# CA - Shot attempts allowed (Corsi, SAT) while this player was on the ice
# Cap Hit - The player's cap hit
# CBar - Crossbars hit
# CF - The team's shot attempts (Corsi, SAT) while this player was on the ice
# CF.QoC - A weighted average of the Corsi percentage of a player's opponents
# CF.QoT - A weighted average of the Corsi percentage of a player's linemates
# CHIP - Cap Hit of Injured Player is games lost to injury multiplied by cap hit per game
# City - City of birth
# Cntry - Country of birth
# DAP - Disciplined aggression proxy, which is hits and takeaways divided by minor penalties
# DFA - Dangerous Fenwick against, which is on - ice unblocked shot attempts weighted by shot quality
# DFF - Dangerous Fenwick for , which is on - ice unblocked shot attempts weighted by shot quality
# DFF.QoC - Quality of Competition metric based on Dangerous Fenwick, which is unblocked shot attempts weighted for shot quality
# DftRd - Round in which the player was drafted
# DftYr - Year drafted
# Diff - Events for minus event against, defaults to Corsi, but can be set to another stat
# Diffper60 - Events for minus event against, per 60 minutes, defaults to Corsi, but can be set to another stat
# DPS - Defensive point shares, a catch - all stats that measures a player's defensive contributions in points in the standings
# DSA - Dangerous shots allowed while this player was on the ice, which is rebounds plus rush shots
# DSF - The team's dangerous shots while this player was on the ice, which is rebounds plus rush shots
# DZF - Shifts this player has ended with an defensive zone faceoff
# dzFOL - Faceoffs lost in the defensive zone
# dzFOW - Faceoffs win in the defensive zone
# dzGAPF - Team goals allowed after faceoffs taken in the defensive zone
# dzGFPF - Team goals scored after faceoffs taken in the defensive zone
# DZS - Shifts this player has started with an defensive zone faceoff
# dzSAPF - Team shot attempts allowed after faceoffs taken in the defensive zone
# dzSFPF - Team shot attempts taken after faceoffs taken in the defensive zone
# Eplusminus - A player's expected +/-, based on his team and minutes played
# ENG - Empty-net goals
# Exp dzNGPF - Expected goal differential after faceoffs taken in the defensive zone, based on the number of them
# Exp dzNSPF - Expected shot differential after faceoffs taken in the defensive zone, based on the number of them
# Exp ozNGPF - Expected goal differential after faceoffs taken in the offensive zone, based on the number of them
# Exp ozNSPF - Expected shot differential after faceoffs taken in the offensive zone, based on the number of them
# F.Close - A player unblocked shot attempt (Fenwick) differential when the game was close
# F.Down - A player unblocked shot attempt (Fenwick) differential when the team was trailing
# F.Tied - A player unblocked shot attempt (Fenwick) differential when the team was tied
# F.Up - A player unblocked shot attempt (Fenwick) differential when the team was in the lead. Not the best acronym.
# F/60 - Events For per 60 minutes, defaults to Corsi, but can be set to another stat
# FA - Unblocked shot attempts allowed (Fenwick, USAT) while this player was on the ice
# FF - The team's unblocked shot attempts (Fenwick, USAT) while this player was on the ice
# First_Name -
# Opct -Faceoff winning percentage
# FOpctvsL - Faceoff winning percentage against lefthanded opponents
# FOpctvsR - Faceoff winning percentage against righthanded opponents
# FOL - The team's faceoff losses while this player was on the ice
# FOL.Close - Faceoffs lost when the score was close
# FOL.Down - Faceoffs lost when the team was trailing
# FOL.Up - Faceoffs lost when the team was in the lead
# FovsL - Faceoffs taken against lefthanded opponents
# FovsR - Faceoffs taken against righthanded opponents
# FOW - The team's faceoff wins while this player was on the ice
# FOW.Close - Faceoffs won when the score was close
# FOW.Down - Faceoffs won when the team was trailing
# FOW.Up - Faceoffs won when the team was in the lead
# G - Goals
# G.Bkhd - Goals scored on the backhand
# G.Dflct - Goals scored with deflections
# G.Slap - Goals scored with slap shots
# G.Snap - Goals scored with snap shots
# G.Tip - Goals scored with tip shots
# G.Wrap - Goals scored with a wraparound
# G.Wrst - Goals scored with a wrist shot
# GA - Goals allowed while this player was on the ice
# Game - Game Misconduct penalties
# GF - The team's goals while this player was on the ice
# GP - Games Played
# Grit - Defined as hits, blocked shots, penalty minutes, and majors
# GS - The player's combined game score
# GSperG - The player's average game score
# GVA - The team's giveaways while this player was on the ice
# GWG - Game - winning goals
# GWG - Game - winning goals
# HA - The team's hits taken while this player was on the ice
# Hand - Handedness
# HF - The team's hits thrown while this player was on the ice
# HopFO - Opening faceoffs taken at home
# HopFOW - Opening faceoffs won at home
# Ht - Height
# iBLK - Shots blocked by this individual
# iCF - Shot attempts (Corsi, SAT) taken by this individual
# iDS - Dangerous shots taken by this player, the sum of rebounds and shots off the rush
# iFF - Unblocked shot attempts (Fenwick, USAT) taken by this individual
# iFOL - Faceoff losses by this individual
# iFOW - Faceoff wins by this individual
# iGVA - Giveaways by this individual
# iHA - Hits taken by this individual
# iHDf - The difference in hits thrown by this individual minus those taken
# iHF - Hits thrown by this individual
# iMiss - Individual shots taken that missed the net.
# Injuries - List of types of injuries incurred, if any
# iPEND - Penalties drawn by this individual
# iPenDf - The difference in penalties drawn minus those taken
# iPENT - Penalties taken by this individual
# IPPpct -Individual points percentage, which is on - ice goals for which this player had the goal or an assist
# iRB - Rebound shots taken by this individual
# iRS - Shots off the rush taken by this individual
# iSCF - All scoring chances taken by this individual
# iSF - Shots on goal taken by this individual
# iTKA - Takeaways by this individual
# ixG - Expected goals (weighted shots) for this individual, which is shot attempts weighted by shot location
# Last Name - obvious
# Maj - Major penalties taken
# Match - Match penalties
# MGL - Games lost due to injury
# Min - Minor penalties taken
# Misc - Misconduct penalties
# Nat - Nationality
# NGPF - Net Goals Post Faceoff. A differential of all goals within 10 seconds of a faceoff, relative to expectations set by the zone in which they took place
# NHLid - NHL player id useful when looking at the raw data in game files
# NMC - What kind of no - movement clause this player's contract has, if any
# NPD - Net Penalty Differential is the player's penalty differential relative to a player of the same position with the same ice time per manpower situation
# NSPF - Net Shots Post Faceoff. A differential of all shot attempts within 10 seconds of a faceoff, relative to expectations set by the zone in which they took place
# NZF - Shifts this player has ended with a neutral zone faceoff
# nzFOL - Faceoffs lost in the neutral zone
# nzFOW - Faceoffs won in the neutral zone
# nzGAPF - Team goals allowed after faceoffs taken in the neutral zone
# nzGFPF - Team goals scored after faceoffs taken in the neutral zone
# NZS - Shifts this player has started with a neutral zone faceoff
# nzSAPF - Team shot attempts allowed after faceoffs taken in the neutral zone
# nzSFPF - Team shot attempts taken after faceoffs taken in the neutral zone
# OCA - Shot attempts allowed (Corsi, SAT) while this player was not on the ice
# OCF - The team's shot attempts (Corsi, SAT) while this player was not on the ice
# ODZS - Defensive zone faceoffs that occurred without this player on the ice
# OFA - Unblocked shot attempts allowed (Fenwick, USAT) while this player was not on the ice
# OFF - The team's unblocked shot attempts (Fenwick, USAT) while this player was not on the ice
# OGA - Goals allowed while this player was not on the ice
# OGF - The team's goals while this player was not on the ice
# ONZS - Neutral zone faceoffs that occurred without this player on the ice
# OOZS - Offensive zone faceoffs that occurred without this player on the ice
# OpFO - Opening faceoffs taken
# OpFOW - Opening faceoffs won
# OppCA60 - A weighted average of the shot attempts (Corsi, SAT) the team allowed per 60 minutes of a player's opponents
# OppCF60 - A weighted average of the shot attempts (Corsi, SAT) the team generated per 60 minutes of a player's opponents
# OppFA60 - A weighted average of the unblocked shot attempts (Fenwick, USAT) the team allowed per 60 minutes of a player's opponents
# OppFF60 - A weighted average of the unblocked shot attempts (Fenwick, USAT) the team generated per 60 minutes of a player's opponents
# OppGA60 - A weighted average of the goals the team allowed per 60 minutes of a player's opponents
# OppGF60 - A weighted average of the goals the team scored per 60 minutes of a player's opponents
# OppSA60 - A weighted average of the shots on goal the team allowed per 60 minutes of a player's opponents
# OppSF60 - A weighted average of the shots on goal the team generated per 60 minutes of a player's opponents
# OPS - Offensive point shares, a catch-all stats that measures a player's offensive contributions in points in the standings
# OSA - Shots on goal allowed while this player was not on the ice
# OSCA - Scoring chances allowed while this player was not on the ice
# OSCF - The team's scoring chances while this player was not on the ice
# OSF - The team's shots on goal while this player was not on the ice
# OTF - Shifts this player started with an on - the - fly change
# OTG - Overtime goals
# OTOI - The amount of time this player was not on the ice.
# Over - Shots that went over the net
# Ovrl - Where the player was drafted overall
# OxGA - Expected goals allowed (weighted shots) while this player was not on the ice, which is shot attempts weighted by location
# OxGF - The team's expected goals (weighted shots) while this player was not on the ice, which is shot attempts weighted by location
# OZF - Shifts this player has ended with an offensive zone faceoff
# ozFO - Faceoffs taken in the offensive zone
# ozFOL - Faceoffs lost in the offensive zone
# ozFOW - Faceoffs won in the offensive zone
# ozGAPF - Team goals allowed after faceoffs taken in the offensive zone
# ozGFPF - Team goals scored after faceoffs taken in the offensive zone
# OZS - Shifts this player has started with an offensive zone faceoff
# ozSAPF - Team shot attempts allowed after faceoffs taken in the offensive zone
# ozSFPF - Team shot attempts taken after faceoffs taken in the offensive zone
# Pace - The average game pace, as estimated by all shot attempts per 60 minutes
# Pass - An estimate of the player's setup passes (passes that result in a shot attempt)
# Pctpct -Percentage of all events produced by this team, defaults to Corsi, but can be set to another stat
# PDO - The team's shooting and save percentages added together, times a thousand
# PEND - The team's penalties drawn while this player was on the ice
# PENT - The team's penalties taken while this player was on the ice
# PIM - Penalties in minutes
# Position - Positions played. NHL source listed first, followed by those listed by any other source.
# Post - Times hit the post
# Pr/St - Province or state of birth
# PS - Point shares, a catch-all stats that measures a player's contributions in points in the standings
# PSA - Penalty shot attempts
# PSG - Penalty shot goals
# PTS - Points. Goals plus all assists
# PTSper60 - Points per 60 minutes
# QRelCA60 - Shot attempts allowed per 60 minutes relative to how others did against the same competition
# QRelCF60 - Shot attempts per 60 minutes relative to how others did against the same competition
# QRelDFA60 - Weighted unblocked shot attempts (Dangeorus Fenwick) allowed per 60 minutes relative to how others did against the same competition
# QRelDFF60 - Weighted unblocked shot attempts (Dangeorus Fenwick) per 60 minutes relative to how others did against the same competition
# RBA - Rebounds allowed while this player was on the ice. Two very different sources.
# RBF - The team's rebounds while this player was on the ice. Two very different sources.
# RelA/60 - The player's Aper60 relative to the team when he's not on the ice
# RelC/60 - Corsi differential per 60 minutes relative to his team
# RelCpct - Corsi percentage relative to his team
# RelDf/60 - The player's Diffper60 relative to the team when he's not on the ice
# RelF/60 - The player's Fper60 relative to the team when he's not on the ice
# RelF/60 - Fenwick differential per 60 minutes relative to his team
# RelFpct - Fenwick percentage relative to his team
# RelPctpct - The players Pctpct relative to the team when he's not on the ice
# RelZSpct -The player's zone start percentage when he's on the ice relative to when he's not.
# RopFO - Opening faceoffs taken at home
# RopFOW - Opening faceoffs won at home
# RSA - Shots off the rush allowed while this player was on the ice
# RSF - The team's shots off the rush while this player was on the ice
# S.Bkhd - Backhand shots
# S.Dflct - Deflections
# S.Slap - Slap shots
# S.Snap - Snap shots
# S.Tip - Tipped shots
# S.Wrap - Wraparound shots
# S.Wrst - Wrist shots
# SA - Shots on goal allowed while this player was on the ice
# Salary - The player's salary
# SCA - Scoring chances allowed while this player was on the ice
# SCF - The team's scoring chances while this player was on the ice
# sDist - The average shot distance of shots taken by this player
# SF - The team's shots on goal while this player was on the ice
# SHpct - The team's (not individual's) shooting percentage when the player was on the ice
# SOG - Shootout Goals
# SOGDG - Game-deciding shootout goals
# SOS - Shootout Shots
# Status - This player's free agency status
# SVpct -The team's save percentage when the player was on the ice
# Team -
# TKA - The team's takeaways while this player was on the ice
# TMCA60 - A weighted average of the shot attempts (Corsi, SAT) the team allowed per 60 minutes of a player's linemates
# TMCF60 - A weighted average of the shot attempts (Corsi, SAT) the team generated per 60 minutes of a player's linemates
# TMFA60 - A weighted average of the unblocked shot attempts (Fenwick, USAT) the team allowed per 60 minutes of a player's linemates
# TMFF60 - A weighted average of the unblocked shot attempts (Fenwick, USAT) the team generated per 60 minutes of a player's linemates
# TMGA60 - A weighted average of the goals the team allowed per 60 minutes of a player's linemates
# TMGF60 - A weighted average of the goals the team scored per 60 minutes of a player's linemates
# TMSA60 - A weighted average of the shots on goal the team allowed per 60 minutes of a player's linemates
# TMSF60 - A weighted average of the shots on goal the team generated per 60 minutes of a player's linemates
# TmxGF - A weighted average of a player's linemates of the expected goals the team scored
# TmxGA - A weighted average of a player's linemates of the expected goals the team allowed
# TMGA - A weighted average of a player's linemates of the goals the team scored
# TMGF - A weighted average of a player's linemates of the goals the team allowed
# TOI - Time on ice, in minutes, or in seconds (NHL)
# TOI.QoC - A weighted average of the TOIpct of a player's opponents.
# TOI.QoT - A weighted average of the TOIpct of a player's linemates.
# TOIperGP - Time on ice divided by games played
# TOIpct -Percentage of all available ice time assigned to this player.
# Wide - Shots that went wide of the net
# Wt - Weight
# xGA - Expected goals allowed (weighted shots) while this player was on the ice, which is shot attempts weighted by location
# xGF - The team's expected goals (weighted shots) while this player was on the ice, which is shot attempts weighted by location
# xGF.QoC - A weighted average of the expected goal percentage of a player's opponents
# xGF.QoT - A weighted average of the expected goal percentage of a player's linemates
# ZSpct - Zone start percentage, the percentage of shifts started in the offensive zone, not counting neutral zone or on-the-fly changes
