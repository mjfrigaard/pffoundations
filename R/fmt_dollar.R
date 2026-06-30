#' Format Currency Values
#'
#' Format numeric values as US currency with proper symbols and comma separators.
#' Used throughout the app to display monetary amounts in a consistent,
#' human-readable format.
#'
#' @param x Numeric value to format
#' @param digits Number of decimal places (default: 2)
#'
#' @return Character string formatted as currency (e.g. "$1,234.56")
#'
#' @family utils
#'
#' @examples
#' fmt_dollar(1234.567)       # "$1,234.57"
#' fmt_dollar(1000000, digits = 0)  # "$1,000,000"
#' fmt_dollar(c(10, 20.5, 100))
#'
#' @export
fmt_dollar <- function(x, digits = 2) {
  paste0("$", formatC(x, format = "f", digits = digits, big.mark = ","))
}
