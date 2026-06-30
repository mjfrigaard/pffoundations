#' Apply Keyword Rules to Categorize Transactions
#'
#' Apply keyword rules in order to automatically categorize transactions.
#' Rules are matched sequentially against the Description column; the first
#' matching pattern wins. If no rule matches, the transaction receives the
#' `"Other"` category.
#'
#' This function implements the core logic for the Tracking Spending module's
#' categorization engine, allowing users to develop and refine rules for
#' organizing their transactions.
#'
#' @param df Data frame with a `Description` column (character)
#' @param rules Data frame with `Pattern` (regex, character) and `Category`
#'   (character) columns
#'
#' @return Data frame with `Category` column added. The `Category` column
#'   contains the matched rule category, or `"Other"` if no rule matched.
#'
#' @family utils
#' @family tracking_spending
#'
#' @examples
#' # Sample transactions
#' trans <- data.frame(
#'   Description = c("Netflix charge", "Grocery store", "Unknown vendor"),
#'   Amount = c(-15, -50, -25),
#'   stringsAsFactors = FALSE
#' )
#'
#' # Sample rules
#' rules <- data.frame(
#'   Pattern = c("Netflix|Hulu|Spotify", "Safeway|Whole Foods"),
#'   Category = c("Subscriptions", "Groceries"),
#'   stringsAsFactors = FALSE
#' )
#'
#' # Apply rules
#' apply_rules(trans, rules)
#'
#' @export
apply_rules <- function(df, rules) {
  df$Category <- "Other"
  for (i in seq_len(nrow(rules))) {
    unmatched <- df$Category == "Other"
    hits <- grepl(rules$Pattern[i], df$Description, ignore.case = TRUE) & unmatched
    df$Category[hits] <- rules$Category[i]
  }
  df
}
