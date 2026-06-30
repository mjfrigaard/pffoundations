test_that("order_snowball sorts lowest balance first", {
  debts <- data.frame(
    name    = c("Student", "Car", "Card"),
    balance = c(20000, 8000, 3000),
    apr     = c(0.05, 0.06, 0.22)
  )
  result <- order_snowball(debts)
  expect_equal(result$balance[1], 3000)
  expect_equal(result$strategy, rep("snowball", 3))
})
