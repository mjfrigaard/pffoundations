test_that("to_monthly is inverse of to_annual for monthly", {
  expect_equal(to_monthly(to_annual(500, "monthly"), "monthly"), 500)
})

test_that("to_monthly is inverse of to_annual for weekly", {
  expect_equal(to_monthly(to_annual(100, "weekly"), "weekly"), 100)
})

test_that("to_monthly is inverse of to_annual for daily", {
  expect_equal(to_monthly(to_annual(5, "daily"), "daily"), 5)
})
