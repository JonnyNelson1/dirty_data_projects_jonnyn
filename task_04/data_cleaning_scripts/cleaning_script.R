library(tidyverse)

library(readxl)

candy_data_2015 <- read_excel("candy_ranking_data/boing-boing-candy-2015.xlsx")

candy_data_2016 <- read_excel("candy_ranking_data/boing-boing-candy-2016.xlsx")

candy_data_2017 <- read_excel("candy_ranking_data/boing-boing-candy-2017.xlsx")

# Variables for all these data sets are way off naming convention.

# 2015 Data

# data needs to shorten the names of variables and fit naming convention

# pivot longer the name of the sweets into the data.frame

# Sort out ages. Some values are "very" and "enough". need to make these NULL
# Some ages have "9.0E22" - change to 9.0


# 2016 Data

# Country and State is going to need alot of regex done to it. Going to just
# have a standard convention for each country and state.

# New observation in for types of candy "Meh" going to have to think about that.

# Pivot longer the candy type


# 2017

#