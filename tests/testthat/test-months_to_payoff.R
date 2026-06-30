test_that("months_to_payoff returns Inf when payment too low", {
  # $5 000 at 18% APR needs > $75/mo just to cover interest
  expect_equal(months_to_payoff(5000, 75, 0.18), Inf)
})

test_that("months_to_payoff returns a finite integer for valid inputs", {
  result <- months_to_payoff(5000, 200, 0.18)
  expect_true(is.finite(result))
  expect_true(result == ceiling(result))
})

test_that("months_to_payoff decreases with higher payments", {
  expect_gt(months_to_payoff(5000, 150, 0.18), months_to_payoff(5000, 300, 0.18))
})
