#' Tracking Spending Module UI
#'
#' UI function for the Tracking Spending chapter. Provides an integrated interface
#' across five sub-views: Transactions (upload & overview), Categorize (manage rules),
#' By Category (summary visualizations), Monthly Trends (time series), and
#' Subscriptions (opportunity cost calculation).
#'
#' @param id Module ID
#'
#' @return A [shiny::tagList()] containing the module UI
#' @noRd
mod_tracking_spending_ui <- function(id) {
  ns <- shiny::NS(id)

  bslib::navset_card_tab(
    title = NULL,
    id = ns("tracking_tabs"),

    # TAB 1: Transactions
    bslib::nav_panel(
      "Transactions",
      bslib::layout_sidebar(
        sidebar = bslib::sidebar(
          shiny::fileInput(ns("file"), "Upload bank statement (CSV)",
                    accept      = ".csv",
                    placeholder = "Using chapter example"),
          shiny::helpText("CSV must include: Date, Description, Amount columns."),
          shiny::hr(),
          shiny::uiOutput(ns("date_filter_ui")),
          shiny::uiOutput(ns("category_filter_ui"))
        ),
        bslib::layout_column_wrap(
          width = 1/3,
          fill  = FALSE,
          bslib::value_box(
            title    = "Income",
            value    = shiny::textOutput(ns("total_income")),
            theme    = "success",
            showcase = bsicons::bs_icon("arrow-up-circle")
          ),
          bslib::value_box(
            title    = "Spending",
            value    = shiny::textOutput(ns("total_spending")),
            theme    = "danger",
            showcase = bsicons::bs_icon("arrow-down-circle")
          ),
          bslib::value_box(
            title    = "Net",
            value    = shiny::textOutput(ns("net")),
            theme    = "primary",
            showcase = bsicons::bs_icon("wallet2")
          )
        ),
        bslib::card(
          full_screen = TRUE,
          bslib::card_header("Transactions"),
          DT::DTOutput(ns("transactions_table"))
        )
      )
    ),

    # TAB 2: Categorize
    bslib::nav_panel(
      "Categorize",
      bslib::layout_sidebar(
        sidebar = bslib::sidebar(
          shiny::tags$h6("Add rule"),
          shiny::helpText("Rules apply top-to-bottom; first match wins."),
          shiny::textInput(ns("new_pattern"), "Keyword pattern",
                    placeholder = "e.g. Uber|Lyft|Waymo"),
          shiny::selectizeInput(ns("new_category"), "Category",
                         choices  = std_categories,
                         selected = NULL,
                         options  = list(create = TRUE, placeholder = "Select or type...")),
          shiny::actionButton(ns("add_rule"), "Add rule",
                       icon  = shiny::icon("plus"),
                       class = "btn-primary btn-sm w-100"),
          shiny::hr(),
          shiny::tags$h6("Remove rule"),
          shiny::helpText("Select a row in the rules table, then click Remove."),
          shiny::actionButton(ns("remove_rule"), "Remove selected rule",
                       icon  = shiny::icon("trash"),
                       class = "btn-danger btn-sm w-100"),
          shiny::hr(),
          shiny::actionButton(ns("reset_rules"), "Reset to defaults",
                       icon  = shiny::icon("rotate-left"),
                       class = "btn-outline-secondary btn-sm w-100"),
          shiny::hr(),
          shiny::uiOutput(ns("other_count_ui"))
        ),
        bslib::layout_column_wrap(
          width = 1/2,
          bslib::card(
            full_screen = TRUE,
            bslib::card_header("Keyword rules"),
            DT::DTOutput(ns("rules_table"))
          ),
          bslib::card(
            full_screen = TRUE,
            bslib::card_header(
              "Uncategorized descriptions",
              bslib::tooltip(
                bsicons::bs_icon("info-circle", title = "About uncategorized"),
                "Transactions not matched by any rule. Add rules to the left to capture them."
              )
            ),
            DT::DTOutput(ns("other_table"))
          )
        )
      )
    ),

    # TAB 3: By Category
    bslib::nav_panel(
      "By Category",
      bslib::layout_sidebar(
        sidebar = bslib::sidebar(
          shiny::checkboxInput(ns("exclude_income_cat"),    "Exclude income",    value = TRUE),
          shiny::checkboxInput(ns("exclude_transfers_cat"), "Exclude transfers", value = TRUE)
        ),
        bslib::layout_column_wrap(
          width = 1/2,
          bslib::card(
            full_screen = TRUE,
            bslib::card_header("Spending by category"),
            shiny::plotOutput(ns("category_plot"))
          ),
          bslib::card(
            full_screen = TRUE,
            bslib::card_header("Category totals"),
            DT::DTOutput(ns("category_table"))
          )
        )
      )
    ),

    # TAB 4: Monthly Trends
    bslib::nav_panel(
      "Trends",
      bslib::layout_sidebar(
        sidebar = bslib::sidebar(
          shiny::uiOutput(ns("trend_category_ui"))
        ),
        bslib::card(
          full_screen = TRUE,
          bslib::card_header("Monthly spending by category"),
          shiny::plotOutput(ns("trend_plot"), height = "450px")
        )
      )
    ),

    # TAB 5: Subscriptions
    bslib::nav_panel(
      "Subscriptions",
      bslib::layout_sidebar(
        sidebar = bslib::sidebar(
          shiny::tags$h6("Opportunity cost calculator"),
          shiny::numericInput(ns("sub_cost"),  "Monthly cost ($)",  value = 20, min = 0.01, step = 1),
          shiny::numericInput(ns("sub_years"), "Years",             value = 30, min = 1, max = 50, step = 1),
          shiny::numericInput(ns("sub_rate"),  "Annual return (%)", value = 7,  min = 0, max = 30, step = 0.5)
        ),
        bslib::layout_column_wrap(
          width = 1/2,
          fill  = FALSE,
          bslib::value_box(
            title    = "Avg monthly subscriptions",
            value    = shiny::textOutput(ns("sub_monthly_total")),
            theme    = "warning",
            showcase = bsicons::bs_icon("repeat")
          ),
          bslib::value_box(
            title    = "Opportunity cost",
            value    = shiny::textOutput(ns("sub_opp_cost")),
            theme    = "danger",
            showcase = bsicons::bs_icon("graph-up-arrow")
          )
        ),
        bslib::card(
          full_screen = TRUE,
          bslib::card_header("Subscription transactions"),
          DT::DTOutput(ns("sub_table"))
        )
      )
    )
  )
}

