test_that("months_to_ef_goal computes months correctly", {
  expect_equal(months_to_ef_goal(18000, 3000, 500), 30L)
})

test_that("months_to_ef_goal returns 0 when already at target", {
  expect_equal(months_to_ef_goal(18000, 18000, 500), 0L)
  expect_equal(months_to_ef_goal(18000, 20000, 500), 0L)
})

test_that("months_to_ef_goal ceiling rounds up", {
  # 15001 / 500 = 30.002 -> 31
  expect_equal(months_to_ef_goal(18001, 3000, 500), 31L)
})
