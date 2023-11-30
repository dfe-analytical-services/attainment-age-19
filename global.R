# ---------------------------------------------------------
# This is the global file.
# Use it to store functions, library calls, source files etc.
# Moving these out of the server file and into here improves performance
# The global file is run only once when the app launches and stays consistent across users
# whereas the server and UI files are constantly interacting and responsive to user input.
#
# ---------------------------------------------------------


# Library calls ---------------------------------------------------------------------------------

shhh <- suppressPackageStartupMessages # It's a library, so shhh!
shhh(library(data.table))
shhh(library(RColorBrewer))
shhh(library(shinycssloaders))
shhh(library(DT))
shhh(library(ggalt))
shhh(library(magrittr))
shhh(library(readr))
shhh(library(styler))
shhh(library(tools))
shhh(library(testthat))
shhh(library(shinytest))
shhh(library(shinydashboard))
shhh(library(shinyWidgets))
shhh(library(shinyGovstyle))
shhh(library(ggplot2))
shhh(library(plotly))
shhh(library(DT))
shhh(library(shiny))
shhh(library(shinyjs))
shhh(library(stringr))
shhh(library(tidyr))
shhh(library(dplyr))
shhh(library(dfeshiny))
# shhh(library(shinya11y))

# Functions ---------------------------------------------------------------------------------

# Here's an example function for simplifying the code needed to commas separate numbers:

# cs_num ----------------------------------------------------------------------------
# Comma separating function

cs_num <- function(value) {
  format(value, big.mark = ",", trim = TRUE)
}

# Source scripts ---------------------------------------------------------------------------------

# Source any scripts here. Scripts may be needed to process data before it gets to the server file.
# It's best to do this here instead of the server file, to improve performance.

# source("R/filename.r")


# appLoadingCSS ----------------------------------------------------------------------------
# Set up loading screen

appLoadingCSS <- "
#loading-content {
  position: absolute;
  background: #000000;
  opacity: 0.9;
  z-index: 100;
  left: 0;
  right: 0;
  height: 100%;
  text-align: center;
  color: #FFFFFF;
}
"
site_primary <- "https://department-for-education.shinyapps.io/attainment-age-19/"
google_analytics_key <- "T9WZJQG4KW"
