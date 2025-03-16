library(testthat)
library(httr2)
library(jsonlite)
library(tibble)
library(mockery)

test_that("ph_public_holidays returns holidays for the US in 2023", {
  holidays <- ph_public_holidays("US", 2023)
  expect_type(holidays, "list")
  expected_columns <- c("date", "localName", "name", "countryCode", "fixed", "global", "counties", "launchYear", "types")
  expect_true(all(expected_columns %in% names(holidays)))
  expect_gt(nrow(holidays), 0)
  expect_equal(unique(holidays$countryCode), "US")
  expect_true(all(substr(holidays$date, 1, 4) == "2023"))
})


# Test for invalid country code
test_that("ph_public_holidays handles invalid country code", {
  # Call the function with an invalid country code
  expect_error(ph_public_holidays("XX", 2023), "Failed to retrieve data")
})


# Test for invalid year
test_that("ph_public_holidays handles invalid year", {
  # Call the function with an invalid year
  expect_error(ph_public_holidays("US", 9999), "Failed to retrieve data")
})

##=======##
# library(covr)
# report(coverage, file = "coverage_report.html")
