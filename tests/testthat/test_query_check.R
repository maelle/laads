context("laads_query_check")

test_that("An error is returned if wrong product name", {
  expect_error(laads_collections(product = "lala"), "lala is not a product name")
})
