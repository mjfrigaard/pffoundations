test_that("ef_growth is greater than simple contributions", {
  simple <- 500 * 12
  expect_gt(ef_growth(500, 12, 0.045), simple)
})

test_that("ef_growth at 0% rate equals simple sum", {
  # r -> 0: FV -> monthly * months
  # Approximate with very small rate
  expect_equal(ef_growth(500, 12, 1e-10), 500 * 12, tolerance = 1e-3)
})

test_that("ef_growth increases with more months", {
  expect_gt(ef_growth(500, 24), ef_growth(500, 12))
})
