test_that("gsdd works", {
  gsdd <- gsdd(temperature_data)
  expect_snapshot({
    gsdd
  })
})

test_that("gsdd NA if middle truncation", {
  data <- temperature_data
  data$temperature[200] <- NA_real_
  expect_message(gsdd <- gsdd(data, min_length = 100), "The growing season is truncated at the end of the sequence.")
  expect_snapshot({
    gsdd
  })
})

test_that("gsdd NA if earlier truncation", {
  data <- temperature_data
  data$temperature[100] <- NA_real_
  expect_message(gsdd <- gsdd(data, min_length = 200), "The growing season is truncated at the start of the sequence.")
  expect_snapshot({
    gsdd
  })
})

test_that("gsdd NA if truncated", {
  gsdd <- gsdd(temperature_data, start_date = as.Date("1972-05-01"), end_date = as.Date("1972-05-30"),
                       msgs = FALSE)
  expect_snapshot({
    gsdd
  })
})

test_that("gsdd ignore truncation", {
  gsdd <- gsdd(temperature_data, start_date = as.Date("1972-05-01"), end_date = as.Date("1972-05-30"),
                       msgs = FALSE, ignore_truncation = TRUE)
  expect_snapshot({
    gsdd
  })
})

test_that("gsdd ignore truncation tiny window", {
  gsdd <- gsdd(temperature_data, start_date = as.Date("1972-05-01"), end_date = as.Date("1972-05-06"),
                       msgs = FALSE, ignore_truncation = TRUE, window_width = 3)
  expect_snapshot({
    gsdd
  })
})

test_that("gsdd multiple years", {
  data <- temperature_data

  data2 <- data
  data2$date <- dttr2::dtt_set_year(data2$date, 1972L)
  data2$temperature <- data2$temperature + 1
  data <- rbind(data, data2)
  
  gsdd <- gsdd(data, start_date = as.Date("1972-05-01"), end_date = as.Date("1972-05-06"),
                       msgs = FALSE, ignore_truncation = TRUE, window_width = 3)
  expect_snapshot({
    gsdd
  })
})

test_that("gsdd errors duplicates", {
  data <- rbind(temperature_data, temperature_data)
  expect_chk_error(gsdd(data, start_date = as.Date("1972-05-01"), end_date = as.Date("1972-05-06")))
})

test_that("gsdd spans a year", {
  data <- temperature_data
  data$date <- dttr2::dtt_add_days(data$date, 200)
  gsdd <- gsdd(data, start_date = as.Date("1972-12-15"), end_date = as.Date("1972-01-15"), ignore_truncation = TRUE)
  expect_snapshot({
    gsdd
  })
})
