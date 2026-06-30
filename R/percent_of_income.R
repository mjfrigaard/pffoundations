#' Percent of Income
#'
#' Calculate what share of income an expense represents.
#'
#' @param expense Numeric expense amount in dollars
#' @param income Numeric income amount in dollars
#'
#' @return Numeric percentage (0-100 or higher)
#'
#' @family Budgeting
#'
#' @examples
#' percent_of_income(1500, 5000)
#' percent_of_income(2000, 3000)
#'
#' @export
percent_of_income <- function(expense, income) {
  (expense / income) * 100
}
