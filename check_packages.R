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

if(!require("texreg")) {
  install.packages("devtools")
  library(devtools)
  install_github("leifeld/texreg")
  library(texreg)
}

if(!require(tinytex)) {
  install.packages("tinytex")
  library(tinytex)
}

if(!tinytex::is_tinytex()) {
  system("quarto install tinytex")
}

