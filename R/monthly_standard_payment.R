#' Standard amortizing monthly payment
#'
#' Computes the fixed monthly payment required to fully amortize a loan over
#' `n_months` months at a given APR.
#'
#' @param principal Loan principal in dollars
#' @param apr Annual percentage rate as a decimal
#' @param n_months Loan term in months
#' @return Monthly payment in dollars
#' @family managing_debt
#' @export
#' @examples
#' monthly_standard_payment(30000, 0.065, 120)  # 10-yr student loan at 6.5%
monthly_standard_payment <- function(principal, apr, n_months) {
  r <- apr / 12
  if (r == 0) return(principal / n_months)
  principal * r * (1 + r)^n_months / ((1 + r)^n_months - 1)
}
