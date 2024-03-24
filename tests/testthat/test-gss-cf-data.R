test_that("gss_cf_data works", {
  data <- simulated_data
  data$temperature <- data$synthetic
  gss <- gss_cf_data(data)
  expect_snapshot({
    gss
  })
})

test_that("gss_cf_data shifts by 10", {
  data <- simulated_data
  data$temperature <- data$synthetic
  data <- data[-(1:10),]
  gss <- gss_cf_data(data)
  expect_snapshot({
    gss
  })
})

test_that("gss_cf_data preserves if shift start date", {
  data <- simulated_data
  data$temperature <- data$synthetic
  data <- data[-(1:10),]
  gss <- gss_cf_data(data, start_date = as.Date("2019-02-01"))
  expect_snapshot({
    gss
  })
})

test_that("gss_cf_data preserves if shift start date", {
  data <- simulated_data
  data$temperature <- data$synthetic
  gss <- gss_cf_data(data, start_date = as.Date("2019-03-20"), ignore_truncation = TRUE)
  expect_snapshot({
    gss
  })
})

test_that("gss_cf_data one message", {
  data <- simulated_data
  data$temperature <- data$synthetic
  data <- data[-(1:100),]
  expect_message(gss <- gss_cf_data(data), "The growing season is truncated at the start of the sequence.")
  expect_snapshot({
    gss
  })
})


test_that("gss_cf_data works", {
  data <- simulated_data
  data$temperature <- data$synthetic
  gss <- gss_cf_data(data, window_width = 13)
  expect_snapshot({
    gss
  })
})

test_that("gss_cf_data works shortened", {
  data <- simulated_data
  data$temperature <- data$synthetic
  expect_message(gss <- gss_cf_data(data, end_date = as.Date("1972-09-29")),
                 "The growing season is truncated at the end of the sequence.")
  expect_snapshot({
    gss
  })
})

test_that("gss_cf_data NA if stops before", {
  data <- simulated_data
  data$temperature <- data$synthetic
  data <- data[data$date < as.Date("2019-09-30"),]
  expect_message(gss <- gss_cf_data(data))
  expect_snapshot({
    gss
  })
})

test_that("gss_cf_data NA if missing", {
  data <- simulated_data
  data$temperature <- data$synthetic
  data$temperature[data$date == as.Date("2019-09-30")] <- NA_real_
  expect_message(gss <- gss_cf_data(data))
  expect_snapshot({
    gss
  })
})

test_that("growth period with biggest GSDD even though shorter period.", {
  x <- c(rep(0, 100), rep(10, 50), rep(0, 50), rep(20, 40), rep(0, 115))
  data <- data.frame(temperature = x)
  data$date <- as.Date("2022-01-01") + 1:nrow(data)
  gss <- gss_cf_data(data, window_width = 3, start_temp = 9, end_temp = 9)
  expect_snapshot({
    gss
  })
})

