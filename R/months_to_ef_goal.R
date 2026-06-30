#' Months to reach an emergency fund goal
#'
#' @param target Target emergency fund balance
#' @param current_savings Current savings already set aside
#' @param monthly_contribution Amount added to the fund each month
#' @return Number of months to reach `target` (ceiling integer); `0` if already
#'   at or above the target
#' @family emergency_fund
#' @export
#' @examples
#' months_to_ef_goal(18000, 3000, 500)  # 30 months
months_to_ef_goal <- function(target, current_savings, monthly_contribution) {
  remaining <- target - current_savings
  if (remaining <= 0) return(0L)
  ceiling(remaining / monthly_contribution)
}
