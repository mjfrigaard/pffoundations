#' Months to pay off a loan balance
#'
#' Uses the standard amortization formula to determine how many months until
#' the balance reaches zero. Returns `Inf` if the monthly payment is too small
#' to cover the first month's interest.
#'
#' @param balance Current outstanding loan balance
#' @param monthly_payment Fixed monthly payment amount
#' @param apr Annual percentage rate as a decimal (e.g. `0.18` for 18%)
#' @return Number of months (ceiling integer), or `Inf` if payment is too low
#' @family managing_debt
#' @export
#' @examples
#' months_to_payoff(5000, 200, 0.18)  # ~32 months
months_to_payoff <- function(balance, monthly_payment, apr) {
  r <- apr / 12
  if (r == 0) return(ceiling(balance / monthly_payment))
  if (monthly_payment <= balance * r) return(Inf)
  ceiling(-log(1 - (balance * r) / monthly_payment) / log(1 + r))
}
