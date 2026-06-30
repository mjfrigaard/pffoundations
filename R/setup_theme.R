#' Setup pffoundations theme and styling
#'
#' Creates a custom bslib theme with the pffoundations palette and typography.
#' Called internally by `app_ui()` to apply global theming.
#'
#' @return A `bslib::bs_theme()` object with custom variables and CSS
#'
#' @details
#' The theme defines:
#' - **Palette:** Forest (primary), Sage (success), Clay (secondary), Alert (danger)
#' - **Typography:** IBM Plex Serif for headers, IBM Plex Sans for body
#' - **Spacing:** Consistent padding and margins throughout
#' - **Interactions:** Micro-animations on value box highlights
#'
#' @examples
#' \dontrun{
#' theme <- pffoundations_theme()
#' # Use in app_ui():
#' # bslib::page_navbar(theme = theme, ...)
#' }
#'
#' @export
pffoundations_theme <- function() {
  bslib::bs_theme(
    version = 5,
    bootswatch = "flatly",
    # Primary palette colors
    primary = "#2d5016",      # Forest
    success = "#7cb342",      # Sage
    danger = "#d97748",       # Alert
    secondary = "#a1887f",    # Clay
    light = "#f5f1ed",        # Cream
    dark = "#2c3e36",         # Charcoal
    # Body text
    body_color = "#2c3e36",
    body_bg = "#f5f1ed",
    # Typography
    font_family_base = '"IBM Plex Sans", -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif',
    font_family_monospace = '"Courier New", monospace',
    heading_font_family = '"IBM Plex Serif", Georgia, serif',
    font_size_base = "0.95rem",
    line_height_base = 1.6,
    # Links
    link_color = "#2d5016",
    link_hover_color = "#7cb342",
    # Borders
    border_color = "#e5e0db"
  )
}
