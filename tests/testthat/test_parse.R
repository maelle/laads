context("laads_parse")


test_that("laads_parse outputs a tbl_df",{
  expect_is(laads_products(), "tbl_df")
})
