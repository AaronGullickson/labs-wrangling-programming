#*******************************************************************************
# organize_data.R
# Your Name Here
# This script will be used to construct an analytical dataset of metro areas 
# from the raw data sources. The final metro area dataset will be saved to the 
# output directory as "met_area.csv". 
#*******************************************************************************

library(tidyverse)


# IPUMS Data -------------------------------------------------------------------

# read in the IPUMS fixed-width data from gzip file. The resulting data should
# be called "acs" for American Community Survey. Because of leading zeroes in 
# the data, read_fwf will want to interpret some field as character strings when
# they should all be integers. To force this, be sure to add the following to
# your read_fwf:
#    col_types = cols(.default = "i")


# drop cases that are missing on met2013 or SEI (i.e. have a zero value)


# create combined race variable from the race and hispanic variables


# check yourself before you wreck yourself

# Tract Data -------------------------------------------------------------------

# read in the social explorer tract data from CSV. Name your object "tracts"
# note that because of leading zeroes in Geo_STATE and Geo_COUNTY, the readr
# function will try to read these values in as characters but you want them
# as integers. To force this, add the following as an argument to your
# read_csv:
#   col_types = cols(Geo_STATE = "i", Geo_COUNTY = "i")


# after loading in the tract data, please run the lines of code below. It will
# add the metro area identifier (met2013) based on the State and County ID of
# the tract.
tracts <- read_csv("input/nber/cbsa2fipsxw.csv",
                 col_types = cols(fipsstatecode = "i", fipscountycode = "i")) |>
  filter(metropolitanmicropolitanstatis=="Metropolitan Statistical Area") |>
  select(cbsacode, cbsatitle, fipsstatecode, fipscountycode) |>
  rename(met2013=cbsacode, met_name=cbsatitle, Geo_STATE=fipsstatecode,
         Geo_COUNTY=fipscountycode) |>
  right_join(tracts)

# 1. subset the data to remove any tracts with a missing met2013 id.
# 2. drop variables we don't need.
# 3. provide better variable names for remaining variables


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
