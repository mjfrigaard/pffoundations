test_that("dti_ratio computes correctly", {
  expect_equal(dti_ratio(1500, 5000), 0.3)
  expect_equal(dti_ratio(0, 5000), 0)
})
