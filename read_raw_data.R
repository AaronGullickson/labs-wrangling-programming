#*******************************************************************************
# read_raw_data.R
# Your Name Here
# This script will read in the raw data downloaded from IPUMS and Social 
# Explorer and perform some initial cleaning and subsetting. 
#*******************************************************************************

library(readr)

# IPUMS Data -------------------------------------------------------------------

# read in the IPUMS fixed-width data from gzip file. The resulting data should
# be called "acs" for American Community Survey. Because of leading zeroes in 
# the data, read_fwf will want to interpet some field as character strings when
# they should all be integers. To force this, be sure to add the following to
# your read_fwf:
#    col_types = cols(.default = "i")


# drop cases that are missing on met2013 or SEI (i.e. have a zero value)


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
county_cbsa_crosswalk <- read_csv("input/counties2cbsa.csv")
tracts <- tracts |>
  left_join(county_cbsa_crosswalk)

# subset the data to remove any tracts with a missing met2013 id and drop 
# variables we don't need

# provide better variable names
