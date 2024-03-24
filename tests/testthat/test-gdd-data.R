test_that("gdd_data works", {
  data <- simulated_data
  data$temperature <- data$synthetic
  gdd <- gdd_data(data)
  expect_snapshot({
    gdd
  })
})

test_that("gdd_data shifts by 10", {
  data <- simulated_data
  data$temperature <- data$synthetic
  data <- data[-(1:10),]
  gdd <- gdd_data(data)
  expect_snapshot({
    gdd
  })
})

test_that("gdd_data preserves if shift start date", {
  data <- simulated_data
  data$temperature <- data$synthetic
  data <- data[-(1:10),]
  gdd <- gdd_data(data, start_date = as.Date("2019-02-01"))
  expect_snapshot({
    gdd
  })
})

test_that("gdd_data preserves if shift start date", {
  data <- simulated_data
  data$temperature <- data$synthetic
  gdd <- gdd_data(data, start_date = as.Date("2019-03-20"), ignore_truncation = TRUE)
  expect_snapshot({
    gdd
  })
})

test_that("gdd_data one message", {
  data <- simulated_data
  data$temperature <- data$synthetic
  data <- data[-(1:100),]
  expect_message(gdd <- gdd_data(data), "The growing season is truncated at the start of the sequence.")
  expect_snapshot({
    gdd
  })
})


test_that("gdd_data works", {
  data <- simulated_data
  data$temperature <- data$synthetic
  gdd <- gdd_data(data, window_width = 13)
  expect_snapshot({
    gdd
  })
})

test_that("gdd_data works shortened", {
  data <- simulated_data
  data$temperature <- data$synthetic
  gdd <- gdd_data(data, end_date = as.Date("1972-09-29"))
  expect_snapshot({
    gdd
  })
})

test_that("gdd_data works very shortened", {
  data <- simulated_data
  data$temperature <- data$synthetic
  gdd <- gdd_data(data, end_date = as.Date("1972-04-01"))
  expect_snapshot({
    gdd
  })
})

test_that("gdd_data NA if stops before", {
  data <- simulated_data
  data$temperature <- data$synthetic
  data <- data[data$date < as.Date("2019-09-30"),]
  expect_message(gdd <- gdd_data(data))
  expect_snapshot({
    gdd
  })
})

test_that("gdd_data NA if missing", {
  data <- simulated_data
  data$temperature <- data$synthetic
  data$temperature[data$date == as.Date("2019-09-30")] <- NA_real_
  gdd <- gdd_data(data)
  expect_snapshot({
    gdd
  })
})
