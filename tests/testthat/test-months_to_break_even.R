test_that("months_to_break_even computes correctly", {
  expect_equal(months_to_break_even(500, 60), 500 / 60)
  expect_equal(months_to_break_even(1200, 100), 12)
})

test_that("months_to_break_even returns 0 for zero upfront cost", {
  expect_equal(months_to_break_even(0, 50), 0)
})
