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
