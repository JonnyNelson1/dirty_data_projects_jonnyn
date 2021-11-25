# Loading in the required packages

library(tidyverse)

library(here)

library(readxl)

library(janitor)

library(assertr)


# Loading in the required excel sheets into the environment.


ship_data_by_record_id <- read_excel(here("raw_data/seabirds.xls"),
                                     sheet = "Ship data by record ID")

bird_data_by_record_id <- read_excel(here("raw_data/seabirds.xls"),
                                     sheet = "Bird data by record ID")


# Cleaning script for the ship_data


cleaning_script_ship <- function(ship_data_by_record_id){
  
  ship_data_by_record_id %>%
    clean_names() %>%
    rename("latitude" = "lat", "longitude" = "long") %>%
    select(record, record_id, date, time, latitude, longitude) 
}

clean_ship_data <- cleaning_script_ship(ship_data_by_record_id)


# Cleaning script for the bird_data


cleaning_script_birds <- function(bird_data_by_record_id){
  bird_data_by_record_id %>%
    clean_names() %>%
    select(record,
           record_id,
           species_common_name_taxon_age_sex_plumage_phase,
           count) %>%
    mutate(species_common_name = 
             str_replace_all(string = species_common_name_taxon_age_sex_plumage_phase,
                             pattern = "sensu.*$|[A-Z]{2,}.*$",
                             replacement = "")) %>%
    mutate(across(where(is.character), str_trim)) %>%
    mutate(count = ifelse(is.na(count), 1, count)) %>%
    select(-species_common_name_taxon_age_sex_plumage_phase) 
}

clean_bird_data <- cleaning_script_birds(bird_data_by_record_id)

# Here, the bird_data needed any age, sex or plumage phase found along side the
# species common name to be removed by regex. The white space was then trimmed from 
# observations and "count" of NA were set to equal 1 - as being recorded means 
# that at least one of those species was observed. 


# Joining the two data-sets together using a left join


seabird_data_clean <- left_join(clean_bird_data, clean_ship_data, "record_id")


# Clean data was then written into the clean_data folder

write_csv(x = seabird_data_clean, here("clean_data/seabird_data_clean.csv"))

