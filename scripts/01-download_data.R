#### Preamble ####
# Purpose: Downloads and saves the neighbourhood and crime raw data from Open Data Toronto
# Author: Janel Gilani
# Date: 23 January 2024
# Contact: janel.gilani@mail.utoronto.ca
# License: MIT
# Pre-requisites: None


#### Workspace setup ####
#install.packages("opendatatoronto")
#install.packages("tidyverse")
#install.packages("dplyr")

library(opendatatoronto)
library(tidyverse)
library(dplyr)

#### Download data ####

# Crime Data: https://open.toronto.ca/dataset/neighbourhood-crime-rates/

# get package
crime_package <- show_package("neighbourhood-crime-rates")
crime_package

# get all resources for this package
crime_resources <- list_package_resources("neighbourhood-crime-rates")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
crime_datastore_resources <- filter(crime_resources, tolower(format) %in% c('csv'))

# load the first datastore resource as a sample
crime_data <- filter(crime_datastore_resources, row_number()==1) %>% get_resource()
crime_data

#### Save data ####
write_csv(crime_data, "inputs/data/crimes_raw_data.csv") 


# Neighbourhood Data: https://open.toronto.ca/dataset/neighbourhood-profiles/

neighbourhood_data = 
  list_package_resources("6e19a90f-971c-46b3-852c-0c48c436d1fc") |> # get resources for the package_id
  filter (id == "19d4a806-7385-4889-acf2-256f1e079060") |> # filter by resource_id
  get_resource() #download data

#### Save data ####
write_csv(neighbourhood_data[["hd2021_census_profile"]], "inputs/data/neighbourhood_raw_data.csv") 
