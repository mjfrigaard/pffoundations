#' Income module UI
#'
#' @param id Module namespace ID
#' @return A `bslib::layout_sidebar` tag object
#' @export
mod_income_ui <- function(id) {
  ns <- shiny::NS(id)
  bslib::layout_sidebar(
    sidebar = bslib::sidebar(
      shiny::h5("Fixed Cost Ratio", class = "fw-bold"),
      shiny::helpText("What percentage of your take-home income goes to fixed expenses?"),
      shiny::numericInput(ns("fixed_costs"), "Monthly fixed costs ($)",
        value = 2000, min = 0, step = 100),
      shiny::numericInput(ns("income"), "Monthly take-home income ($)",
        value = 5000, min = 1, step = 100),
      shiny::hr(),
      shiny::h5("Raise Opportunity", class = "fw-bold"),
      shiny::helpText("Compare: Save your raise vs. invest it at market returns."),
      shiny::numericInput(ns("current_income"), "Current annual income ($)",
        value = 60000, min = 0, step = 1000),
      shiny::numericInput(ns("raise_pct"), "Expected raise (%)",
        value = 5, min = 0, max = 100, step = 0.5),
      shiny::numericInput(ns("years"), "Investment horizon (years)",
        value = 10, min = 1, max = 50, step = 1),
      shiny::numericInput(ns("rate"), "Expected annual return (%)",
        value = 7, min = 0, max = 30, step = 0.5)
    ),
    bslib::layout_columns(
      bslib::value_box(
        title = "Fixed cost ratio",
        value = shiny::textOutput(ns("ratio_out")),
        showcase = bsicons::bs_icon("house"),
        theme  = "primary"
      ),
      bslib::value_box(
        title = "Future value of raise",
        value = shiny::textOutput(ns("raise_out")),
        subtitle = "if invested annually",
        showcase = bsicons::bs_icon("graph-up-arrow"),
        theme  = "success"
      )
    )
  )
}

#' Income module server
#'
#' @param id Module namespace ID
#' @export
mod_income_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {

    output$ratio_out <- shiny::renderText({
      ratio <- fixed_cost_ratio(input$fixed_costs, input$income)
      fmt_pct(ratio * 100)
    })

    output$raise_out <- shiny::renderText({
      fv <- raise_invested_value(
        input$current_income,
        input$raise_pct / 100,
        input$years,
        input$rate / 100
      )
      fmt_dollar(fv, digits = 0)
    })
  })
}
