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

test_that("gss_plot two year facet", {
  data <- gsdd::temperature_data
  data$date <- dttr2::dtt_add_years(data$date, 4L)
  data$temperature <- data$temperature + 0.5
  data <- rbind(data, gsdd::temperature_data)
  expect_snapshot_plot(gss_plot(data, ncol = 1), "gss_plot6")
})

test_that("gss_plot wrap cut year", {
  expect_snapshot_plot(gss_plot(gsdd::temperature_data, start_date = as.Date("1972-06-01"), end_date = as.Date("1972-11-01"), min_length = 120), "gss_plot8")
})

test_that("gss_plot wrap cut year dec", {
  expect_snapshot_plot(gss_plot(gsdd::temperature_data, start_date = as.Date("1972-06-01"), end_date = as.Date("1972-12-31"), min_length = 120), "gss_plot9")
})

test_that("gss_plot wrap feb 28st", {
  skip("need to fix wrapping on year")
  expect_snapshot_plot(gss_plot(gsdd::temperature_data, start_date = as.Date("1972-02-15"), end_date = as.Date("1972-01-15"), min_length = 120), "gss_plot10")
})

test_that("gss_plot exclude feb 1st", {
  skip("need to fix wrapping on year")
  expect_snapshot_plot(gss_plot(gsdd::temperature_data, start_date = as.Date("1972-06-01"), end_date = as.Date("1972-02-15"), min_length = 120), "gss_plot11")
})

