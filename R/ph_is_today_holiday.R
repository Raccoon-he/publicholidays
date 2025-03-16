#' Check if Today is a Public Holiday in a Specific Country
#'
#' This function checks whether today is a public holiday in the specified country using the Nager.Date API.
#'
#' @param country_code A character string representing the ISO 3166-1 alpha-2 country code (e.g., "DE" for Germany).
#'
#' @return A logical value:
#' \describe{
#'   \item{TRUE}{If today is a public holiday in the specified country.}
#'   \item{FALSE}{If today is not a public holiday in the specified country.}
#' }
#'
#' @export
#'
#' @examples
#' # Check if today is a public holiday in Germany
#' is_holiday <- ph_is_today_holiday("DE")
#' if (is_holiday) {
#'   print("Today is a public holiday in Germany!")
#' } else {
#'   print("Today is not a public holiday in Germany.")
#' }
#'
#' @seealso
#' \code{\link{ph_public_holidays}} for retrieving public holidays for a specific country and year.
#' \code{\link{ph_available_countries}} for retrieving a list of available countries.
#'
#' @references
#' Nager.Date API documentation: \url{https://date.nager.at/Api}
ph_is_today_holiday <- function(country_code) {
  # get today's date
  today <- format(Sys.Date(), "%Y-%m-%d")

  # build API url
  base_url <- paste0("https://date.nager.at/api/v3/PublicHolidays/", format(Sys.Date(), "%Y"), "/", country_code)
  req <- httr2::request(base_url) |>
    httr2::req_user_agent("publicholidays (https://github.com/Raccoon-he/publicholidays)")

  # send req
  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_string() |>
    jsonlite::fromJSON() |>
    tibble::as_tibble()

  # check today is holiday or not
  today %in% resp$date
}
