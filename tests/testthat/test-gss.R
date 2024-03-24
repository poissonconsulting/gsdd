test_that("gss works", {
  gss <- gss(temperature_data)
  expect_snapshot({
    gss
  })
})

test_that("gss shifts by 10", {
  data <- temperature_data
  data <- data[-(1:10),]
  gss <- gss(data, min_length = 100)
  expect_snapshot({
    gss
  })
})

test_that("gss preserves if shift start date", {
  data <- temperature_data
  data <- data[-(1:10),]
  gss <- gss(data, start_date = as.Date("2019-02-01"), min_length = 100)
  expect_snapshot({
    gss
  })
})

test_that("gss preserves if shift start date", {
  gss <- gss(temperature_data, start_date = as.Date("2019-03-20"), ignore_truncation = TRUE)
  expect_snapshot({
    gss
  })
})

test_that("gss one message", {
  data <- temperature_data
  data <- data[-(1:100),]
  expect_message(gss <- gss(data, min_length = 100), "The growing season is truncated at the start of the sequence.")
  expect_snapshot({
    gss
  })
})


test_that("gss works", {
  gss <- gss(temperature_data, window_width = 13)
  expect_snapshot({
    gss
  })
})

test_that("gss works shortened", {
  expect_message(gss <- gss(temperature_data, min_length = 100, end_date = as.Date("1972-09-29")),
                 "The growing season is truncated at the end of the sequence.")
  expect_snapshot({
    gss
  })
})

test_that("gss NA if stops before", {
  data <- temperature_data
  data <- data[data$date < as.Date("2019-09-30"),]
  expect_message(gss <- gss(data))
  expect_snapshot({
    gss
  })
})

test_that("gss NA if missing", {
  data <- temperature_data
  data$temperature[data$date == as.Date("2019-09-30")] <- NA_real_
  expect_message(gss <- gss(data))
  expect_snapshot({
    gss
  })
})

test_that("growth period with biggest GSDD even though shorter period.", {
  data <- gsdd::temperature_data
  data$temperature <- data$temperature2
  gss <- gss(data, window_width = 3, start_temp = 9, end_temp = 9)
  expect_snapshot({
    gss
  })
})

test_that("growth period default t2", {
  data <- gsdd::temperature_data
  data$temperature <- data$temperature2
  gss <- gss(data)
  expect_snapshot({
    gss
  })
})

test_that("growth period default t2", {
  data <- gsdd::temperature_data
  data$temperature <- data$temperature2
  gss <- gss(data, start_date = as.Date("1972-01-02"))
  expect_snapshot({
    gss
  })
})

test_that("growth period default t2", {
  data <- gsdd::temperature_data
  data$temperature <- data$temperature2
  gss <- gss(data, start_date = as.Date("1972-03-02"))
  expect_snapshot({
    gss
  })
})
