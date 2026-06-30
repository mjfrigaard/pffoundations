#' Ratio of fixed costs to income
#'
#' Computes the share of take-home income committed to fixed (non-discretionary)
#' expenses. A ratio above 0.50 leaves little room to save or direct spending.
#'
#' @param fixed_costs Total monthly fixed costs (rent, loan payments, insurance, etc.)
#' @param income Monthly take-home income
#' @return A numeric ratio between 0 and 1 (values > 1 indicate a deficit)
#' @family income
#' @export
#' @examples
#' fixed_cost_ratio(2000, 5000)  # 0.40 — 40% of income is fixed
fixed_cost_ratio <- function(fixed_costs, income) {
  fixed_costs / income
}
