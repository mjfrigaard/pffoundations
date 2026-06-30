#' Format Percentage Values
#'
#' Format numeric values as percentages. Used throughout the app to display
#' ratios and percentages in a consistent, human-readable format.
#'
#' @param x Numeric value to format (typically 0-100)
#' @param digits Number of decimal places (default: 1)
#'
#' @return Character string formatted as percentage (e.g. "12.3%")
#'
#' @family utils
#'
#' @examples
#' fmt_pct(30)           # "30.0%"
#' fmt_pct(33.333, digits = 2)  # "33.33%"
#' fmt_pct(c(10, 25, 50))
#'
#' @export
fmt_pct <- function(x, digits = 1) {
  paste0(formatC(x, format = "f", digits = digits), "%")
}
