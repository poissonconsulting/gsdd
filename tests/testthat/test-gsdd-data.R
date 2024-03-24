test_that("gsdd_data works", {
  data <- simulated_data
  data$temperature <- data$synthetic
  gsdd <- gsdd_data(data)
  expect_snapshot({
    gsdd
  })
})

test_that("gsdd_data NA if middle truncation", {
  data <- simulated_data
  data$temperature <- data$synthetic
  data$temperature[200] <- NA_real_
  expect_message(gsdd <- gsdd_data(data), "The growing season is truncated at the end of the sequence.")
  expect_snapshot({
    gsdd
  })
})

test_that("gsdd_data NA if earlier truncation", {
  data <- simulated_data
  data$temperature <- data$synthetic
  data$temperature[100] <- NA_real_
  expect_message(gsdd <- gsdd_data(data), "The growing season is truncated at the start of the sequence.")
  expect_snapshot({
    gsdd
  })
})

test_that("gsdd_data NA if truncated", {
  data <- simulated_data
  data$temperature <- data$synthetic
  gsdd <- gsdd_data(data, start_date = as.Date("1972-05-01"), end_date = as.Date("1972-05-30"),
                       msgs = FALSE)
  expect_snapshot({
    gsdd
  })
})

test_that("gsdd_data ignore truncation", {
  data <- simulated_data
  data$temperature <- data$synthetic
  gsdd <- gsdd_data(data, start_date = as.Date("1972-05-01"), end_date = as.Date("1972-05-30"),
                       msgs = FALSE, ignore_truncation = TRUE)
  expect_snapshot({
    gsdd
  })
})

test_that("gsdd_data ignore truncation tiny window", {
  data <- simulated_data
  data$temperature <- data$synthetic
  gsdd <- gsdd_data(data, start_date = as.Date("1972-05-01"), end_date = as.Date("1972-05-06"),
                       msgs = FALSE, ignore_truncation = TRUE, window_width = 3)
  expect_snapshot({
    gsdd
  })
})

test_that("gsdd_data multiple years", {
  data <- simulated_data
  data$temperature <- data$synthetic
  data2 <- data
  data2$date <- dttr2::dtt_set_year(data2$date, 1972L)
  data2$temperature <- data2$temperature + 1
  data <- rbind(data, data2)
  
  gsdd <- gsdd_data(data, start_date = as.Date("1972-05-01"), end_date = as.Date("1972-05-06"),
                       msgs = FALSE, ignore_truncation = TRUE, window_width = 3)
  expect_snapshot({
    gsdd
  })
})

test_that("gsdd_data errors duplicates", {
  data <- simulated_data
  data$temperature <- data$synthetic
  data <- rbind(data, data)
  
  expect_chk_error(gsdd_data(data, start_date = as.Date("1972-05-01"), end_date = as.Date("1972-05-06")))
})

test_that("gsdd_data spans a year", {
  data <- simulated_data
  data$temperature <- data$synthetic
  data$date <- dttr2::dtt_add_days(data$date, 200)
  
  gsdd <- gsdd_data(data, start_date = as.Date("1972-12-15"), end_date = as.Date("1972-01-15"), ignore_truncation = TRUE)
  expect_snapshot({
    gsdd
  })
})
