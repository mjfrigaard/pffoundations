#' Emergency fund growth in a high-yield savings account
#'
#' Calculates the future value of regular monthly contributions to a HYSA,
#' using monthly compounding.
#'
#' @param monthly_contribution Amount deposited each month
#' @param months Number of months to project
#' @param rate Annual interest rate as a decimal (default: `0.045` = 4.5%)
#' @return Future value of the account in dollars
#' @family emergency_fund
#' @export
#' @examples
#' ef_growth(500, 12, 0.045)  # slightly more than $500 * 12 = $6 000
ef_growth <- function(monthly_contribution, months, rate = 0.045) {
  r <- rate / 12
  monthly_contribution * ((1 + r)^months - 1) / r
}
