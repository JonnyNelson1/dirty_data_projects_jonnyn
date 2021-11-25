# Loading in the packages


library(readxl)

library(janitor)

library(tidyverse)

library(here)



# Loading in the data sets



candy_data_2015 <- read_excel(here("raw_data/candy_ranking_data/boing-boing-candy-2015.xlsx"))

candy_data_2016 <- read_excel(here("raw_data/candy_ranking_data/boing-boing-candy-2016.xlsx"))

candy_data_2017 <- read_excel(here("raw_data/candy_ranking_data/boing-boing-candy-2017.xlsx"))



# Cleaning Script for Candy 2015 Data



cleaning_script_2015 <- function(candy_data_2015){
  
  candy_data_2015 %>%
    
    rename("entry" = "Timestamp",
           "age" = "How old are you?",
           "going_out" = "Are you going actually going trick or treating yourself?",
           "black_and_orange_wrappers" = "[Anonymous brown globs that come in black and orange wrappers]",
           "vials_of_hfcs" = "[Vials of pure high fructose corn syrup, for main-lining into your vein]",
           "cheap_candy" = "[Candy that is clearly just the stuff given out for free at restaurants]",
           "toblerone" = "[Tolberone something or other]",
           "chick_o_stick" = "[Chick-o-Sticks (we don’t know what that is)]",
           "circus_peanuts" = "[Those odd marshmallow circus peanut things]") %>%
    
    select(-"[Cash, or other forms of legal tender]", -"[Dental paraphenalia]", -"[Generic Brand Acetaminophen]", -"[Broken glow stick]", -"[Healthy Fruit]", -"[Hugs (actual physical hugs)]", -"[Kale smoothie]", -"[Lapel Pins]", -"[Pencils]", -"[Peterson Brand Sidewalk Chalk]", -"[Vicodin]", -"[White Bread]", -"[Whole Wheat anything]", -c(97:124)) %>%
    
    clean_names() %>%
    mutate(entry = str_c(2015, "_", row_number(), sep = "")) %>%
    pivot_longer(cols = 4:83,
                 names_to = "candy_name",
                 values_to = "rating") %>%
    mutate(country = NA, province = NA, gender = NA)
  
}

clean_2015 <- cleaning_script_2015(candy_data_2015)


# Cleaning Script for Candy 2016 Data


cleaning_script_2016 <- function(candy_data_2016){
  
  candy_data_2016 %>%
    
    rename("entry" = "Timestamp",
           "age" = "How old are you?",
           "going_out" = "Are you going actually going trick or treating yourself?",
           "gender" = "Your gender:",
           "country" = "Which country do you live in?",
           "province" = "Which state, province, county do you live in?",
           "bonkers" = "[Bonkers (the candy)]",
           "sour_patch_kids" = "[Sourpatch Kids (i.e. abominations of nature)]",
           "sweetums" = "[Sweetums (a friend to diabetes)]",
           "black_and_orange_wrappers" = "[Anonymous brown globs that come in black and orange wrappers]",
           "vials_of_hfcs" = "[Vials of pure high fructose corn syrup, for main-lining into your vein]",
           "cheap_candy" = "[Candy that is clearly just the stuff given out for free at restaurants]",
           "toblerone" = "[Tolberone something or other]",
           "chick_o_stick" = "[Chick-o-Sticks (we don’t know what that is)]",
           "circus_peanuts" = "[Those odd marshmallow circus peanut things]") %>%
    
    select(-"[Bonkers (the board game)]", -"[Chardonnay]", -"[Creepy Religious comics/Chick Tracts]",-"[Person of Interest Season 3 DVD Box Set (not including Disc 4 with hilarious outtakes)]", -"[Cash, or other forms of legal tender]", -"[Dental paraphenalia]", -"[Generic Brand Acetaminophen]", -"[Broken glow stick]", -"[Healthy Fruit]", -"[Hugs (actual physical hugs)]", -"[Kale smoothie]", -"[Pencils]", -"[Vicodin]", -"[White Bread]", -"[Whole Wheat anything]", -c(107:123)) %>%
    
    clean_names() %>%
    mutate(entry = str_c(entry, "_", row_number(), sep = "")) %>%
    pivot_longer(cols = 7:91,
                 names_to = "candy_name",
                 values_to = "rating") 
  
}

