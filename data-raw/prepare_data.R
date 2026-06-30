# Prepare package data objects for pffoundations
# Run once with: source("data-raw/prepare_data.R")

# ── default_rules ────────────────────────────────────────────────────────────
# Keyword rules for auto-categorising transactions.
# Pattern (regex, case-insensitive) → Category
default_rules <- data.frame(
  Pattern  = c(
    "payroll|direct dep|salary",
    "rent|mortgage|hoa",
    "grocery|whole foods|trader joe|kroger|safeway|aldi",
    "netflix|hulu|spotify|disney|prime|apple.*sub|youtube premium",
    "uber|lyft|taxi|transit|subway|mta|bart",
    "electric|gas|water|utility|pge|con ed",
    "insurance|geico|progressive|allstate|aetna",
    "restaurant|doordash|grubhub|seamless|chipotle|starbucks",
    "amazon|walmart|target|costco",
    "gym|planet fitness|24 hour",
    "student loan|sallie mae|mohela|nelnet",
    "chase|wells fargo|boa|citi|venmo|zelle|transfer",
    "doctor|pharmacy|cvs|walgreens|medical|dental"
  ),
  Category = c(
    "Income",
    "Housing",
    "Groceries",
    "Subscriptions",
    "Transportation",
    "Utilities",
    "Insurance",
    "Dining",
    "Shopping",
    "Health & Fitness",
    "Student Loans",
    "Transfers",
    "Healthcare"
  ),
  stringsAsFactors = FALSE
)

# ── std_categories ────────────────────────────────────────────────────────────
std_categories <- c(
  "Income", "Housing", "Groceries", "Subscriptions", "Transportation",
  "Utilities", "Insurance", "Dining", "Shopping", "Health & Fitness",
  "Student Loans", "Transfers", "Healthcare", "Other"
)

# ── example_data ──────────────────────────────────────────────────────────────
example_data <- data.frame(
  Date        = as.Date(c(
    "2026-06-01", "2026-06-02", "2026-06-03", "2026-06-04", "2026-06-05",
    "2026-06-07", "2026-06-10", "2026-06-12", "2026-06-14", "2026-06-15",
    "2026-06-17", "2026-06-18", "2026-06-20", "2026-06-22", "2026-06-25",
    "2026-06-26", "2026-06-28"
  )),
  Description = c(
    "Employer Payroll Direct Dep",
    "Rent ACH Transfer",
    "Whole Foods Market",
    "Netflix Monthly",
    "Uber Trip",
    "PGE Electric Bill",
    "Starbucks",
    "Amazon Purchase",
    "Planet Fitness Monthly",
    "Mohela Student Loan",
    "Trader Joes",
    "Spotify Premium",
    "Chipotle",
    "Walgreens Pharmacy",
    "Target",
    "Lyft Trip",
    "Chase Credit Card Transfer"
  ),
  Amount      = c(
     3200.00, -1400.00,  -112.45,   -15.99,   -18.50,
     -85.00,   -6.75,   -43.20,    -24.99,  -250.00,
     -67.30,   -9.99,   -13.50,    -22.00,   -58.90,
     -12.00,  -500.00
  ),
  stringsAsFactors = FALSE
)

# ── save to data/ ─────────────────────────────────────────────────────────────
usethis::use_data(default_rules, std_categories, example_data, overwrite = TRUE)
