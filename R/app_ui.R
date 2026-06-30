#' @noRd
app_ui <- function() {
  shiny::tagList(
    pffoundations_head(),
    bslib::page_navbar(
      title = "Personal Finance Field Manual: Foundations",
      theme = pffoundations_theme(),
      bslib::nav_panel("Income", mod_income_ui("income")),
      bslib::nav_panel("Tracking Spending", mod_tracking_spending_ui("tracking")),
      bslib::nav_panel("Budgeting", mod_budgeting_ui("budgeting")),
      bslib::nav_panel("Managing Debt", mod_managing_debt_ui("debt")),
      bslib::nav_panel("Emergency Fund", mod_emergency_fund_ui("ef"))
    )
  )
}
