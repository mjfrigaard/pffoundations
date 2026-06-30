#' Future value of investing an annual raise
#'
#' Calculates how much a raise would be worth if the additional income were
#' invested each year rather than spent, using standard future-value-of-annuity
#' compounding.
#'
#' @param current_income Current annual gross income
#' @param raise_pct Raise as a decimal (e.g. `0.05` for 5%)
#' @param years Number of years to project
#' @param rate Annual investment return rate as a decimal (default: `0.07`)
#' @return Future value in dollars
#' @family income
#' @export
#' @examples
#' raise_invested_value(60000, 0.05, 10)       # ~$41 700
#' raise_invested_value(60000, 0.05, 30, 0.07) # ~$283 000
raise_invested_value <- function(current_income, raise_pct, years, rate = 0.07) {
  annual_raise <- current_income * raise_pct
  annual_raise * ((1 + rate)^years - 1) / rate
}
