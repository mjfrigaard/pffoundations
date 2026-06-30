test_that("order_avalanche sorts highest APR first", {
  debts <- data.frame(
    name    = c("Student", "Car", "Card"),
    balance = c(20000, 8000, 3000),
    apr     = c(0.05, 0.06, 0.22)
  )
  result <- order_avalanche(debts)
  expect_equal(result$apr[1], 0.22)
  expect_equal(result$strategy, rep("avalanche", 3))
})
