test_that("to_annual converts daily correctly", {
  expect_equal(to_annual(5, "daily"), 1825)
})

test_that("to_annual converts weekly correctly", {
  expect_equal(to_annual(100, "weekly"), 5200)
})

test_that("to_annual converts monthly correctly", {
  expect_equal(to_annual(500, "monthly"), 6000)
})
