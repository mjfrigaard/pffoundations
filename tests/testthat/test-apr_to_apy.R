test_that("apr_to_apy is always >= apr", {
  expect_gte(apr_to_apy(0.20), 0.20)
  expect_gte(apr_to_apy(0.05), 0.05)
})

test_that("apr_to_apy computes correctly for known value", {
  # (1 + 0.12/12)^12 - 1 = 0.126825...
  expect_equal(apr_to_apy(0.12, 12), (1 + 0.12 / 12)^12 - 1, tolerance = 1e-10)
})

test_that("apr_to_apy with n=1 equals apr", {
  expect_equal(apr_to_apy(0.10, n = 1), 0.10, tolerance = 1e-10)
})
