#' Subscription Opportunity Cost
#'
#' Calculate the future value of investing a subscription cost instead of spending it.
#' Used in the Tracking Spending chapter to demonstrate the long-term cost of recurring expenses.
#'
#' Formula: $annual_cost * ((1 + rate)^years - 1) / rate$
#'
#' @param monthly_cost Numeric monthly subscription cost in dollars
#' @param years Numeric number of years to project
#' @param rate Numeric annual return rate as decimal (default: 0.07 = 7%)
#'
#' @return Numeric future value of invested subscription cost
#'
#' @family Tracking Spending
#'
#' @examples
#' subscription_opportunity_cost(20, 30)
#' subscription_opportunity_cost(100, 20, rate = 0.05)
#'
#' @export
subscription_opportunity_cost <- function(monthly_cost, years, rate = 0.07) {
  annual_cost <- monthly_cost * 12
  annual_cost * ((1 + rate)^years - 1) / rate
}
