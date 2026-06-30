#' Convert APR to APY
#'
#' Annual Percentage Rate (APR) is the stated rate; Annual Percentage Yield
#' (APY) accounts for within-year compounding and is always >= APR.
#'
#' @param apr Annual percentage rate as a decimal (e.g. `0.20` for 20%)
#' @param n Number of compounding periods per year (default: `12` for monthly)
#' @return APY as a decimal
#' @family managing_debt
#' @export
#' @examples
#' apr_to_apy(0.20)        # ~0.2194 — 20% APR ≈ 21.94% APY
#' apr_to_apy(0.20, n = 365) # daily compounding
apr_to_apy <- function(apr, n = 12) {
  (1 + apr / n)^n - 1
}
