#' Get Available Countries
#'
#' This function retrieves a list of available countries for which public holiday data is provided by the Nager.Date API.
#'
#' @return A tibble containing the following columns:
#' \describe{
#'   \item{countryCode}{The ISO 3166-1 alpha-2 country code (e.g., "DE" for Germany).}
#'   \item{name}{The name of the country (e.g., "Germany").}
#' }
#'
#' @export
#'
#' @examples
#' # Get the list of available countries
#' countries <- ph_available_countries()
#' print(countries)
#'
#' @seealso
#' \code{\link{ph_public_holidays}} for retrieving public holidays for a specific country and year.
#'
#' @references
#' Nager.Date API documentation: \url{https://date.nager.at/Api}

ph_available_countries <- function() {
  base_url <- "https://date.nager.at/api/v3/AvailableCountries"
  req <- httr2::request(base_url) |>
    httr2::req_user_agent("nagerdate (https://github.com/krose/nagerdate)")
  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_string() |>
    jsonlite::fromJSON() |>
    tibble::as_tibble()
  resp
}
