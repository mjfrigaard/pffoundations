#' Order debts by snowball strategy (lowest balance first)
#'
#' The snowball method maximizes early wins by eliminating smaller balances
#' first, which can improve motivation even if it costs more in interest.
#'
#' @param debts A data frame with at least `balance` and `apr` columns
#' @return `debts` reordered lowest balance first, with a `strategy` column
#'   set to `"snowball"`
#' @family managing_debt
#' @export
#' @examples
#' debts <- data.frame(
#'   name    = c("Credit Card", "Car Loan", "Student Loan"),
#'   balance = c(3000, 8000, 20000),
#'   apr     = c(0.22, 0.06, 0.05)
#' )
#' order_snowball(debts)
order_snowball <- function(debts) {
  debts <- debts[order(debts$balance, decreasing = FALSE), ]
  debts$strategy <- "snowball"
  debts
}
