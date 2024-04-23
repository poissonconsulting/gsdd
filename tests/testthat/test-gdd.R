test_that("gdd works", {
  gdd <- gdd(temperature_data, min_length = 14)
  expect_snapshot({
    gdd
  })
})

test_that("gdd shifts by 10", {
  data <- temperature_data
  data <- data[-(1:10),]
  gdd <- gdd(data, min_length = 14)
  expect_snapshot({
    gdd
  })
})

test_that("gdd preserves if shift start date", {
  data <- temperature_data
  data <- data[-(1:10),]
  gdd <- gdd(data, start_date = as.Date("2019-02-01"), min_length = 14)
  expect_snapshot({
    gdd
  })
})

test_that("gdd preserves if shift start date", {
  data <- temperature_data

  gdd <- gdd(data, start_date = as.Date("2019-03-20"), ignore_truncation = TRUE, min_length = 14)
  expect_snapshot({
    gdd
  })
})

test_that("gdd one message", {
  data <- temperature_data

  data <- data[-(1:100),]
  expect_message(gdd <- gdd(data, min_length = 14), "The growing season is truncated at the start of the sequence.")
  expect_snapshot({
    gdd
  })
})


test_that("gdd works", {
  data <- temperature_data

  gdd <- gdd(data, window_width = 13, min_length = 26)
  expect_snapshot({
    gdd
  })
})

test_that("gdd works shortened", {
  data <- temperature_data

  gdd <- gdd(data, end_date = as.Date("1972-09-29"), min_length = 14)
  expect_snapshot({
    gdd
  })
})

test_that("gdd works very shortened", {
  data <- temperature_data
  gdd <- gdd(data, end_date = as.Date("1972-04-01"), min_length = 14)
  expect_snapshot({
    gdd
  })
})

test_that("gdd present if stops at", {
  data <- temperature_data

  data <- data[data$date <= as.Date("2019-09-30"),]
  gdd <- gdd(data, min_length = 14)
  expect_snapshot({
    gdd
  })
})

test_that("gdd NA if stops before", {
  data <- temperature_data
  
  data <- data[data$date <= as.Date("2019-09-29"),]
  gdd <- gdd(data, min_length = 14)
  expect_snapshot({
    gdd
  })
})

test_that("gdd NA if missing", {
  data <- temperature_data

  data$temperature[data$date == as.Date("2019-09-30")] <- NA_real_
  gdd <- gdd(data, min_length = 14)
  expect_snapshot({
    gdd
  })
})

test_that("gdd if all above", {
  data <- temperature_data
  data$temperature <- 6
  gdd <- gdd(data)
  expect_snapshot({
    gdd
  })
})

test_that("gdd if all above", {
  data <- temperature_data
  data$temperature <- 6
  gdd <- gdd(data)
  expect_snapshot({
    gdd
  })
})

test_that("gdd start truncation", {
  data <- temperature_data
  data$temperature <- 6
  data <- data[data$date >= as.Date("2019-03-02"),]
  expect_message(gdd <- gdd(data), "The growing season is truncated at the start of the sequence.")
  expect_snapshot({
    gdd
  })
})

test_that("gdd start truncation ignore", {
  data <- temperature_data
  data$temperature <- 6
  data <- data[data$date >= as.Date("2019-03-02"),]
  gdd <- gdd(data, ignore_truncation = TRUE)
  expect_snapshot({
    gdd
  })
})
