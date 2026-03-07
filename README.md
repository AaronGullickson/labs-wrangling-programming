---
editor: visual
---

# Data Wrangling and Programming, Sociology 412/512

## Introduction

This repository will be used to complete all of the lab assignments for data wrangling and programming associated with Practical Data Analysis in Sociology using R. Unlike the prior assignments, all of these assignments will be focused on building up a single research project in which you download data and create an analytical dataset to answer an empirical research question.

### Our Project

For this project, we are going to examine the empirical evidence for two theories about how the macro-level demographic context of a city might affect the level of racial inequality within that city. Blalock (1967) argued that as the relative size of a minority group increases, it represents a greater perceived threat to the economic and political hegemony of the majority group, and will lead to greater efforts by the majority group to control and limit minority groups in order to maintain power. On the other hand, Massey and Denton (1993) have argued that racial segregation is the "linchpin" of racial inequality in the US, because it concentrates disadvantage in minority neighborhoods and segregates the social networks that provide important access to resources. Neither of these theories are mutually exclusive. We will use recent Census data to examine the empirical evidence for each argument.

As a measure of racial inequality in a city, we are going to measure the difference in [Duncan's Socioeconomic Index](https://usa.ipums.org/usa-action/variables/SEI#description_section) (SEI) between whites and blacks in that city. SEI is a composite measure that assigns a score to a person's occupation based on a combination of the average income earned in that occupation and the average education of individuals who hold that occupation. It is the most well-known measure in a family of occupational scoring techniques common to stratification research, although there is [considerable debate](https://usa.ipums.org/usa/chapter4/sei_note.shtml) on their usefulness. The difference in SEI between whites and blacks gives us a measure of occupational inequality within a city.

We are going to test out Blalock's theory by looking at the association between percent black in a city and the racial difference in SEI. To test Massey and Denton's theory, we will examine the association between a measure of residential segregation called the [Dissimilarity Index](http://www.censusscope.org/about_dissimilarity.html) and the racial difference in SEI.

### Data Sources

We will use two primary data sources to construct our analytical dataset. first, we will use [Social Explorer](https://socialexplorer.com) to download census tract data for the entire US based on American Community Survey (ACS) data from 2014-2018. The ACS is an annual 1% survey of the American population conducted by the US Census Bureau that collects a variety of demographic information. The Social Explorer data is derived from published Census reports on aggregate statistics from the ACS. Ultimately, we want data at the level of metropolitan statistical areas (i.e. cities). However, we need data at the tract level within cities in order to calculate the dissimilarity index of segregation. Therefore we will just download tract data and ultimately aggregate this up to the level of metropolitan areas.

Unfortunately, the Census bureau does not publish aggregate data that will give us the mean difference in SEI between whites and blacks in a metropolitan area. In order to get this number, we will need to download the individual-level ACS data from 2016 and calculate the difference ourselves. We will be downloading the ACS extract from the [Integrated Public Use Microdata Series](https://usa.ipums.org/usa/) (IPUMS) at the Minnesota Population Center. Unfortunately, for reasons of confidentiality, the metropolitan area of respondents is not directly reported by the census. However, IPUMS is able to derive it based on the [Public Use Microdata Area](https://www.census.gov/programs-surveys/geography/guidance/geo-areas/pumas.html) (PUMA) for about 150-200 cities in the US, which will form the basis for our analysis.

### Overall Plan

We will develop this project over multiple exercises. Here is an overview of the individual steps that we will complete for the project:

1.  Create the necessary data extracts from Social Explorer and IPUMS and read this data into R.
2.  Clean and recode each dataset where needed.
3.  For both datasets, aggregate the data up to the metro-level area.
4.  Merge the dataset from Social Explorer with the dataset from IPUMS.
5.  Calculate the dissimilarity index for each metro area and merge this into the data from (4). We now have a final analytical dataset.
6.  Conduct the analysis on the analytical dataset, and write up a report of your analysis in Quarto with tables and figures.

Further instructions for each of these assignments are provided below.

### Using Quarto

All assignments will be completed in quarto documents. I am expecting that in addition to writing R code, students will write accompanying narrative text of what they are doing or what they found out within each section. This narrative text does not need to be extensive but it should be present.

### Loading Libraries

For all users, in order to ensure all required packages are installed on your system, just source in the `check_packages.R` script included in this repository.

### Completing the Assignments

When you have completed each assignment, please open an issue in your GitHub repository to let me know it is ready for review. Be sure to summon me with @AaronGullickson in the text of the issue.

## Reading Data Assignment

For this assignment, you will need to create a data extract from the Social Explorer dataset and the IPUMS website and then write R code that will read these data extracts into R.

### Download Social Explorer Data

To access Social Explorer, you will need to be either on the campus network, operating through the [campus VPN](https://service.uoregon.edu/TDClient/2030/Portal/KB/ArticleDet?ID=31471), or you will need to go to the [UO libraries page](https://library.uoregon.edu/), search for "social explorer", and then use the online access to load the site. From the [Social Explorer main page](https://www.socialexplorer.com), follow these steps:

1.  Go to the "Data Library" section from the menu on the left.
2.  Choose "American Community Survey (5-year estimates)" from the choices available.
3.  Click the "Begin Report" button.
4.  Under "Select geographies" choose "140. Census Tracts" and then "All Census Tracts." Hit "Next" in the upper right.
5.  Under "Select tables" choose the following and then "Create Report":
    -   A04001. Hispanic or Latino by race
    -   A12002. Highest Educational Attainment for Population 25 years or older.
    -   A17005. Unemployment Rate for Civilian Population in Labor Force 16 years and over.
    -   A06001. Nativity by Citizenship status.
6.  Look over the tables and make sure they look correct, and then click the CSV download icon on the right. Choose output options "Output column labels in the first row" and then download the CSV file *and* the data dictionary for reference.
7.  Place the downloaded files in the `data/data_raw` directory of your project.

### Download IPUMS Data

Here are the steps you should follow to define your own extract:

1.  Register on the [IPUMS website](https://uma.pop.umn.edu/usa/user/new?return_url=https%3A%2F%2Fusa.ipums.org%2Fusa-action%2Fmenu). Remember to use it for Good and never for Evil!
2.  From The [IPUMS-USA main page](https://usa.ipums.org/usa/), go to "[Browse and Select Data](https://usa.ipums.org/usa-action/variables/group)."
3.  Choose "Select Samples". Uncheck the "Default sample from each year" to de-select all samples and then choose the 2016 ACS. Click "Submit Sample Selection" at the bottom.
4.  IPUMS will include several technical variables automatically. The remaining variables can be browsed and selected by clicking on the "+" button. Here are the variables that we will need:
    -   In Household \> Geographic \> MET2013. This is the numeric id that identifies metropolitan statistical areas ("cities").
    -   In Person \> Race, Ethnicity, and Nativity \> RACE and HISPAN
    -   In Person \> Occupational Standing \> SEI
5.  Once you have all the variables that you need, select "View Cart" in upper right. Review your selections and then hit "Create Data Extract." On the next screen, you can write a description of your extract, and then hit "Submit Extract."
6.  You will now be sent to a screen with all of your previous and pending extracts. You can also get to this page from the main page by hitting the "[Download or Revise Extract](https://usa.ipums.org/usa-action/extract_requests/download)" link. Your fixed-width data will not be immediately available. However, you will have access to some documentation, including some scripts in other software programs for reading in the data. You should save the basic codebook (its a plain text file) into your `input` directory of your project. This codebook will provide important information on the structure and coding of the data.
7.  You will get an email when you data extract is ready. You can then go to the download page and download it. The data will download with the extension .gz. This is a g-zipped file. **Please leave it zipped**. R can read in zipped files and unzipped it will be too large for GitHub. Put this file in your `input` directory.

One nice feature of the IPUMS site, is that you can revise extracts on the download page. If you screw something up on your first try (probable), rather than starting from scratch, you can choose to revise an extract and just remove or add the variables and or samples you forgot.

### Read in the Raw Data

You will need to write code in the `organize_data.R` script that reads in the fixed-width datasets you just downloaded. There is a section each for the IPUMS and tract data. You will also need to do some post-read dataset clean up.

#### Reading in the IPUMS Data

The IPUMS data is in fixed-width format. The codebook should provide you with the information you need to determine the widths necessary to read in the data. We will use the `read_fwf` function in the `readr` library rather than the `read.fwf` function in base R, because `read_fwf` is much faster and allows us to directly read a g-zipped file.

Note that all of the IPUMS variables are coded as numeric values. You need to use the codebook to see which categories these numbers correspond to in cases of categorical variables. There is no need to recode them as factors for this assignment as we will create our own categorical variables in the next assignment.

Be sure that all of your variables have good variable names following the syntax rules [outlined above](#code-syntax). Furthermore, to tidy up our dataset, I would like you to subset it so that only cases with a valid `met2013` and `sei` value (i.e. non-zero value) are kept.

#### Reading in the Tract Data

The tract data is in CSV format so it should be easier to load into R. Keep in mind that if you did as instructed above and added labels in the first row of the CSV, you will need to skip a row when you read in the CSV.

After you have read in the tract data, I would like you to run the code that is already present in the script to assign metropolitan area ids to each tract. These will not be provided in the data from Social Explorer, but can be determined by cross-referencing state and county ids with metropolitan statistical area ids, which is what this code does (the file we are using to do it is called a "crosswalk" file). You should then remove any tracts with a missing value on met2013 id, because these tracts do not belong to metropolitan statistical areas.

One annoying thing about the Social Explorer data is the non-intuitive nature of the variable names. There are also a lot of variables that we do not need. I would like you to keep only the following variables and to rename them to something more intuitive. You can look in your codebook and use the data viewer in RStudio to deduce where these variables are.

-   The metropolitan id already named `met2013`. Please keep this name as we will use it to merge datasets later.
-   The metropolitan name named `met_name`. Keep this name.
-   total population in the tract.
-   total population of non-Hispanic whites.
-   total population of non-Hispanic blacks.
-   total population over the age of 25. This is used as the denominator for the educational categories that follow.
-   total population over the age of 25 with bachelor's degree.
-   total population over the age of 25 with master's degree.
-   total population over the age of 25 with professional degree.
-   total population over the age of 25 with doctoral degree.
-   total labor force population
-   total number of persons unemployed
-   total number of persons foreign-born

## Recoding Variables Assignment

For this assignment, you will code a new variable in the IPUMS dataset. You should use the `race` and `hispan` variables to code a new factor variable called `racecombo`. This variable should have the following categories:

-   Non-Hispanic White
-   Non-Hispanic Black
-   non-Hispanic Asian or Pacific Islander
-   non-Hispanic American Indian or Alaska Native
-   non-Hispanic Other
-   non-Hispanic Multiple race
-   Hispanic

After creating this variable, you should run some diagnostic checks to make sure that all the observations are in the categories that you expected.

## Reshaping and Merging Data Assignment

For this assignment, we will combine all the pieces we have been working on so far to create a single metro area level dataset.

### IPUMS Data

Ultimately, we want to create a metro area level dataset with the following variables:

-   `met2013`: the metro area id
-   `seidiff`: the mean SEI of whites in each metro area minus the mean SEI of blacks in each metro area.

Furthermore, some metro areas had very small samples of either white or black respondents. In these cases, there is likely to be a lot of statistical noise in our estimation of the SEI differences. To address this problem, I want you to remove all metro areas that had fewer than 50 black or white respondents. This is crude but fairly effective. We will learn a better way to handle this kind of issue next term (spoiler: multilevel models).

Our first step is to aggregate the individual level IPUMS data to the metro area level to get SEI differences by race for each metro area using `group_by` and `summarize`. If you group by metro area and race at the same time, you will be able to use the `mean()` and `n()` functions within the summarize to get the mean SEI and sample size, respectively, for each racial group in each metro.

The next step is to reshape this aggregated data, which is in long format, to a wide format so that you can calculate the SEI difference between the mean of white and black respondents. Once you have calculated this value, you should restrict the dataset as described above and then remove all of the unneeded variables.

### Tract Data

We want to aggregate the tract data for each metro area to construct four variables.

-   `pct_black`: The percent of the population that is non-Hispanic black.
-   `unemployment`: The unemployment rate, which is the percent of the labor force that is unemployed.
-   `pct_foreign_born`: The percent of the population that is foreign born.
-   `pct_college`: The percent of the population over the age of 25 that has *at least* a Bachelor's degree.

You should be able to do all of this recoding with the `group_by` and `summarize` commands. Note that if you aggregate across both `met2013` and `met_name`, you will get both metro-area numeric ids and names in your aggregated data.

### Merge the Data Sources

We now want to merge the two metro-level datasets created in the prior two steps together to create a combined dataset. You should call this combined dataset `met_area`.

You should note that these Social Explorer and IPUMS datasets do not contain the same number of observations at the metropolitan level. The IPUMS data has far fewer metro areas because only very large metro areas were identified in the individual-level data. There are also a couple of cases where the IPUMS data does not have a corresponding metro area from the tract data due to some discrepancies in identification between the two data sources. Your final dataset should contain only metro areas that had valid observations in both datasets.

## Programming Assignment

For this assignment, you will calculate a measure of segregation called the Dissimilarity Index or *D* for short. The dissimilarity index measures the extent to which two groups are unevenly distributed across neighborhoods in a city. The dissimilarity index has a clean and intuitive interpretation : the percent of one of the two groups that would have to move neighborhoods in order to make the distribution of the two groups even across the entire city. One nice feature of the dissimilarity index is that it is indiﬀerent to the relative size of the groups in the city. Thus, the dissimilarity indices of two cities with very diﬀerent racial distributions (e.g. Portland and Detroit) can be directly compared.

Typically, researchers treat the census tract, which is one of the smallest spatial boundaries used by the Census Bureau in its reported data aggregation, as a "neighborhood." If we have $n$ census tracts in a given metropolitan area, the dissimilarity index D is given by:

$$D=100 * (1/2) * \sum_{i=1}^n \mid (a_i/A) − (b_i/B) \mid$$

Where $a_i$ is the number of group a members that live in census tract $i$ and $A$ is the total number of group $a$ members in the city, and $b_i$ and $B$ are identical numbers for group $b$. The value $a_i/A$ is the proportion of group $a$ out of the entire city that lives in census tract $i$ and $b_i/B$ is the proportion of group $b$ out of the entire city that lives in census tract $i$. If both groups are evenly distributed over the city, the difference in these numbers should be zero for every census tract.

Here are the following logical steps that need to be performed to calculate the dissimilarity index:

1.  Calculate the distributions of each racial group across the city ($a_i/A$ and $b_i/B$). T
2.  Subtract one of the distributions from (1) from the other and take the absolute value with the `abs` function.
3.  Sum up the values from (3) and multiply by 50.

To calculate this measure for all cities in your tracts data, you must do the following:

1.  Create a `calculate_dissimilarity` function that when given a dataset of tracts, will compute the dissimilarity index and return the results.
2.  A for-loop or `sapply` command that uses the function above to actually calculate dissimilarity for each metropolitan area.
3.  Create a `tibble` of dissimilarity indices from the results of (2). This dataset should have two variables:
    -   `met2013` to identify metropolitan areas
    -   `dissim_index` for the actual dissimilarity index in each metropolitan area.
4.  Merge this new data.frame with the combined `met_area` data.frame you constructed in the previous assignment.

You should now have a final analytical dataset. it should be named `met_area`. You should save this as `met_area.RData` in the `output` directory with the `save` command. We are now done with the `organize_data.R` script.

## Final Project

In this assignment, we will finally answer the research question: How does the relative size of the black population and the level of black/white segregation in a city affect the difference in occupational status between whites and blacks?

Ultimately, I want you to report your results in a short PDF report from a Quarto file. I give you freedom in thinking about how to get there, but you will ultimately need some linear models that consider controls for the percent foreign born, percent college educated, and unemployment in a city. You will also want to give some thought to graphical displays of the univariate and bivariate distributions of key variables.

You can use the `report.qmd` file in the repository as a skeleton for your report. This document contains some stub information about sectioning of the report and what should go into each section of the report.

When your report is completed, be sure to commit the PDF file to Canvas.

## References

Blalock, Hubert M. 1967. *Toward a Theory of Minority-Group Relations.* New York: John Wiley and Sons.

Massey, Douglas S. and Nancy A. Denton. 1993. *American Apartheid: Segregation and the Making of the Underclass.* Cambridge: Harvard University Press.
