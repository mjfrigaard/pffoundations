#' @noRd
app_server <- function(input, output, session) {
  mod_income_server("income")
  mod_tracking_spending_server("tracking")
  mod_budgeting_server("budgeting")
  mod_managing_debt_server("debt")
  mod_emergency_fund_server("ef")
}
