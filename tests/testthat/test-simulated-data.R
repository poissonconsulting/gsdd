test_that("column names of simulated_data are correct", {
  expect_identical(c("date", "synthetic"), colnames(simulated_data))
})

test_that("confirm correct data classes in simulated_data", {
  expect_s3_class(simulated_data, "data.frame")
  expect_s3_class(simulated_data$date, "Date")
  expect_type(simulated_data$synthetic, "double")
})

test_that("confirm there are no NAs in simulated_data", {
  expect_false(any(is.na(simulated_data)))
})
