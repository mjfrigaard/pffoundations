#' Total interest paid over the life of a loan
#'
#' @param balance Current outstanding loan balance
#' @param monthly_payment Fixed monthly payment amount
#' @param apr Annual percentage rate as a decimal
#' @return Total interest paid in dollars, or `Inf` if payment is too low
#' @family managing_debt
#' @export
#' @examples
#' total_interest(5000, 200, 0.18)  # total paid minus principal
total_interest <- function(balance, monthly_payment, apr) {
  n <- months_to_payoff(balance, monthly_payment, apr)
  if (is.infinite(n)) return(Inf)
  monthly_payment * n - balance
}
