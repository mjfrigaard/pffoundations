test_that("fixed_cost_ratio computes correctly", {
  expect_equal(fixed_cost_ratio(2000, 5000), 0.4)
  expect_equal(fixed_cost_ratio(5000, 5000), 1.0)
  expect_equal(fixed_cost_ratio(0, 5000), 0)
})

test_that("fixed_cost_ratio can exceed 1 (deficit)", {
  expect_gt(fixed_cost_ratio(6000, 5000), 1)
})
