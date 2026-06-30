test_that("emergency_fund_target uses 6-month default", {
  expect_equal(emergency_fund_target(3000), 18000)
})

test_that("emergency_fund_target respects custom months", {
  expect_equal(emergency_fund_target(3000, 3), 9000)
})
