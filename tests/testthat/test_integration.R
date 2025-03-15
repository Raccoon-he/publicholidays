library(testthat)
devtools::load_all()  # load all fucnc

# test ph_available_countries & ph_country_info
test_that("ph_available_countries and ph_country_info work together", {
  countries <- ph_available_countries()
  expect_true(tibble::is_tibble(countries))

  # gain info of first country
  if (nrow(countries) > 0) {
    country_code <- countries$countryCode[1]
    country_info <- ph_country_info(country_code)

    expect_true(tibble::is_tibble(country_info))
    expect_equal(country_info$countryCode, country_code)
  }
})

# test ph_public_holidays & ph_long_weekends
test_that("ph_public_holidays and ph_long_weekends work together", {
  # gain info of US
  holidays <- ph_public_holidays("US", 2023)
  long_weekends <- ph_long_weekends("US", 2023)
  expect_true(tibble::is_tibble(holidays))
  expect_true(tibble::is_tibble(long_weekends))

  # verify if longweekends in holidays
  if (nrow(long_weekends) > 0) {
    for (i in seq_len(nrow(long_weekends))) {
      expect_true(
        long_weekends$startDate[i] %in% holidays$date ||
          long_weekends$endDate[i] %in% holidays$date,
        info = paste("Long weekend from", long_weekends$startDate[i], "to", long_weekends$endDate[i], "is not valid.")
      )
    }
  }
})

# test ph_country_info & ph_is_today_holiday
test_that("ph_country_info and ph_is_today_holiday work together", {
  # gain Germany info
  de_info <- ph_country_info("DE")
  is_holiday <- ph_is_today_holiday("DE")
  expect_true(tibble::is_tibble(de_info))
  expect_true(is.logical(is_holiday))
})

# test ph_available_countries & ph_public_holidays
test_that("ph_available_countries and ph_public_holidays work together", {
  # gain country list
  countries <- ph_available_countries()
  expect_true(tibble::is_tibble(countries))
  if (nrow(countries) > 0) {
    country_code <- countries$countryCode[1]
    holidays <- ph_public_holidays(country_code, 2023)
    expect_true(tibble::is_tibble(holidays))
  }
})

# test ph_public_holidays & ph_is_today_holiday
test_that("ph_public_holidays and ph_is_today_holiday work together", {
  # gain US info
  holidays <- ph_public_holidays("US", 2023)
  expect_true(tibble::is_tibble(holidays))
  is_holiday <- ph_is_today_holiday("US")
  expect_true(is.logical(is_holiday))
})
