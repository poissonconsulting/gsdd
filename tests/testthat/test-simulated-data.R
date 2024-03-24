test_that("column names of temperature_data are correct", {
  expect_identical(c("date", "temperature"), colnames(temperature_data))
})

test_that("confirm correct data classes in temperature_data", {
  expect_s3_class(temperature_data, "data.frame")
  expect_s3_class(temperature_data$date, "Date")
  expect_type(temperature_data$temperature, "double")
})

test_that("confirm there are no NAs in temperature_data", {
  expect_false(any(is.na(temperature_data)))
})
