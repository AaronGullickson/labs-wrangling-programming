# This script will check for and install if necessary and packages required for
# the project

if(!require("tidyverse")) {
  install.packages("tidyverse")
  library(tidyverse)
}

if(!require("gt")) {
  install.packages("gt")
  library(gt)
}

if(!require("modelsummary")) {
  install.packages("modelsummary")
  library(modelsummary)
}

if(!tinytex::is_tinytex()) {
  system("quarto install tinytex")
}

