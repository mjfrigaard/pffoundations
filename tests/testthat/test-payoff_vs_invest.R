test_that("payoff_vs_invest returns a named list with expected elements", {
  result <- payoff_vs_invest(10000, 0.20, 300, years = 10)
  expect_named(result, c("payoff_interest_saved", "invest_future_value",
                         "invest_net_gain", "better_strategy"))
})

test_that("payoff_vs_invest recommends payoff for high-APR debt over a short horizon", {
  # 20% APR debt over 4 years: interest saved (~$5 000) beats investment gains (~$1 800)
  result <- payoff_vs_invest(10000, 0.20, 300, rate = 0.07, years = 4)
  expect_equal(result$better_strategy, "payoff")
})

test_that("payoff_vs_invest recommends invest for low-APR debt", {
  # 3% APR debt — 7% return should win
  result <- payoff_vs_invest(10000, 0.03, 300, rate = 0.07, years = 20)
  expect_equal(result$better_strategy, "invest")
})
