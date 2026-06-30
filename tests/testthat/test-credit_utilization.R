test_that("credit_utilization computes correctly", {
  expect_equal(credit_utilization(900, 3000), 0.3)
  expect_equal(credit_utilization(0, 3000), 0)
  expect_equal(credit_utilization(3000, 3000), 1)
})
