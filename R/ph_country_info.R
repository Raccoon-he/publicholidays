#' Get Country Information
#'
#' This function retrieves detailed information about a specific country using the Nager.Date API.
#'
#' @param country_code A character string representing the ISO 3166-1 alpha-2 country code (e.g., "DE" for Germany).
#'
#' @return A tibble containing the following columns:
#' \describe{
#'   \item{commonName}{The common name of the country (e.g., "Germany").}
#'   \item{officialName}{The official name of the country (e.g., "Federal Republic of Germany").}
#'   \item{countryCode}{The ISO 3166-1 alpha-2 country code (e.g., "DE").}
#'   \item{region}{The region where the country is located (e.g., "Europe").}
#'   \item{borders}{A list of country codes for countries that share a border with the specified country.}
#' }
#'
#' @export
#'
#' @examples
#' # Get information about Germany
#' country_info <- ph_country_info("DE")
#' print(country_info)
#'
#' @seealso
#' \code{\link{ph_available_countries}} for retrieving a list of available countries.
#' \code{\link{ph_public_holidays}} for retrieving public holidays for a specific country and year.
#'
#' @references
#' Nager.Date API documentation: \url{https://date.nager.at/Api}
ph_country_info <- function(country_code) {
  base_url <- paste0("https://date.nager.at/api/v3/CountryInfo/", country_code)
  req <- httr2::request(base_url) |>
    httr2::req_user_agent("nagerdate (https://github.com/krose/nagerdate)")
  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_string() |>
    jsonlite::fromJSON()
  df <- tibble::tibble(
    commonName = resp$commonName,
    officialName = resp$officialName,
    countryCode = resp$countryCode,
    region = resp$region,
    borders = list(resp$borders)
  )
  df
}
