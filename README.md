# Analysis of Crime Rates Across Toronto

## Overview of Paper

This paper analyzes the distribution of crime rates across Toronto. Specifically, it is looking at the relationship between the number of crimes, population, and income level across the 158 neighbourhoods of Toronto.

## File Structure

The repo is structured as the following:

-   `input/data` contains the raw data downloaded from Open Data Toronto.
-   `input/sketches` contains the sketches used to plan and simulate the data before collection.
-   `outputs/data` contains the cleaned dataset that was constructed and used for analysis.
-   `outputs/paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper.
-   `scripts` contains the R scripts used to simulate, download and clean data, as well as helper functions used in these routines.

## Usage of LLMs
No LLMs were used in the course of producing this paper.

## How to Run

1.  Run `scripts/01-download_data.R` to download raw data
2.  Run `scripts/02-data_cleaning.R` to generate cleaned data
3.  Run `scripts/03-test_data.R` to validate the cleaned data
3.  Run `outputs/paper/toronto-crime-rates.qmd` to generate the PDF of the paper