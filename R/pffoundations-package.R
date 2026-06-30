#' @keywords internal
"_PACKAGE"

#' @import shiny
#' @importFrom stats reorder
#' @importFrom utils head read.csv
NULL

utils::globalVariables(c(
  "Category", "Amount", "Date", "Description", "Month", "Total", "Count", "Pattern", "Matches", "#",
  "balance", "apr", "strategy",
  "default_rules", "example_data", "std_categories"
))
