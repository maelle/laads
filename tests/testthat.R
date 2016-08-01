library(testthat)
library(laads)

if (identical(tolower(Sys.getenv("NOT_CRAN")), "true")) {
  test_check("laads")
}