#' Tracking Spending Module Server
#'
#' Server function for the Tracking Spending chapter. Coordinates reactive state
#' across all five sub-views: file upload, rule management, data filtering,
#' categorization, and opportunity cost calculation.
#'
#' @param id Module ID
#'
#' @return NULL (no return value)
#' @noRd
mod_tracking_spending_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {

    # ========== Shared Reactives ==========

    # Load uploaded CSV or fall back to example data
    raw_data <- shiny::reactive({
      if (!is.null(input$file)) {
        df <- read.csv(input$file$datapath, stringsAsFactors = FALSE)
        df$Date <- as.Date(df$Date)
        df |> dplyr::select(Date, Description, Amount)
      } else {
        example_data
      }
    })

    # Editable rule set — starts with defaults
    rules <- shiny::reactiveVal(default_rules)

    # Apply current rules to produce categorized data
    categorized_data <- shiny::reactive({
      apply_rules(raw_data(), rules())
    })

    # Apply date and category filters
    filtered_data <- shiny::reactive({
      df <- categorized_data()
      if (!is.null(input$date_range)) {
        df <- df |> dplyr::filter(Date >= input$date_range[1], Date <= input$date_range[2])
      }
      if (!is.null(input$selected_categories) && length(input$selected_categories) > 0) {
        df <- df |> dplyr::filter(Category %in% input$selected_categories)
      }
      df
    })

    # ========== TAB 1: TRANSACTIONS ==========

    # Dynamic date range filter UI
    output$date_filter_ui <- shiny::renderUI({
      df <- categorized_data()
      shiny::dateRangeInput(session$ns("date_range"), "Date range",
                     start = min(df$Date),
                     end   = max(df$Date),
                     min   = min(df$Date),
                     max   = max(df$Date))
    })

    # Dynamic category filter UI
    output$category_filter_ui <- shiny::renderUI({
      cats <- sort(unique(categorized_data()$Category))
      shiny::checkboxGroupInput(session$ns("selected_categories"), "Categories",
                         choices  = cats,
                         selected = cats)
    })

    # Value box: total income
    output$total_income <- shiny::renderText({
      x <- filtered_data()$Amount
      fmt_dollar(sum(x[x > 0], na.rm = TRUE))
    })

    # Value box: total spending
    output$total_spending <- shiny::renderText({
      x <- filtered_data()$Amount
      fmt_dollar(abs(sum(x[x < 0], na.rm = TRUE)))
    })

    # Value box: net
    output$net <- shiny::renderText({
      fmt_dollar(sum(filtered_data()$Amount, na.rm = TRUE))
    })

    # Transactions table
    output$transactions_table <- reactable::renderReactable({
      filtered_data() |>
        dplyr::arrange(dplyr::desc(Date)) |>
        dplyr::mutate(
          Amount = paste0(
            ifelse(Amount >= 0, "+$", "-$"),
            formatC(abs(Amount), format = "f", digits = 2, big.mark = ",")
          )
        ) |>
        reactable::reactable(pagination = FALSE, bordered = TRUE)
    })

    # ========== TAB 2: CATEGORIZE ==========

    # Rules table: show Pattern, Category, and raw match count
    output$rules_table <- reactable::renderReactable({
      r   <- rules()
      df  <- raw_data()
      counts <- vapply(r$Pattern, function(p) {
        sum(grepl(p, df$Description, ignore.case = TRUE))
      }, integer(1))
      r |>
        dplyr::mutate(`#` = seq_len(nrow(r)), Matches = counts) |>
        dplyr::select(`#`, Pattern, Category, Matches) |>
        reactable::reactable(
          selection = "single",
          compact = TRUE,
          bordered = TRUE
        )
    })

    # Preview of uncategorized descriptions
    output$other_table <- reactable::renderReactable({
      categorized_data() |>
        dplyr::filter(Category == "Other") |>
        dplyr::count(Description, name = "Transactions", sort = TRUE) |>
        reactable::reactable(
          pagination = FALSE,
          bordered = TRUE
        )
    })

    # "Other" transaction count badge in sidebar
    output$other_count_ui <- shiny::renderUI({
      n_other <- sum(categorized_data()$Category == "Other")
      n_total <- nrow(categorized_data())
      pct     <- round(100 * n_other / n_total)
      color   <- if (pct > 25) "danger" else if (pct > 5) "warning" else "success"
      bslib::value_box(
        title    = "Uncategorized",
        value    = paste0(n_other, " (", pct, "%)"),
        theme    = color,
        showcase = bsicons::bs_icon("question-circle"),
        shiny::p(paste(n_total - n_other, "of", n_total, "transactions matched"))
      )
    })

    # Add rule
    shiny::observeEvent(input$add_rule, {
      pat <- trimws(input$new_pattern)
      cat <- trimws(input$new_category)
      shiny::req(nchar(pat) > 0, nchar(cat) > 0)
      rules(dplyr::bind_rows(rules(), tibble::tibble(Pattern = pat, Category = cat)))
      shiny::updateTextInput(session, "new_pattern", value = "")
      shiny::updateSelectizeInput(session, "new_category", selected = character(0))
    })

    # Remove selected rule
    shiny::observeEvent(input$remove_rule, {
      sel <- input$rules_table_rows_selected
      shiny::req(length(sel) > 0)
      r <- rules()
      rules(r[-sel, ])
    })

    # Reset to defaults
    shiny::observeEvent(input$reset_rules, {
      rules(default_rules)
    })

    # ========== TAB 3: BY CATEGORY ==========

    # Aggregate spending by category
    category_summary <- shiny::reactive({
      df <- categorized_data()
      if (isTRUE(input$exclude_income_cat))    df <- df |> dplyr::filter(Category != "Income")
      if (isTRUE(input$exclude_transfers_cat)) df <- df |> dplyr::filter(Category != "Transfers")
      df |>
        dplyr::filter(Amount < 0) |>
        dplyr::group_by(Category) |>
        dplyr::summarise(Total = abs(sum(Amount, na.rm = TRUE)), Count = dplyr::n(), .groups = "drop") |>
        dplyr::arrange(dplyr::desc(Total))
    })

    # Bar chart of spending by category
    output$category_plot <- shiny::renderPlot({
      df <- category_summary()
      ggplot2::ggplot(df, ggplot2::aes(x = Total, y = reorder(Category, Total))) +
        ggplot2::geom_col(fill = "#2c9c6a") +
        ggplot2::geom_text(
          ggplot2::aes(label = paste0("$", formatC(round(Total), format = "d", big.mark = ","))),
          hjust = -0.1, size = 3.5
        ) +
        ggplot2::scale_x_continuous(
          labels = function(x) paste0("$", formatC(x, format = "d", big.mark = ",")),
          expand = ggplot2::expansion(mult = c(0, 0.25))
        ) +
        ggplot2::labs(x = "Total spent", y = NULL) +
        ggplot2::theme_minimal(base_size = 13) +
        ggplot2::theme(panel.grid.major.y = ggplot2::element_blank())
    })

    # Category summary table
    output$category_table <- reactable::renderReactable({
      category_summary() |>
        dplyr::mutate(
          Total = paste0("$", formatC(round(Total, 2), format = "f", digits = 2, big.mark = ","))
        ) |>
        dplyr::rename("Total Spent" = Total, Transactions = Count) |>
        reactable::reactable(bordered = TRUE)
    })

    # ========== TAB 4: MONTHLY TRENDS ==========

    # Dynamic category selection (exclude Income and Transfers by default)
    output$trend_category_ui <- shiny::renderUI({
      cats     <- sort(unique(categorized_data()$Category))
      cats_exp <- cats[!cats %in% c("Income", "Transfers")]
      shiny::checkboxGroupInput(session$ns("trend_categories"), "Show categories",
                         choices  = cats_exp,
                         selected = head(cats_exp, 5))
    })

    # Line chart of monthly spending by category
    output$trend_plot <- shiny::renderPlot({
      shiny::req(input$trend_categories)
      df <- categorized_data() |>
        dplyr::filter(Amount < 0, Category %in% input$trend_categories) |>
        dplyr::mutate(Month = format(Date, "%Y-%m")) |>
        dplyr::group_by(Month, Category) |>
        dplyr::summarise(Total = abs(sum(Amount, na.rm = TRUE)), .groups = "drop")

      shiny::validate(shiny::need(nrow(df) > 0, "No data for selected categories."))

      ggplot2::ggplot(df, ggplot2::aes(x = Month, y = Total, color = Category, group = Category)) +
        ggplot2::geom_line(linewidth = 1) +
        ggplot2::geom_point(size = 2.5) +
        ggplot2::scale_y_continuous(
          labels = function(x) paste0("$", formatC(x, format = "d", big.mark = ","))
        ) +
        ggplot2::labs(x = NULL, y = "Monthly spending", color = NULL) +
        ggplot2::theme_minimal(base_size = 13) +
        ggplot2::theme(
          axis.text.x     = ggplot2::element_text(angle = 45, hjust = 1),
          legend.position = "top"
        )
    })

    # ========== TAB 5: SUBSCRIPTIONS ==========

    # Average monthly subscription spending
    output$sub_monthly_total <- shiny::renderText({
      df <- categorized_data() |>
        dplyr::filter(Category == "Subscriptions", Amount < 0) |>
        dplyr::mutate(Month = format(Date, "%Y-%m")) |>
        dplyr::group_by(Month) |>
        dplyr::summarise(Total = abs(sum(Amount, na.rm = TRUE)), .groups = "drop")
      if (nrow(df) == 0) return("$0.00")
      fmt_dollar(mean(df$Total, na.rm = TRUE))
    })

    # Opportunity cost calculation
    output$sub_opp_cost <- shiny::renderText({
      opp <- subscription_opportunity_cost(
        monthly_cost = input$sub_cost,
        years        = input$sub_years,
        rate         = input$sub_rate / 100
      )
      fmt_dollar(opp)
    })

    # Subscription transactions table
    output$sub_table <- reactable::renderReactable({
      categorized_data() |>
        dplyr::filter(Category == "Subscriptions", Amount < 0) |>
        dplyr::arrange(Description, Date) |>
        dplyr::mutate(
          Amount = paste0("-$", formatC(abs(Amount), format = "f", digits = 2, big.mark = ","))
        ) |>
        reactable::reactable(pagination = FALSE, bordered = TRUE)
    })
  })
}
