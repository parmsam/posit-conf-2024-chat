# Load necessary libraries
library(rvest)
library(dplyr)
library(glue)
library(purrr)

# Define the URLs of the web page
dates <- c("20240812", "20240813", "20240814")

# Glue the dates to the base URL
urls <- glue("https://reg.conf.posit.co/flow/posit/positconf24/publiccatalog/page/publiccatalog?tab.day={dates}")

# Define function to read the HTML content of the page
grab_si <- function(url) {
    chromote:::set_default_chromote_object(chromote::Chromote$new())
    Sys.sleep(2)
    # Read the HTML content of the page
    page <- read_html_live(url)
    # Wait 10 seconds
    Sys.sleep(10)
    # Extract session info
    conf_session_info <- page %>%
        html_elements(".rf-tile") %>%
        html_text2()
    return(conf_session_info)
}

# Map across the URLs and extract the session info into a flat vector
conf_si <- map(urls, grab_si)

conf_si_vec <- unlist(conf_si)

testthat::test_that("conf_si_vec has 63 elements", {
    testthat::expect_equal(length(conf_si_vec), 63)
})

if(TRUE){
    write.csv(conf_si_vec, "conf_si.csv", row.names = FALSE)
}

rstudioapi::navigateToFile("conf_si.csv")
