#' Retrieve Public Holidays for a Country in a Given Year
#'
#' This function retrieves a list of public holidays for a specific country and year using the Nager.Date API.
#'
#' @param country_code A character string representing the ISO 3166-1 alpha-2 country code (e.g., "DE" for Germany).
#' @param year An integer representing the year (e.g., 2025).
#'
#' @return A tibble containing the following columns:
#' \describe{
#'   \item{date}{The date of the public holiday (format: "YYYY-MM-DD").}
#'   \item{localName}{The local name of the public holiday (e.g., "Neujahr" for New Year's Day in Germany).}
#'   \item{name}{The English name of the public holiday (e.g., "New Year's Day").}
#'   \item{countryCode}{The ISO 3166-1 alpha-2 country code (e.g., "DE").}
#'   \item{fixed}{A logical value indicating whether the public holiday has a fixed date (e.g., New Year's Day is always on January 1st).}
#'   \item{global}{A logical value indicating whether the public holiday is observed globally in the country.}
#'   \item{counties}{A list of counties or regions where the public holiday is observed (if applicable).}
#'   \item{launchYear}{The year the public holiday was first observed (if available).}
#'   \item{types}{A list of types or categories of the public holiday (e.g., "Public").}
#' }
#'
#' @export
#'
#' @examples
#' # Retrieve public holidays for Germany in 2025
#' holidays <- ph_public_holidays("DE", 2025)
#' print(holidays)
#'
#' @seealso
#' \code{\link{ph_long_weekends}} for retrieving long weekends for a specific country and year.
#' \code{\link{ph_available_countries}} for retrieving a list of available countries.
#'
#' @references
#' Nager.Date API documentation: \url{https://date.nager.at/Api}
ph_public_holidays <- function(country_code, year) {
  base_url <- paste0("https://date.nager.at/api/v3/PublicHolidays/", year, "/", country_code)
  req <- httr2::request(base_url) |>
    httr2::req_user_agent("publicholidays (https://github.com/Raccoon-he/publicholidays)")

  tryCatch({
    resp <- req |>
      httr2::req_perform() |>
      httr2::resp_body_string() |>
      jsonlite::fromJSON() |>
      tibble::as_tibble()
    resp
  }, error = function(e) {
    stop("Failed to retrieve data: ", e$message)
  })
}
