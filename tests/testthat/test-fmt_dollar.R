test_that("fmt_dollar formats correctly", {
  expect_equal(fmt_dollar(1234.5), "$1,234.50")
  expect_equal(fmt_dollar(0), "$0.00")
  expect_equal(fmt_dollar(1234.6, digits = 0), "$1,235")
})

test_that("fmt_dollar handles negative values", {
  expect_equal(fmt_dollar(-50.5), "$-50.50")
  expect_equal(fmt_dollar(-1000), "$-1,000.00")
})

test_that("fmt_dollar handles vectors", {
  result <- fmt_dollar(c(10, 100, 1000))
  expect_equal(result, c("$10.00", "$100.00", "$1,000.00"))
})
