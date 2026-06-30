#' Launch the pffoundations application
#'
#' @param ... Arguments passed to [shiny::shinyApp()]
#' @return A `shiny.appobj`
#' @export
#' @examples
#' if (interactive()) {
#'   launch_app()
#' }
launch_app <- function(...) {
  thematic::thematic_shiny()
  shiny::shinyApp(ui = app_ui(), server = app_server, ...)
}
