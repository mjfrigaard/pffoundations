#' Budgeting module UI
#'
#' @param id Module namespace ID
#' @return A `bslib::layout_sidebar` tag object
#' @export
mod_budgeting_ui <- function(id) {
  ns <- shiny::NS(id)
  bslib::layout_sidebar(
    sidebar = bslib::sidebar(
      shiny::h5("Percent of Income"),
      shiny::numericInput(ns("expense"), "Expense ($)",
        value = 1500, min = 0, step = 50),
      shiny::numericInput(ns("income"), "Take-home income ($)",
        value = 5000, min = 1, step = 100),
      shiny::hr(),
      shiny::h5("Annualizing"),
      shiny::numericInput(ns("ann_amount"), "Amount ($)",
        value = 5, min = 0, step = 1),
      shiny::selectInput(ns("ann_period"), "Period",
        choices = c("Daily" = "daily", "Weekly" = "weekly", "Monthly" = "monthly")),
      shiny::hr(),
      shiny::h5("Break-Even"),
      shiny::numericInput(ns("upfront"), "Upfront cost ($)",
        value = 500, min = 0, step = 50),
      shiny::numericInput(ns("savings"), "Monthly savings ($)",
        value = 60, min = 0.01, step = 5)
    ),
    bslib::layout_columns(
      bslib::value_box(
        title = "Percent of income",
        value = shiny::textOutput(ns("pct_out")),
        showcase = bsicons::bs_icon("percent"),
        theme = "primary"
      ),
      bslib::value_box(
        title = "Annual equivalent",
        value = shiny::textOutput(ns("annual_out")),
        showcase = bsicons::bs_icon("calendar"),
        theme = "info"
      ),
      bslib::value_box(
        title = "Months to break even",
        value = shiny::textOutput(ns("be_out")),
        showcase = bsicons::bs_icon("arrow-left-right"),
        theme = "success"
      )
    )
  )
}

#' Budgeting module server
#'
#' @param id Module namespace ID
#' @export
mod_budgeting_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {

    output$pct_out <- shiny::renderText({
      pct <- percent_of_income(input$expense, input$income)
      fmt_pct(pct)
    })

    output$annual_out <- shiny::renderText({
      ann <- to_annual(input$ann_amount, input$ann_period)
      fmt_dollar(ann, digits = 0)
    })

    output$be_out <- shiny::renderText({
      mo <- months_to_break_even(input$upfront, input$savings)
      sprintf("%.1f months", mo)
    })
  })
}
