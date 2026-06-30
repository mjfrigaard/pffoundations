#' Monthly contribution needed to reach an emergency fund goal
#'
#' @param target Target emergency fund balance
#' @param current_savings Current savings already set aside
#' @param months Number of months in which to reach the target
#' @return Required monthly contribution in dollars
#' @family emergency_fund
#' @export
#' @examples
#' monthly_contribution_needed(18000, 3000, 30)  # $500/mo
monthly_contribution_needed <- function(target, current_savings, months) {
  (target - current_savings) / months
}
