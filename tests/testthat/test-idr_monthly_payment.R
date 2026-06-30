test_that("idr_monthly_payment returns non-negative value", {
  expect_gte(idr_monthly_payment(40000, 1, "save"), 0)
})

test_that("idr_monthly_payment decreases with larger family size", {
  p1 <- idr_monthly_payment(40000, 1, "save")
  p3 <- idr_monthly_payment(40000, 3, "save")
  expect_gt(p1, p3)
})

test_that("idr_monthly_payment floors at 0 for very low income", {
  expect_equal(idr_monthly_payment(10000, 4, "save"), 0)
})
