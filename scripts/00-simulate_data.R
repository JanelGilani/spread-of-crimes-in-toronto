#### Preamble ####
# Purpose: Simulates the neighbourhood and crime data across Toronto
# Author: Janel Gilani
# Date: 23 January 2024
# Contact: janel.gilani@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(tidyverse)

#### Simulate data ####


# Fictional neighbourhood, population, income, and crime data

sim_hood_id = c(1:158)
sim_population = c(1:100000)
sim_income = c(1:1000000)
sim_crimes = c(1:2000)


## Creating simulated data

set.seed(302) # for reproducibility
num_observations = 100

simulated_data = 
  tibble(
    hood_id = sample(x = sim_hood_id, 
                      size = num_observations,
                      replace = FALSE),
    number_of_crimes = sample(x = sim_crimes, 
                      size = num_observations,
                      replace = TRUE),
    population = sample(x = sim_population,
                      size = num_observations,
                      replace = TRUE),
    income = sample(x = sim_income,
                      size = num_observations,
                      replace = TRUE)
  )



# Data Validation:

# Check if the number of unique values in the 'neighbourhood' column is 158
length(unique(simulated_data$hood_id)) == num_observations

# Check if all unique values in the 'hood_id' column are within the range of 1 to 174
all(unique(simulated_data$hood_id) %in% 1:174)

# Check if the number of unique values in the 'hood_id' column is equal to the number of rows in the data frame
length(unique(simulated_data$hood_id)) == num_observations

# Check if the number of unique values in the 'number_of_crimes' column is equal to the number of rows in the data frame
length((simulated_data$number_of_crimes)) == num_observations

# Check the range of 'hood_id' values
min(simulated_data$hood_id, na.rm = TRUE) > 0 # Hood ID greater than 0
max(simulated_data$hood_id, na.rm = TRUE) < 175 # Hood ID less than 175

# Check reasonability for 'population' values
min(simulated_data$population, na.rm = TRUE) > 0 # Population greater than 0
max(simulated_data$population, na.rm = TRUE) < 1000000 # Population less than 1 million

# Check reasonability for 'income' values
min(simulated_data$income, na.rm = TRUE) > 0 # Income greater than 0
max(simulated_data$income, na.rm = TRUE) < 1000000 # Income less than 1 million

# Check reasonability for 'number_of_crimes' values
min(simulated_data$number_of_crimes, na.rm = TRUE) > 0 # Number of crimes greater than 0
max(simulated_data$number_of_crimes, na.rm = TRUE) < 2000 # Number of crimes less than 2000

# Check if there are any missing values in the data frame
any(is.na(simulated_data)) == FALSE



## Create graphs of simulated data

# Bar graph of number of crimes per neighbourhood
simulated_data %>% 
  ggplot(aes(x = hood_id, y = number_of_crimes)) +
  geom_bar(stat = "identity") +
  labs(title = "Number of crimes per neighbourhood",
       x = "Neighbourhood ID",
       y = "Number of crimes")

# Bar graph of population per neighbourhood
simulated_data %>% 
  ggplot(aes(x = hood_id, y = population)) +
  geom_bar(stat = "identity") +
  labs(title = "Population per neighbourhood",
       x = "Neighbourhood ID",
       y = "Population")

# Bar graph of income per neighbourhood
simulated_data %>% 
  ggplot(aes(x = hood_id, y = income)) +
  geom_bar(stat = "identity") +
  labs(title = "Income per neighbourhood",
       x = "Neighbourhood ID",
       y = "Income")




