library(tidyverse)

library(here)

library(readxl)

library(janitor)

library(assertr)

ship_data_by_record_id <- read_excel("seabirds.xls", sheet = "Ship data by record ID")


# Notes for data cleaning function for ship data

cleaning_script <- function(ship_data_by_record_id){
  ship_data_by_record_id %>%
  clean_names() %>%
  rename("latitude" = "lat")
}

clean_ship_data <- cleaning_script(ship_data_by_record_id)


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


bird_data_by_record_id <- read_excel("seabirds.xls", sheet = "Bird data by record ID")


# Notes for data cleaning function for bird data

bird_data_by_record_id %>%
  select(`RECORD`,`RECORD ID`,`Species common name (taxon [AGE / SEX / PLUMAGE PHASE])`) %>%

# Going to have to piece apart the Species common name and Species scientific 
# name into new variables as data is missing in each. 
  
# Going to split these into species_common_name, species_scientific_name then
# generally speaking find age, sex and plummage where possible
  
# Going to be a separate function for both then a pivot longer
  
# Learn Latin
  
# Many of these variables are not needed to answer the questions and as such
# will just be selected out.

# Once clean, join the tables together. 
  
           