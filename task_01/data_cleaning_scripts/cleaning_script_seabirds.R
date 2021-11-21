library(tidyverse)

library(here)

library(readxl)

seabirds_dirty <- read_excel("seabirds.xls")


# Notes for data cleaning function


# Need to clean variable names to fit the naming convention

# Going to have to remove the date from the time variable

# Verify that latitude and longitude are in the correct ranges

# EW variable denotes east or west, combine with a NS?

# Change variable names to be more intuitive, WDIR-> wind_direction

# Going to have to understand more of these variable names to understand the 
# data better.

# I think the variables month and season need to be united to one variable - 
# need to do more digging.

seabirds_dirty %>%
  select(RECORD,`RECORD ID`,DATE,MONTH,SEASN) %>%
  head(100)

# The season is wrong and needs to be changed. Month variable not needed,
# so something like a unite/pivot longer here.

# The LONG360, LATCELL and LONGCELL all have very similar values to 
# LAT and LONG 

names(seabirds_dirty)

glimpse(seabirds_dirty)

# None of the variables look like they need changed from one type to another.
# date and time are however in the variable type <dttm>, so may need to 
# convert time to <dbl>.