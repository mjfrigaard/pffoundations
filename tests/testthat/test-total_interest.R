test_that("total_interest is positive for non-zero APR", {
  expect_gt(total_interest(5000, 200, 0.18), 0)
})

test_that("total_interest is zero for zero APR", {
  expect_equal(total_interest(5000, 500, 0), 0)
})

test_that("total_interest returns Inf when payment too low", {
  expect_equal(total_interest(5000, 75, 0.18), Inf)
})
