#' Compare debt payoff versus investing
#'
#' Compares two strategies for a fixed monthly amount: (1) paying down
#' high-interest debt early versus (2) investing the same amount over `years`.
#' The better strategy depends on whether the investment return exceeds the
#' debt's APR.
#'
#' @param balance Current outstanding loan balance
#' @param apr Loan APR as a decimal
#' @param monthly_amount Monthly dollars available for payoff or investment
#' @param rate Expected annual investment return as a decimal (default: `0.07`)
#' @param years Projection horizon in years
#' @return A named list with `payoff_interest_saved`, `invest_future_value`,
#'   `invest_net_gain`, and `better_strategy`
#' @family managing_debt
#' @export
#' @examples
#' payoff_vs_invest(10000, 0.20, 300, years = 10)
payoff_vs_invest <- function(balance, apr, monthly_amount, rate = 0.07, years) {
  r_monthly <- rate / 12
  n_months  <- years * 12

  interest_saved <- total_interest(balance, monthly_amount, apr)
  invest_fv      <- monthly_amount * ((1 + r_monthly)^n_months - 1) / r_monthly
  invest_gain    <- invest_fv - (monthly_amount * n_months)

  list(
    payoff_interest_saved = interest_saved,
    invest_future_value   = invest_fv,
    invest_net_gain       = invest_gain,
    better_strategy       = if (invest_gain > interest_saved) "invest" else "payoff"
  )
}
