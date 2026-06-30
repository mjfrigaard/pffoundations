test_that("subscription_opportunity_cost computes future value correctly", {
  # $12/yr at 7% for 1 year = $12
  expect_equal(
    subscription_opportunity_cost(1, 1, 0.07),
    12,
    tolerance = 1e-6
  )
})

test_that("subscription_opportunity_cost grows with time", {
  v10 <- subscription_opportunity_cost(15, 10)
  v30 <- subscription_opportunity_cost(15, 30)
  expect_gt(v30, v10)
})

test_that("subscription_opportunity_cost is zero for zero cost", {
  expect_equal(subscription_opportunity_cost(0, 10), 0)
})
