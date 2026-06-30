#' Debt-to-income ratio
#'
#' The DTI ratio is a key underwriting metric. A front-end DTI (housing only)
#' above 0.28 or back-end DTI (all debt) above 0.36 typically signals risk to
#' lenders.
#'
#' @param total_monthly_debt Sum of all monthly debt payments
#' @param gross_monthly_income Gross (pre-tax) monthly income
#' @return DTI ratio as a decimal
#' @family managing_debt
#' @export
#' @examples
#' dti_ratio(1500, 5000)  # 0.30
dti_ratio <- function(total_monthly_debt, gross_monthly_income) {
  total_monthly_debt / gross_monthly_income
}
