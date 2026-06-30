test_that("fmt_pct formats correctly", {
  expect_equal(fmt_pct(12.3), "12.3%")
  expect_equal(fmt_pct(100), "100.0%")
  expect_equal(fmt_pct(12.344, digits = 2), "12.34%")
})

test_that("fmt_pct handles zero and negative values", {
  expect_equal(fmt_pct(0), "0.0%")
  expect_equal(fmt_pct(-5.5), "-5.5%")
})

test_that("fmt_pct handles vectors", {
  result <- fmt_pct(c(10, 25, 50))
  expect_equal(result, c("10.0%", "25.0%", "50.0%"))
})
