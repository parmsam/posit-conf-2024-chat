library(testthat)
library(glue)

test_that("copy_with_msg copies input to clipboard", {
    x <- "test"
    copy_with_msg(x)
    expect_equal(clipr::read_clip(), x)
})

test_that("glue_obj returns the expected glued string", {
    x <- "test obj"
    string <- "This is a test object:\n{x}"
    expect_equal(glue_obj(x, string, copy_to_clipboard = F), "This is a test object:\ntest obj")
})

test_that("glue_prompt returns the expected glued string", {
    x <- head(iris)
    string <- "Give me the first 6 rows of the iris dataset:\n{data}"
    result <- glue_prompt(x, string)
    expect_output(print(result), "Give me the first 6 rows of the iris dataset:\\n  Sepal\\.Length")
})
