test_that("loan_income_ratio computes correctly", {
  expect_equal(loan_income_ratio(45000, 50000), 0.9)
  expect_equal(loan_income_ratio(50000, 50000), 1.0)
})

test_that("loan_income_ratio > 1 for debt exceeding income", {
  expect_gt(loan_income_ratio(80000, 50000), 1)
})
