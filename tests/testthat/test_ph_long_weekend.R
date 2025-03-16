library(testthat)

test_that("ph_long_weekends returns long weekends for the US in 2023", {
  long_weekends <- ph_long_weekends("US", 2023)
  expect_true(tibble::is_tibble(long_weekends))
  expect_true("startDate" %in% colnames(long_weekends))
  expect_true("endDate" %in% colnames(long_weekends))
})
