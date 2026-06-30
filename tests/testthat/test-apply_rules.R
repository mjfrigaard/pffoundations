test_that("apply_rules categorizes by first matching pattern", {
  df <- data.frame(
    Description = c("Netflix subscription", "Whole Foods grocery", "Unknown"),
    stringsAsFactors = FALSE
  )
  rules <- data.frame(
    Pattern  = c("netflix", "whole foods"),
    Category = c("Subscriptions", "Groceries"),
    stringsAsFactors = FALSE
  )
  result <- apply_rules(df, rules)
  expect_equal(result$Category, c("Subscriptions", "Groceries", "Other"))
})

test_that("apply_rules first match wins", {
  df <- data.frame(Description = "Netflix streaming", stringsAsFactors = FALSE)
  rules <- data.frame(
    Pattern  = c("netflix", "streaming"),
    Category = c("Subscriptions", "Entertainment"),
    stringsAsFactors = FALSE
  )
  result <- apply_rules(df, rules)
  expect_equal(result$Category, "Subscriptions")
})

test_that("apply_rules is case-insensitive", {
  df <- data.frame(Description = c("NETFLIX", "netflix", "Netflix"), stringsAsFactors = FALSE)
  rules <- data.frame(
    Pattern  = "netflix",
    Category = "Subscriptions",
    stringsAsFactors = FALSE
  )
  result <- apply_rules(df, rules)
  expect_equal(result$Category, c("Subscriptions", "Subscriptions", "Subscriptions"))
})
