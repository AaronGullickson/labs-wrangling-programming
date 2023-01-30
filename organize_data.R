#*******************************************************************************
# organize_data.R
# Your Name Here
# This script will be used to construct an analytical dataset of metro areas 
# from the raw data sources. The final metro area dataset will be saved to the 
# output directory as "met_area.csv". 
#*******************************************************************************

library(tidyverse)

# source in the data
source("read_raw_data.R")

# Organize IPUMS data ----------------------------------------------------------

# create combined race variable from the race and hispanic variables

# check yourself before you wreck yourself

# Organize tract data ----------------------------------------------------------

# aggregate tracts into metro area level data by summing

# calculate the needed metro area summary statistics

# keep only the required summary variables and drop all others

# Merge data -------------------------------------------------------------------

# aggregate mean SEI for each metro area and calculate the difference in 
# white-black mean SEI by metro area. 

# count the number of black and white respondents by metro area.

# merge the mean sei and the count of black and white respondents by metro area
# into a single combined dataset for the aggregated IPUMS data.

# merge the aggregated IPUMS data with the aggregated tract data to get full
# metro area data. This dataset should be called "met_area"

# remove metro areas where the sample from IPUMS contained less than 50 black
# respondents or less than 50 white respondents and if there was no data from
# the tract-level data

# Calculate Dissimilarity Index ------------------------------------------------

# create a function that will calculate black/white dissimiliarity from a set of 
# tracts
calculate_dissimilarity <- function(city) {
  #your function here
}

# for-loop or sapply through each metro area and calculate dissimilarity

# put results in a tibble and merge this tibble with combined metro area
# dataset from previous section

# Save final dataset -----------------------------------------------------------

# re-organize the ordering of variables as you see fit and remove any 
# unnecessary variables

# save full metro area data as an RData file named "met_area.RData" in output
# directory
