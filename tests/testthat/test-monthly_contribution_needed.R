test_that("monthly_contribution_needed computes correctly", {
  expect_equal(monthly_contribution_needed(18000, 3000, 30), 500)
})

test_that("monthly_contribution_needed is 0 when already at target", {
  expect_equal(monthly_contribution_needed(18000, 18000, 12), 0)
})
