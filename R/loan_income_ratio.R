#' Loan balance to annual income ratio
#'
#' A common rule of thumb: student loan balances above 1x annual income are
#' considered unmanageable on a standard repayment plan.
#'
#' @param loan_balance Total outstanding loan balance
#' @param annual_income Gross annual income
#' @return Ratio (e.g. `1.5` means debt is 1.5x annual income)
#' @family managing_debt
#' @export
#' @examples
#' loan_income_ratio(45000, 50000)  # 0.9 — manageable
#' loan_income_ratio(80000, 50000)  # 1.6 — consider IDR
loan_income_ratio <- function(loan_balance, annual_income) {
  loan_balance / annual_income
}
