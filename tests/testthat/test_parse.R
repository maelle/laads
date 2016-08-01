context("laads_parse")


test_that("laads_products outputs a tbl_df",{
  expect_is(laads_products(), "tbl_df")
})

test_that("laads_collections outputs a tbl_df",{
  expect_is(laads_collections(product = "MCD15A2"), "tbl_df")
})

test_that("laads_data_coverage outputs a tbl_df",{
  expect_is(laads_data_coverage(collection = "5", product = "MCD15A2"), "tbl_df")
})

test_that("laads_search_files outputs a tbl_df",{
  expect_is(laads_search_files(product = "MCD15A2",
                         start_time = "2010-01-01",
                       end_time = "2015-05-02",
                        coords_or_tiles = "global",
                        day_night_both = "DNB"), "tbl_df")
})


test_that("laads_file_properties outputs a tbl_df",{
  files <- laads_search_files(product = "MCD15A2",
                                start_time = "2010-01-01",
                               end_time = "2010-01-10",
                               coords_or_tiles = "global",
                               day_night_both = "DNB")$file_id
  properties <- laads_file_properties(file_ids = files[1:10])
  expect_is(properties, "tbl_df")
})

test_that("laads_file_urls outputs a tbl_df",{
  expect_is(laads_file_urls(file_ids = c("299343600", "299344827")), "tbl_df")
})

test_that("laads_max_search_results outputs a numeric",{
  expect_is(laads_max_search_results(), "numeric")
})

test_that("laads_product_groups outputs a tbl_df",{
  expect_is(laads_product_groups(instrument = "AM1M"), "tbl_df")
})

test_that("laads_products_instrument outputs a tbl_df",{
  expect_is(laads_products_instrument(instrument = "AM1M", group = "LL3L4_A"), "tbl_df")
})

test_that("laads_satellite_instruments outputs a tbl_df",{
  expect_is(laads_satellite_instruments(), "tbl_df")
})

test_that("laads_search_datasets outputs a tbl_df",{
  expect_is(laads_search_datasets(keywords = c("AOD", "MODIS")), "tbl_df")
})

