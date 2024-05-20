library(glue)
library(clipr)

# string to add dataframe into chatgpt prompt string
# ensure it can optionally write to clipboard using clipr
copy_with_msg <- function(x, msg = "Copied to clipboard"){
    clipr::write_clip(x)
    message(msg)
}

glue_obj <- function(x, string, copy_to_clipboard, msg, silent = F, ...) {
    new_env <- new.env()
    new_env$data <- paste(capture.output(print(x)), collapse = "\n")
    x <- glue::glue(string, .envir = new_env, ...)
    if (copy_to_clipboard) {
        copy_with_msg(x, msg)
    }
    if (!silent){
        x
    }
}

glue_prompt <- function(
    x,
    string,
    copy_to_clipboard = T,
    msg = "",
    ...) {
    glue_obj(x, string, copy_to_clipboard, msg, ...)
}

silent_glue_prompt <- function(
    x,
    string,
    copy_to_clipboard = T,
    msg = "Prompt copied to clipboard.",
    ...) {
    glue_obj(x, string, copy_to_clipboard, msg, silent = T, ...)
}


conf_si_vec <- readr::read_csv("conf_si.csv") %>% 
    jsonlite::toJSON(auto_unbox = TRUE)

prompt4glue <- "Let's begin. I'm going to ask you questions about Posit Conf 2024. Posit::conf(2024) is one day of workshops, two days of conference keynotes and talks, and the ultimate hub for creating connections in the open-source community. It will be hosted in Hyatt Regency Seattle this year. Here's the agenda for the conference: \n{conf_si_vec}"

x <- glue_prompt(conf_si_vec, prompt4glue)

# Write prompt to text file:
writeLines(x, "prompt.txt")

rstudioapi::navigateToFile("prompt.txt")

# Copy prompt to clipboard
clipr::write_clip(x)
