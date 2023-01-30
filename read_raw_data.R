#*******************************************************************************
# read_raw_data.R
# Your Name Here
# This script will read in the raw data downloaded from IPUMS and Social 
# Explorer and perform some initial cleaning and subsetting. 
#*******************************************************************************

library(readr)

# IPUMS Data -------------------------------------------------------------------

# read in the IPUMS fixed-width data from gzip file. The resulting data should
# be called "acs" for American Community Survey

# drop cases that are missing on met2013 or SEI (i.e. have a zero value)

# Tract Data -------------------------------------------------------------------

# read in the social explorer tract data from CSV. Name your object "tracts"

# after loading in the tract data, please run these lines of code. It will add
# the metro area identifier (met2013) based on the State and County ID of the 
# tract. 
county_cbsa_crosswalk <- read_csv("input/counties2cbsa.csv")
tracts <- tracts %>%
  left_join(county_cbsa_crosswalk)

# subset the data to remove any tracts with a missing met2013 id and drop 
# variables we don't need

# provide better variable names
