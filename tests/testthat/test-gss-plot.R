test_that("gss_plot", {
  expect_snapshot_plot(gss_plot(gsdd::temperature_data), "gss_plot1")
})
