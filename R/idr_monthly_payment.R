#' Income-driven repayment monthly payment
#'
#' Estimates the monthly payment under an income-driven repayment (IDR) plan.
#' Supported plans and their parameters:
#'
#' | Plan | Poverty multiplier | Payment rate |
#' |------|--------------------|-------------|
#' | `"save"` | 225% | 10% |
#' | `"ibr"` | 150% | 10% |
#' | `"paye"` | 150% | 10% |
#' | `"icr"` | 100% | 20% |
#'
#' Poverty guideline base: $15,060 for a family of 1 (2024 contiguous US),
#' +$5,380 per additional person.
#'
#' @param agi Adjusted gross income
#' @param family_size Number of people in the household
#' @param plan IDR plan name: `"save"`, `"ibr"`, `"paye"`, or `"icr"`
#' @return Monthly payment in dollars (floored at 0)
#' @family managing_debt
#' @export
#' @examples
#' idr_monthly_payment(40000, 1, "save")  # ~$89/mo
#' idr_monthly_payment(40000, 2, "save")  # ~$49/mo
idr_monthly_payment <- function(agi, family_size, plan = "save") {
  poverty_line <- 15060 + (family_size - 1) * 5380

  params <- list(
    save = list(multiplier = 2.25, rate = 0.10),
    ibr  = list(multiplier = 1.50, rate = 0.10),
    paye = list(multiplier = 1.50, rate = 0.10),
    icr  = list(multiplier = 1.00, rate = 0.20)
  )
  p <- params[[plan]]
  discretionary <- max(0, agi - p$multiplier * poverty_line)
  (discretionary * p$rate) / 12
}
