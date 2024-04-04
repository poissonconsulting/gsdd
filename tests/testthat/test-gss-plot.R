test_that("gss_plot", {
  expect_snapshot_plot(gss_plot(gsdd::temperature_data), "gss_plot1")
})

test_that("gss_plot", {
  data <- gsdd::temperature_data
  data$temperature <- data$temperature2
  expect_snapshot_plot(gss_plot(data), "gss_plot2")
})

test_that("gss_plot pick longest", {
  data <- gsdd::temperature_data
  data$temperature <- data$temperature2
  expect_snapshot_plot(gss_plot(data, pick = "longest"), "gss_plot5")
})

test_that("gss_plot shifted", {
  data <- gsdd::temperature_data
  data$temperature[1:100] <- NA_real_
  expect_warning(expect_snapshot_plot(gss_plot(data, start_date = as.Date("1972-03-01"), min_length = 120, msgs = FALSE), "gss_plot3"), "missing values")
})

test_that("gss_plot ignore truncation", {
  data <- gsdd::temperature_data
  data$temperature[1:100] <- NA_real_
  expect_warning(expect_snapshot_plot(gss_plot(data, start_date = as.Date("1972-03-01"), min_length = 120, msgs = FALSE, ignore_truncation = TRUE), "gss_plot4"), "missing values")
})

# test_that("gss_plot wrap", {
#   data <- gsdd::temperature_data
#   expect_snapshot_plot(gss_plot(data, start_date = as.Date("1972-03-01"), end_date = as.Date("1972-02-01")), "gss_plot5")
# })
