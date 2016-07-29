context("laads_query_check")

test_that("An error is returned if wrong product name", {
  expect_error(laads_collections(product = "lala"), "lala is not a product name")
})


test_that("An error is returned if wrong instrument name", {
  expect_error(laads_product_groups(instrument = "lala"), "lala is not an instrument name")
})

