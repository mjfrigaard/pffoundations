#' Default transaction categorization rules
#'
#' A set of keyword-based rules used by `apply_rules()` to automatically
#' assign categories to transaction descriptions. Rules are applied in order;
#' the first matching pattern wins. Unmatched transactions receive `"Other"`.
#'
#' @format A data frame with 13 rows and 2 columns:
#' \describe{
#'   \item{Pattern}{Case-insensitive regular expression matched against the
#'     transaction `Description` field.}
#'   \item{Category}{Category label assigned when the pattern matches (one of
#'     the values in [std_categories]).}
#' }
#' @seealso [std_categories], [example_data]
#' @family tracking_spending
"default_rules"


#' Standard transaction category names
#'
#' A character vector of the 14 category labels used throughout the app,
#' including `"Other"` for transactions that do not match any rule in
#' [default_rules].
#'
#' @format A character vector of length 14.
#' @seealso [default_rules], [example_data]
#' @family tracking_spending
"std_categories"


#' Example transaction data
#'
#' A small sample of 17 transactions covering a single month, suitable for
#' exploring the Tracking Spending module without uploading a real CSV file.
#' Pass to `apply_rules()` with [default_rules] to see automatic categorisation.
#'
#' @format A data frame with 17 rows and 3 columns:
#' \describe{
#'   \item{Date}{Transaction date (`Date` class).}
#'   \item{Description}{Merchant or payee name (`character`).}
#'   \item{Amount}{Transaction amount in dollars (`numeric`). Positive values
#'     are income; negative values are expenses.}
#' }
#' @seealso [default_rules], [std_categories]
#' @family tracking_spending
"example_data"
