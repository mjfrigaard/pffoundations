#' Custom head tags for pffoundations app
#'
#' Adds Google Fonts (IBM Plex) and custom CSS to the app head.
#'
#' @return A `shiny::tags$head()` containing font imports and custom styles
#' @noRd
pffoundations_head <- function() {
  shiny::tags$head(
    # Import IBM Plex fonts from Google Fonts
    shiny::tags$link(
      href = "https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@400;500;600&family=IBM+Plex+Serif:wght@400;600&display=swap",
      rel = "stylesheet"
    ),
    # Custom CSS
    shiny::tags$style(shiny::HTML("
      :root {
        --pff-forest: #2d5016;
        --pff-sage: #7cb342;
        --pff-clay: #a1887f;
        --pff-cream: #f5f1ed;
        --pff-charcoal: #2c3e36;
        --pff-alert: #d97748;
      }

      /* Typography */
      body {
        font-family: 'IBM Plex Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
        font-size: 0.95rem;
        line-height: 1.6;
        color: var(--pff-charcoal);
        background-color: var(--pff-cream);
      }

      h1, h2, h3, h4, h5, h6, .navbar-brand {
        font-family: 'IBM Plex Serif', Georgia, serif;
        font-weight: bold;
        color: var(--pff-charcoal);
      }

      code, .formula, kbd {
        font-family: 'Courier New', monospace;
        font-size: 0.9em;
      }

      /* Help text */
      .help-text, .form-text {
        font-size: 0.85rem;
        color: var(--pff-sage);
      }

      /* Input focus */
      .form-control:focus, .form-select:focus, input[type='number']:focus, select:focus {
        border-color: var(--pff-forest);
        box-shadow: 0 0 0 0.2rem rgba(45, 80, 22, 0.25);
        outline: none;
      }

      /* Value boxes */
      .bslib-value-box {
        border: none;
        border-radius: 0.5rem;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
        padding: 1.5rem;
        background: white;
        transition: background-color 0.2s ease;
      }

      .bslib-value-box .bslib-value-box-title {
        font-size: 0.85rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        color: var(--pff-sage);
        margin-bottom: 0.5rem;
      }

      .bslib-value-box .bslib-value-box-value {
        font-size: 1.75rem;
        font-weight: bold;
        color: var(--pff-charcoal);
      }

      /* Cards */
      .bslib-card {
        border: 1px solid #e5e0db;
        border-radius: 0.5rem;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
      }

      .bslib-card .card-header {
        background-color: var(--pff-cream);
        border-bottom: 2px solid var(--pff-forest);
        font-family: 'IBM Plex Serif', Georgia, serif;
        font-weight: bold;
        color: var(--pff-forest);
      }

      /* Navbar */
      .navbar {
        background-color: var(--pff-forest) !important;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }

      .navbar-brand {
        font-size: 1.5rem;
        font-weight: bold;
        color: white !important;
      }

      .nav-link {
        color: rgba(255, 255, 255, 0.85) !important;
        font-weight: 500;
        transition: color 0.2s ease;
      }

      .nav-link:hover {
        color: var(--pff-sage) !important;
      }

      .nav-link.active {
        color: var(--pff-sage) !important;
        border-bottom: 3px solid var(--pff-sage);
      }

      /* Buttons */
      .btn-primary {
        background-color: var(--pff-forest);
        border-color: var(--pff-forest);
        font-weight: 600;
      }

      .btn-primary:hover {
        background-color: #1e3a0f;
        border-color: #1e3a0f;
      }

      .btn-primary:focus {
        box-shadow: 0 0 0 0.2rem rgba(45, 80, 22, 0.5);
      }

      .btn-success {
        background-color: var(--pff-sage);
        border-color: var(--pff-sage);
      }

      .btn-danger {
        background-color: var(--pff-alert);
        border-color: var(--pff-alert);
      }

      .btn-outline-secondary {
        color: var(--pff-clay);
        border-color: var(--pff-clay);
      }

      .btn-outline-secondary:hover {
        background-color: var(--pff-clay);
        color: white;
        border-color: var(--pff-clay);
      }

      /* Tabs */
      .nav-tabs {
        border-bottom: 2px solid #e5e0db;
      }

      .nav-tabs .nav-link {
        color: var(--pff-charcoal);
        border: none;
        border-bottom: 3px solid transparent;
        font-weight: 500;
      }

      .nav-tabs .nav-link:hover {
        color: var(--pff-forest);
        border-bottom-color: var(--pff-sage);
      }

      .nav-tabs .nav-link.active {
        color: var(--pff-forest);
        border-bottom-color: var(--pff-forest);
        background-color: transparent;
      }

      /* Tables */
      table th {
        background-color: var(--pff-cream);
        color: var(--pff-forest);
        font-weight: 600;
        border-bottom: 2px solid var(--pff-forest);
      }

      table td {
        color: var(--pff-charcoal);
        border-bottom: 1px solid #e5e0db;
      }

      tr:hover {
        background-color: rgba(124, 179, 66, 0.05);
      }

      /* Alerts */
      .alert {
        border: none;
        border-left: 4px solid;
      }

      .alert-warning {
        background-color: rgba(217, 119, 72, 0.1);
        border-left-color: var(--pff-alert);
        color: var(--pff-charcoal);
      }

      .alert-info {
        background-color: rgba(124, 179, 66, 0.1);
        border-left-color: var(--pff-sage);
        color: var(--pff-charcoal);
      }

      /* Calculation highlight animation */
      @keyframes calc-pulse {
        0% { background-color: white; }
        50% { background-color: var(--pff-sage); }
        100% { background-color: white; }
      }

      .value-box-highlight {
        animation: calc-pulse 0.4s ease-in-out;
      }

      /* Responsive */
      @media (max-width: 768px) {
        .bslib-sidebar {
          margin-bottom: 1.5rem;
          border-right: none;
          border-bottom: 1px solid #e5e0db;
        }
      }
    "))
  )
}
