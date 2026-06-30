#' Emergency fund target amount
#'
#' Calculates the recommended emergency fund size as a multiple of monthly
#' expenses. The conventional guidance is 3–6 months; 6 months is the default.
#'
#' @param monthly_expenses Total monthly essential expenses
#' @param months Number of months to cover (default: `6`)
#' @return Target emergency fund balance in dollars
#' @family emergency_fund
#' @export
#' @examples
#' emergency_fund_target(3000)      # $18 000 (6-month target)
#' emergency_fund_target(3000, 3)   # $9 000  (3-month target)
emergency_fund_target <- function(monthly_expenses, months = 6) {
  monthly_expenses * months
}
