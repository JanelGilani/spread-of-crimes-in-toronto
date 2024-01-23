#### Preamble ####
# Purpose: Cleans and merges the neighbourhood and crime raw data
# Author: Janel Gilani
# Date: 23 January 2024
# Contact: janel.gilani@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download_data.R

#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Clean data ####
raw_crimes_data <- read_csv(file = "inputs/data/crimes_raw_data.csv", show_col_types = FALSE)
raw_neighbourhood_data <- read_csv(file = "inputs/data/neighbourhood_raw_data.csv", show_col_types = FALSE)

# clean crime data

cleaned_crimes_data = clean_names(raw_crimes_data)

cleaned_crimes_data = cleaned_crimes_data |>
  select(
    area_name,
    hood_id,
    assault_2020,
    autotheft_2020,
    biketheft_2020,
    homicide_2020,
    robbery_2020,
    shooting_2020,
    theftfrommv_2020,
    theftover_2020
  )

cleaned_crimes_data = cleaned_crimes_data |>
  rename(
    neighbourhood = area_name,
    hood_id = hood_id,
    assault = assault_2020,
    autotheft = autotheft_2020,
    biketheft = biketheft_2020,
    homicide = homicide_2020,
    robbery = robbery_2020,
    shooting = shooting_2020,
    theftfrommv = theftfrommv_2020,
    theftover = theftover_2020
  )

cleaned_crimes_data <- cleaned_crimes_data |>
  mutate_all(~replace_na(., 0))

cleaned_crimes_data <- cleaned_crimes_data |>
  mutate(
    total = assault + autotheft + biketheft + homicide + robbery + shooting + theftfrommv + theftover
  ) |>
  select(
    neighbourhood,
    hood_id,
    assault,
    autotheft,
    biketheft,
    homicide,
    robbery,
    shooting,
    theftfrommv,
    theftover,
    total
  )


cleaned_crimes_data = cleaned_crimes_data |>
  select(
    neighbourhood,
    hood_id,
    total
  )

cleaned_crimes_data = cleaned_crimes_data |>
  rename(
    number_of_crimes = total
  )


print(cleaned_crimes_data, n = 25)
rm(raw_crimes_data)


# clean neighbourhood data

neighbourhood_population_vector = 
  transpose((raw_neighbourhood_data[3,]))[[1]] |>
  as.numeric()

neighbourhood_population_vector = neighbourhood_population_vector[2:length(neighbourhood_population_vector)]

neighbourhood_income_vector = 
  transpose((raw_neighbourhood_data[245,]))[[1]] |>
  as.numeric()

neighbourhood_income_vector = neighbourhood_income_vector[2:length(neighbourhood_income_vector)]

neighbourhood_id_vector = 
  transpose((raw_neighbourhood_data[1,]))[[1]] |>
  as.numeric()

neighbourhood_id_vector = neighbourhood_id_vector[2:length(neighbourhood_id_vector)]

merged_neighbourhood_data = tibble(
  hood_id = neighbourhood_id_vector,
  population = neighbourhood_population_vector,
  income = neighbourhood_income_vector
)

final_neighbourhood_data = left_join(
  cleaned_crimes_data,
  merged_neighbourhood_data,
  by = "hood_id"
)

rm(raw_neighbourhood_data)
rm(neighbourhood_population_vector)
rm(neighbourhood_income_vector)
rm(neighbourhood_id_vector)


#### Data Testing/validation ####
# Referenced code from: https://github.com/christina-wei/INF3104-1-Covid-Clinics/blob/main/scripts/01-data_cleaning.R

# Check if the 'neighbourhood' column is of type 'character'
class(final_neighbourhood_data$neighbourhood) == "character"

# Check if the 'hood_id' column is of type 'numeric'
class(final_neighbourhood_data$hood_id) == "numeric"

# Check if the 'population' column is of type 'numeric'
class(final_neighbourhood_data$population) == "numeric"

# Check if the 'income' column is of type 'numeric'
class(final_neighbourhood_data$income) == "numeric"

# Check if the 'number_of_crimes' column is of type 'numeric'
class(final_neighbourhood_data$number_of_crimes) == "numeric"

# Check if the number of unique values in the 'neighbourhood' column is 158
length(unique(final_neighbourhood_data$neighbourhood)) == 158 

# Check if all unique values in the 'hood_id' column are within the range of 1 to 174
all(unique(final_neighbourhood_data$hood_id) %in% 1:174)

# Check if the number of unique values in the 'hood_id' column is equal to the number of rows in the data frame
length(unique(final_neighbourhood_data$hood_id)) == nrow(cleaned_crimes_data)

# Check if the number of unique values in the 'number_of_crimes' column is equal to the number of rows in the data frame
length(unique(final_neighbourhood_data$number_of_crimes)) == nrow(cleaned_crimes_data)

# Check the range of 'hood_id' values
min(final_neighbourhood_data$hood_id) == 1 # Smallest hood id is 1
max(final_neighbourhood_data$hood_id) == 174 # Largest hood id is 174

# Check reasonability for 'population' values
min(final_neighbourhood_data$population, na.rm = TRUE) > 0 # Population greater than 0
max(final_neighbourhood_data$population, na.rm = TRUE) < 1000000 # Population less than 1 million

# Check reasonability for 'income' values
min(final_neighbourhood_data$income, na.rm = TRUE) > 0 # Income greater than 0
max(final_neighbourhood_data$income, na.rm = TRUE) < 1000000 # Income less than 1 million

# Check reasonability for 'number_of_crimes' values
min(final_neighbourhood_data$number_of_crimes, na.rm = TRUE) > 0 # Number of crimes greater than 0
max(final_neighbourhood_data$number_of_crimes, na.rm = TRUE) < 2000 # Number of crimes less than 2000

# Check if there are any missing values in the data frame
any(is.na(final_neighbourhood_data)) == FALSE


#### Save data ####
write_csv(cleaned_crimes_data, "outputs/data/crimes_cleaned_data.csv")
write_csv(merged_neighbourhood_data, "outputs/data/neighbourhood_cleaned_data.csv")
write_csv(final_neighbourhood_data, "outputs/data/hood_crime_analysis_data.csv")

