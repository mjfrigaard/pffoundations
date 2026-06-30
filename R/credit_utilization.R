#' Credit utilization ratio
#'
#' The fraction of available revolving credit currently in use. Scores above
#' 0.30 (30%) typically begin to negatively affect credit scores.
#'
#' @param used Total revolving balance currently owed
#' @param limit Total revolving credit limit
#' @return Utilization ratio as a decimal
#' @family managing_debt
#' @export
#' @examples
#' credit_utilization(900, 3000)   # 0.30 — at the recommended ceiling
#' credit_utilization(2700, 3000)  # 0.90 — high utilization
credit_utilization <- function(used, limit) {
  used / limit
}
