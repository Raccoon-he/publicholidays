library(testthat)
library(httptest2)
library(tibble)

library(testthat)

test_that("ph_country_info returns correct information for Germany (DE)", {
  de_info <- ph_country_info("DE")
  expect_true(tibble::is_tibble(de_info))
  expect_equal(de_info$countryCode, "DE")
  expect_true("commonName" %in% colnames(de_info))
  expect_true("officialName" %in% colnames(de_info))
})
