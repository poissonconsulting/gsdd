test_that("gsdd works", {
  data <- simulated_data

  gsdd <- gsdd(data)
  expect_snapshot({
    gsdd
  })
})

test_that("gsdd NA if middle truncation", {
  data <- simulated_data

  data$temperature[200] <- NA_real_
  expect_message(gsdd <- gsdd(data), "The growing season is truncated at the end of the sequence.")
  expect_snapshot({
    gsdd
  })
})

test_that("gsdd NA if earlier truncation", {
  data <- simulated_data

  data$temperature[100] <- NA_real_
  expect_message(gsdd <- gsdd(data), "The growing season is truncated at the start of the sequence.")
  expect_snapshot({
    gsdd
  })
})

test_that("gsdd NA if truncated", {
  data <- simulated_data

  gsdd <- gsdd(data, start_date = as.Date("1972-05-01"), end_date = as.Date("1972-05-30"),
                       msgs = FALSE)
  expect_snapshot({
    gsdd
  })
})

test_that("gsdd ignore truncation", {
  data <- simulated_data

  gsdd <- gsdd(data, start_date = as.Date("1972-05-01"), end_date = as.Date("1972-05-30"),
                       msgs = FALSE, ignore_truncation = TRUE)
  expect_snapshot({
    gsdd
  })
})

test_that("gsdd ignore truncation tiny window", {
  data <- simulated_data

  gsdd <- gsdd(data, start_date = as.Date("1972-05-01"), end_date = as.Date("1972-05-06"),
                       msgs = FALSE, ignore_truncation = TRUE, window_width = 3)
  expect_snapshot({
    gsdd
  })
})

test_that("gsdd multiple years", {
  data <- simulated_data

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
  data <- simulated_data

  data <- rbind(data, data)
  
  expect_chk_error(gsdd(data, start_date = as.Date("1972-05-01"), end_date = as.Date("1972-05-06")))
})

test_that("gsdd spans a year", {
  data <- simulated_data

  data$date <- dttr2::dtt_add_days(data$date, 200)
  
  gsdd <- gsdd(data, start_date = as.Date("1972-12-15"), end_date = as.Date("1972-01-15"), ignore_truncation = TRUE)
  expect_snapshot({
    gsdd
  })
})
