#' Convert to Annual Rate
#'
#' Scale spending from any time period to annual equivalent.
#'
#' @param amount Numeric amount to annualize
#' @param period Character; one of "daily", "weekly", or "monthly"
#'
#' @return Numeric annual equivalent amount
#'
#' @family Budgeting
#'
#' @examples
#' to_annual(5, "daily")
#' to_annual(100, "weekly")
#' to_annual(500, "monthly")
#'
#' @export
to_annual <- function(amount, period = c("daily", "weekly", "monthly")) {
  period <- match.arg(period)
  factors <- c(daily = 365, weekly = 52, monthly = 12)
  amount * factors[[period]]
}
