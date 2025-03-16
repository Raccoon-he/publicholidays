#' Get Long Weekends for a Country in a Given Year
#'
#' This function retrieves a list of long weekends (extended weekends due to public holidays) for a specific country and year using the Nager.Date API.
#'
#' @param country_code A character string representing the ISO 3166-1 alpha-2 country code (e.g., "DE" for Germany).
#' @param year An integer representing the year (e.g., 2025).
#'
#' @return A tibble containing the following columns:
#' \describe{
#'   \item{startDate}{The start date of the long weekend (format: "YYYY-MM-DD").}
#'   \item{endDate}{The end date of the long weekend (format: "YYYY-MM-DD").}
#'   \item{dayCount}{The number of days in the long weekend.}
#'   \item{needBridgeDay}{A logical value indicating whether a bridge day is needed to create the long weekend.}
#'   \item{bridgeDays}{A list of bridge days (if any) required to create the long weekend.
#' }
#'
#' @export
#'
#' @examples
#' # Get long weekends for Germany in 2025
#' long_weekends <- ph_long_weekends("DE", 2025)
#' print(long_weekends)
#'
#' @seealso
#' \code{\link{ph_public_holidays}} for retrieving public holidays for a specific country and year.
#' \code{\link{ph_available_countries}} for retrieving a list of available countries.
#'
#' @references
#' Nager.Date API documentation: \url{https://date.nager.at/Api}
ph_long_weekends <- function(country_code, year) {
  base_url <- paste0("https://date.nager.at/api/v3/LongWeekend/", year, "/", country_code)
  req <- httr2::request(base_url) |>
    httr2::req_user_agent("publicholidays (https://github.com/Raccoon-he/publicholidays)")
  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_string() |>
    jsonlite::fromJSON() |>
    tibble::as_tibble()
  resp
}
