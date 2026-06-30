#' Emergency Fund module UI
#'
#' @param id Module namespace ID
#' @return A `bslib::layout_sidebar` tag object
#' @export
mod_emergency_fund_ui <- function(id) {
  ns <- shiny::NS(id)
  bslib::layout_sidebar(
    sidebar = bslib::sidebar(
      shiny::numericInput(ns("expenses"), "Monthly expenses ($)",
        value = 3000, min = 0, step = 100),
      shiny::numericInput(ns("months_cover"), "Months of coverage",
        value = 6, min = 1, max = 12, step = 1),
      shiny::hr(),
      shiny::numericInput(ns("current"), "Current savings ($)",
        value = 2000, min = 0, step = 500),
      shiny::numericInput(ns("contribution"), "Monthly contribution ($)",
        value = 300, min = 1, step = 50),
      shiny::hr(),
      shiny::numericInput(ns("rate"), "HYSA rate (%)",
        value = 4.5, min = 0, max = 10, step = 0.1)
    ),
    bslib::layout_columns(
      bslib::value_box(
        title = "Target",
        value = shiny::textOutput(ns("target_out")),
        showcase = bsicons::bs_icon("shield-check"),
        theme = "success"
      ),
      bslib::value_box(
        title = "Months to goal",
        value = shiny::textOutput(ns("months_out")),
        showcase = bsicons::bs_icon("calendar-check"),
        theme = "info"
      ),
      bslib::value_box(
        title = "Needed per month",
        value = shiny::textOutput(ns("needed_out")),
        showcase = bsicons::bs_icon("piggy-bank"),
        theme = "warning"
      ),
      bslib::value_box(
        title = "HYSA value at goal",
        value = shiny::textOutput(ns("growth_out")),
        showcase = bsicons::bs_icon("bank"),
        theme = "primary"
      )
    )
  )
}

#' Emergency Fund module server
#'
#' @param id Module namespace ID
#' @export
mod_emergency_fund_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {

    target <- shiny::reactive({
      emergency_fund_target(input$expenses, input$months_cover)
    })

    output$target_out <- shiny::renderText({
      fmt_dollar(target(), digits = 0)
    })

    output$months_out <- shiny::renderText({
      n <- months_to_ef_goal(target(), input$current, input$contribution)
      as.character(n)
    })

    output$needed_out <- shiny::renderText({
      n_months <- months_to_ef_goal(target(), input$current, input$contribution)
      if (n_months == 0) return(fmt_dollar(0))
      needed <- monthly_contribution_needed(target(), input$current, n_months)
      fmt_dollar(needed)
    })

    output$growth_out <- shiny::renderText({
      n_months <- months_to_ef_goal(target(), input$current, input$contribution)
      if (n_months == 0) return(fmt_dollar(target()))
      fv <- ef_growth(input$contribution, n_months, input$rate / 100)
      fmt_dollar(fv, digits = 0)
    })
  })
}
