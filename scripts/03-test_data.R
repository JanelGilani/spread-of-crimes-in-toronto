#### Preamble ####
# Purpose: Tests and validates the cleaned data for reasonability and correctness
# Author: Janel Gilani
# Date: 23 January 2024
# Contact: janel.gilani@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download_data.R, 02-data_cleaning.R


#### Workspace setup ####
library(tidyverse)

#### Test data ####

final_neighbourhood_data <- read_csv(file = "outputs/data/hood_crime_analysis_data.csv", show_col_types = FALSE)



# All the tests below should return TRUE:


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
length((final_neighbourhood_data$number_of_crimes)) == nrow(cleaned_crimes_data)

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
