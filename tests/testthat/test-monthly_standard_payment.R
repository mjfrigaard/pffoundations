test_that("monthly_standard_payment for zero APR is principal / months", {
  expect_equal(monthly_standard_payment(12000, 0, 12), 1000)
})

test_that("monthly_standard_payment * n_months >= principal", {
  pmt <- monthly_standard_payment(30000, 0.065, 120)
  expect_gte(pmt * 120, 30000)
})

test_that("monthly_standard_payment decreases with longer term", {
  pmt_10yr <- monthly_standard_payment(30000, 0.065, 120)
  pmt_20yr <- monthly_standard_payment(30000, 0.065, 240)
  expect_gt(pmt_10yr, pmt_20yr)
})
