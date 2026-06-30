test_that("percent_of_income computes correctly", {
  expect_equal(percent_of_income(1500, 5000), 30)
  expect_equal(percent_of_income(5000, 5000), 100)
  expect_equal(percent_of_income(0, 5000), 0)
})
