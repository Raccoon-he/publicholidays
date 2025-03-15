# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/testing-design.html#sec-tests-files-overview
# * https://testthat.r-lib.org/articles/special-files.html

library(testthat)
library(publicholidays)

test_that("ph_available_countries returns a tibble", {
  countries <- ph_available_countries()
  expect_true(tibble::is_tibble(countries))
  expect_true("countryCode" %in% colnames(countries))
  expect_true("name" %in% colnames(countries))
})
