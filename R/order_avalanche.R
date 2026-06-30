#' Order debts by avalanche strategy (highest APR first)
#'
#' The avalanche method minimizes total interest paid by targeting the
#' highest-rate debt first.
#'
#' @param debts A data frame with at least `balance` and `apr` columns
#' @return `debts` reordered highest APR first, with a `strategy` column
#'   set to `"avalanche"`
#' @family managing_debt
#' @export
#' @examples
#' debts <- data.frame(
#'   name    = c("Credit Card", "Car Loan", "Student Loan"),
#'   balance = c(3000, 8000, 20000),
#'   apr     = c(0.22, 0.06, 0.05)
#' )
#' order_avalanche(debts)
order_avalanche <- function(debts) {
  debts <- debts[order(debts$apr, decreasing = TRUE), ]
  debts$strategy <- "avalanche"
  debts
}
