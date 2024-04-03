test_that("gss_plot", {
  expect_snapshot_plot(gss_plot(gsdd::temperature_data), "gss_plot1")
})

test_that("gss_plot", {
  data <- gsdd::temperature_data
  data$temperature <- data$temperature2
  expect_snapshot_plot(gss_plot(data), "gss_plot2")
})
