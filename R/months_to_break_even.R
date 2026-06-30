#' Months to Break Even
#'
#' Determine payback period for upfront costs with recurring monthly savings.
#'
#' @param upfront_cost Numeric upfront investment in dollars
#' @param monthly_savings Numeric recurring monthly savings in dollars
#'
#' @return Numeric number of months to break even (upfront_cost / monthly_savings)
#'
#' @family Budgeting
#'
#' @examples
#' months_to_break_even(500, 60)
#' months_to_break_even(2000, 150)
#'
#' @export
months_to_break_even <- function(upfront_cost, monthly_savings) {
  upfront_cost / monthly_savings
}
