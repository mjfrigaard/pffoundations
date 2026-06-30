test_that("raise_invested_value returns correct future value", {
  # $3 000/yr at 7% for 1 year = $3 000
  expect_equal(raise_invested_value(60000, 0.05, 1, 0.07), 3000, tolerance = 1e-6)
})

test_that("raise_invested_value grows with more years", {
  v10 <- raise_invested_value(60000, 0.05, 10)
  v30 <- raise_invested_value(60000, 0.05, 30)
  expect_gt(v30, v10)
})

test_that("raise_invested_value is zero for zero raise", {
  expect_equal(raise_invested_value(60000, 0, 10), 0)
})