clean_2016 <- cleaning_script_2016(candy_data_2016)


# Cleaning Script for Candy 2017


cleaning_script_2017 <- function(candy_data_2017){
  
  candy_data_2017 %>%
    
    clean_names() %>%
    rename("entry" = "internal_id",
           "age" = "q3_age",
           "going_out" = "q1_going_out",
           "gender" = "q2_gender",
           "country" = "q4_country",
           "province" = "q5_state_province_county_etc",
           "bonkers" = "q6_bonkers_the_candy",
           "sour_patch_kids" = "q6_sourpatch_kids_i_e_abominations_of_nature",
           "sweetums" = "q6_sweetums_a_friend_to_diabetes",
           "black_and_orange_wrappers" = "q6_anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes",
           "vials_of_hfcs" = "q6_vials_of_pure_high_fructose_corn_syrup_for_main_lining_into_your_vein",
           "toblerone" = "q6_tolberone_something_or_other",
           "chick_o_stick" = "q6_chick_o_sticks_we_don_t_know_what_that_is") %>%
    
    select(-"q6_bonkers_the_board_game", -"q6_chardonnay", -"q6_creepy_religious_comics_chick_tracts", -"q6_cash_or_other_forms_of_legal_tender", -"q6_dental_paraphenalia", -"q6_generic_brand_acetaminophen", -"q6_broken_glow_stick", -"q6_healthy_fruit", -"q6_hugs_actual_physical_hugs", -"q6_kale_smoothie", -"q6_pencils", -"q6_vicodin", -"q6_white_bread", -"q6_whole_wheat_anything", -c(110:120)) %>%
    
    mutate(entry = str_c(2017, "_", row_number(), sep = "")) %>%
    pivot_longer(cols = 7:95,
                 names_to = "candy_name",
                 values_to = "rating") %>%
    mutate(candy_name = str_replace_all(string = candy_name,
                                        pattern = "q6_",
                                        replacement = ""))
  
}

clean_2017 <- cleaning_script_2017(candy_data_2017)


# Welding all 3 data sets together


clean_2015_to_2017 <- bind_rows(clean_2015, clean_2016, clean_2017)


# Coercing age to be numeric and filtering values to return ages between 2 - 100


clean_2015_to_2017$age <- as.numeric(clean_2015_to_2017$age)

clean_2015_to_2017 <- clean_2015_to_2017 %>%
  mutate(age = if_else(age >= 2 & age <= 100, age, as.numeric(NA)))

clean_2015_to_2017


# Regex Patterns for United States, United Kingdom and 


usa_names <- str_c("usa", "state", "aaayyyyyy", "stetes", "us", "america", "murica", "\\d{3}", "trumpistan", "united sates", "merica", "new york", "murrika", "alaska", "new jersey", "ahemamerca", "california", "pittsburgh", "^u s (.*)", "^united st(.*)", "fear and loathing", sep = "|")

uk_names <- str_c("uk", "england", "endland", "united kingdom", "united kindom", "gods country", "scotland", sep = "|")

canada_names <- str_c("canada", "can[a]*[^e]", "can", "the republic of cascadia",  sep = "|")


# Cleaning the countries based on the regex patterns


candy_clean <- clean_2015_to_2017 %>%
  mutate(country = tolower(country)) %>%
  mutate(country = str_replace_all(string = country,
                                   pattern = "\\.",
                                   replacement = "")) %>%
  mutate(country = str_replace_all(string = country,
                                   pattern = "\\'",
                                   replacement = "")) %>%
  mutate(country = if_else(str_detect(country, usa_names), "united states", country)) %>%
  mutate(country = if_else(str_detect(country, uk_names), "united kingdom", country)) %>%
  mutate(country = if_else(str_detect(country, canada_names), "canada", country)) 


# Unique countries is good for seeing what is not captured in the regex patterns. Might be helpful if I could know if some patterns are capturing the same country (especially between US and UK)


# unique(candy_clean$country)


# Cascadia runs from Vancouver to Southern California. Need to find if these observations are in Canada or US


# candy_clean %>%
#   select(country, province) %>%
#   filter(country == "the republic of cascadia")


# Write the candy_clean data into the clean data folder


write_csv(x = candy_clean, here("clean_data/candy_clean.csv"))

