#' Convert to Monthly Rate
#'
#' Scale spending from any time period to monthly equivalent. Inverse of [to_annual()].
#'
#' @param amount Numeric amount to convert to monthly
#' @param period Character; one of "daily", "weekly", or "monthly"
#'
#' @return Numeric monthly equivalent amount
#'
#' @family Budgeting
#'
#' @examples
#' to_monthly(1825, "daily")  # 1825 / (365/12) = 60
#' to_monthly(5200, "weekly") # 5200 / (52/12) = 1200
#' to_monthly(6000, "monthly") # 6000 / 12 = 500
#'
#' @export
to_monthly <- function(amount, period = c("daily", "weekly", "monthly")) {
  period <- match.arg(period)
  factors <- c(daily = 365, weekly = 52, monthly = 12)
  amount / factors[[period]]
}
