library(glue)
library(clipr)

source("glue_prompt.R")

conf_si_vec <- readr::read_csv("conf_si.csv") |>
    jsonlite::toJSON(auto_unbox = TRUE)

prompt4glue <- "Let's begin. I'm going to ask you questions about Posit Conf 2024. Posit::conf(2024) is one day of workshops, two days of conference keynotes and talks, and the ultimate hub for creating connections in the open-source community. It will be hosted in Hyatt Regency Seattle this year. Here's the agenda for the conference: \n{data}"

x <- glue_prompt(conf_si_vec, prompt4glue)

# Write prompt to text file:
writeLines(x, "prompt.txt")

rstudioapi::navigateToFile("prompt.txt")

# Copy prompt to clipboard
clipr::write_clip(x)
