#' Managing Debt module UI
#'
#' @param id Module namespace ID
#' @return A `bslib::layout_sidebar` tag object
#' @export
mod_managing_debt_ui <- function(id) {
  ns <- shiny::NS(id)
  bslib::layout_sidebar(
    sidebar = bslib::sidebar(
      shiny::h5("Loan inputs"),
      shiny::numericInput(ns("balance"), "Loan balance ($)",
        value = 10000, min = 0, step = 500),
      shiny::numericInput(ns("payment"), "Monthly payment ($)",
        value = 300, min = 1, step = 10),
      shiny::numericInput(ns("apr"), "APR (%)",
        value = 18, min = 0, max = 40, step = 0.25),
      shiny::hr(),
      shiny::h5("Income / payoff vs. invest"),
      shiny::numericInput(ns("annual_income"), "Annual income ($)",
        value = 50000, min = 1, step = 1000),
      shiny::numericInput(ns("invest_rate"), "Investment return (%)",
        value = 7, min = 0, max = 30, step = 0.5),
      shiny::numericInput(ns("years"), "Projection (years)",
        value = 10, min = 1, max = 40, step = 1),
      shiny::hr(),
      shiny::h5("DTI & utilization"),
      shiny::numericInput(ns("monthly_debt"), "Total monthly debt ($)",
        value = 1500, min = 0, step = 50),
      shiny::numericInput(ns("gross_income"), "Gross monthly income ($)",
        value = 5000, min = 1, step = 100),
      shiny::numericInput(ns("credit_used"), "Credit used ($)",
        value = 900, min = 0, step = 100),
      shiny::numericInput(ns("credit_limit"), "Credit limit ($)",
        value = 3000, min = 1, step = 100)
    ),
    bslib::navset_tab(
      bslib::nav_panel("Payoff",
        bslib::layout_columns(
          bslib::value_box("APY", shiny::textOutput(ns("apy_out")),
            showcase = bsicons::bs_icon("percent"), theme = "danger"),
          bslib::value_box("Months to payoff", shiny::textOutput(ns("months_out")),
            showcase = bsicons::bs_icon("clock"), theme = "warning"),
          bslib::value_box("Total interest", shiny::textOutput(ns("interest_out")),
            showcase = bsicons::bs_icon("cash-coin"), theme = "danger")
        )
      ),
      bslib::nav_panel("Payoff vs. Invest",
        bslib::card(shiny::verbatimTextOutput(ns("pvi_out")))
      ),
      bslib::nav_panel("Ratios",
        bslib::layout_columns(
          bslib::value_box("Loan-to-income", shiny::textOutput(ns("lir_out")),
            showcase = bsicons::bs_icon("bank"), theme = "info"),
          bslib::value_box("DTI ratio", shiny::textOutput(ns("dti_out")),
            showcase = bsicons::bs_icon("bar-chart"), theme = "info"),
          bslib::value_box("Credit utilization", shiny::textOutput(ns("util_out")),
            showcase = bsicons::bs_icon("credit-card"), theme = "info")
        )
      ),
      bslib::nav_panel("Debt Strategies",
        bslib::card(
          bslib::card_header("Avalanche order (highest APR first)"),
          reactable::reactableOutput(ns("avalanche_tbl"))
        ),
        bslib::card(
          bslib::card_header("Snowball order (lowest balance first)"),
          reactable::reactableOutput(ns("snowball_tbl"))
        )
      )
    )
  )
}

#' Managing Debt module server
#'
#' @param id Module namespace ID
#' @export
mod_managing_debt_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {

    apr_r <- shiny::reactive(input$apr / 100)

    output$apy_out <- shiny::renderText({
      fmt_pct(apr_to_apy(apr_r()) * 100)
    })

    output$months_out <- shiny::renderText({
      n <- months_to_payoff(input$balance, input$payment, apr_r())
      if (is.infinite(n)) "Never" else as.character(n)
    })

    output$interest_out <- shiny::renderText({
      i <- total_interest(input$balance, input$payment, apr_r())
      if (is.infinite(i)) "\u221e" else fmt_dollar(i, digits = 0)
    })

    output$pvi_out <- shiny::renderPrint({
      result <- payoff_vs_invest(
        input$balance, apr_r(), input$payment,
        rate  = input$invest_rate / 100,
        years = input$years
      )
      cat(sprintf("Interest saved by paying off:  %s\n",
                  fmt_dollar(result$payoff_interest_saved, digits = 0)))
      cat(sprintf("Investment future value:        %s\n",
                  fmt_dollar(result$invest_future_value, digits = 0)))
      cat(sprintf("Investment net gain:            %s\n",
                  fmt_dollar(result$invest_net_gain, digits = 0)))
      cat(sprintf("Better strategy:               %s\n",
                  toupper(result$better_strategy)))
    })

    output$lir_out <- shiny::renderText({
      fmt_pct(loan_income_ratio(input$balance, input$annual_income) * 100)
    })

    output$dti_out <- shiny::renderText({
      fmt_pct(dti_ratio(input$monthly_debt, input$gross_income) * 100)
    })

    output$util_out <- shiny::renderText({
      fmt_pct(credit_utilization(input$credit_used, input$credit_limit) * 100)
    })

    example_debts <- shiny::reactive({
      data.frame(
        name    = c("Credit Card", "Car Loan", "Student Loan"),
        balance = c(3000, 8000, 20000),
        apr     = c(0.22, 0.06, 0.05)
      )
    })

    output$avalanche_tbl <- reactable::renderReactable({
      reactable::reactable(order_avalanche(example_debts()), bordered = TRUE)
    })

    output$snowball_tbl <- reactable::renderReactable({
      reactable::reactable(order_snowball(example_debts()), bordered = TRUE)
    })
  })
}
