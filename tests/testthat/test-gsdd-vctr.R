test_that("output is a numeric value", {
  output <- gsdd_vctr(temperature_data$temperature)
  expect_equal(output, 3898.80557580767)
})

test_that("vector must be longer than window_width", {
  x <- temperature_data$temperature[180]
  expect_chk_error(gsdd_vctr(x, window_width = 181))
})

test_that("window_width must be odd", {
  expect_chk_error(gsdd_vctr(temperature_data$temperature, window_width = 6), "`window_width` must be odd.")
})

test_that("gsdd_vctr returns NA when missing summer", {
  x <- temperature_data$temperature
  x[11:360] <- NA_real_
  expect_identical(gsdd_vctr(x, msgs = FALSE), NA_real_)
})

test_that("vector must not contain NA values", {
  x <- temperature_data$temperature
  set.seed(100)
  random_indices <- sample(seq_along(x), 40)
  x[random_indices] <- NA
  expect_identical(gsdd_vctr(x, msgs = FALSE), NA_real_)
})

test_that("gsdd_vctr trims missing values", {
  x <- temperature_data$temperature
  x[c(1,length(x))] <- NA_real_
  expect_equal(gsdd_vctr(x), 3898.80557580767)
})

test_that("start temp must be greater than or equal to end temp", {
  expect_chk_error(gsdd_vctr(temperature_data$temperature, end_temp = 40, start_temp = 30))
})

test_that("if max temp in vector is lower than start_temp the function return 0", {
  output <- gsdd_vctr(temperature_data$temperature, start_temp = 50)
  expect_identical(output, 0)
})

test_that("if end_temp is not reached, gsdd_vctr calculated to end of vector and message is provided.", {
  expect_message(expect_identical(gsdd_vctr(temperature_data$temperature, end_temp = -40), NA_real_), "The growing season is truncated at the end of the sequence.")
})

test_that("truncated at 100.", {
  x <- temperature_data$temperature
  x[100] <- NA_real_
  expect_message(expect_identical(gsdd_vctr(x, min_length = 184), NA_real_), "The growing season is truncated at the start of the sequence.")
})

test_that("truncated at 200.", {
  x <- temperature_data$temperature
  x[200] <- NA_real_
  expect_message(expect_identical(gsdd_vctr(x, min_length = 184), NA_real_), "The growing season is truncated at the end of the sequence.")
})

test_that("if end_temp is reached at end of vector x, indicies do not fall off the edge", {
  gsdd_vctr <- gsdd_vctr(temperature_data$temperature, end_temp = -4, msgs = FALSE, ignore_truncation = TRUE)
  expect_equal(gsdd_vctr, 3921.63308)
})

test_that("if start_temp is reached at start of vector x, indicies do not fall off the edge", {
  x <- temperature_data$temperature
  x <- x[163:length(x)]
  gsdd_vctr <- gsdd_vctr(x, end_temp = 4, msgs = FALSE)
  expect_equal(gsdd_vctr, NA_real_)
  gsdd_vctr <- gsdd_vctr(x, end_temp = 4, msgs = FALSE, ignore_truncation = TRUE, min_length = 184)
  expect_equal(gsdd_vctr, 2687.98160174586)
})

test_that("x must have a length less than 366", {
  expect_error(gsdd_vctr(rep(5,367)))
})

test_that("Gets growth period with biggest gsdd_vctr even though shorter period.", {
  gsdd_vctr <- gsdd_vctr(temperature_data$temperature2, window_width = 3, start_temp = 9, end_temp = 9, pick = "biggest")
  expect_equal(gsdd_vctr, 800)
})

test_that("Gets growth period with biggest gsdd_vctr even though shorter period.", {
  gsdd_vctr <- gsdd_vctr(temperature_data$temperature2, window_width = 3, start_temp = 9, end_temp = 9, pick = "last")
  expect_equal(gsdd_vctr, 800)
})

test_that("Gets growth period with biggest gsdd_vctr even though shorter period.", {
  gsdd_vctr <- gsdd_vctr(temperature_data$temperature2, window_width = 3, start_temp = 9, end_temp = 9, pick = "first")
  expect_equal(gsdd_vctr, 500)
})

test_that("Gets growth period with smallest gsdd_vctr.", {
  gsdd_vctr <- gsdd_vctr(temperature_data$temperature2, window_width = 3, start_temp = 9, end_temp = 9, pick = "smallest")
  expect_equal(gsdd_vctr, 500)
})

test_that("Gets growth period with all gsdd_vctr.", {
  gsdd_vctr <- gsdd_vctr(temperature_data$temperature2, window_width = 3, start_temp = 9, end_temp = 9, pick = "all")
  expect_equal(gsdd_vctr, 1300)
})

test_that("Gets growth period with higher gsdd_vctr even though shorter period.", {
  x <- c(rep(10, 50), rep(0, 255), rep(20, 40))
  gsdd_vctr <- gsdd_vctr(x, window_width = 3, start_temp = 9, end_temp = 9, msgs = FALSE)
  expect_equal(gsdd_vctr, NA_real_)
  gsdd_vctr <- gsdd_vctr(x,
    window_width = 3, start_temp = 9, end_temp = 9, msgs = FALSE,
    ignore_truncation = TRUE, pick = "biggest"
  )
  expect_equal(gsdd_vctr, 800)
})

test_that("Gets growth period longest period.", {
  x <- c(rep(10, 50), rep(0, 255), rep(20, 40))
  gsdd_vctr <- gsdd_vctr(x, window_width = 3, start_temp = 9, end_temp = 9, msgs = FALSE)
  expect_equal(gsdd_vctr, NA_real_)
  gsdd_vctr <- gsdd_vctr(x,
                  window_width = 3, start_temp = 9, end_temp = 9, msgs = FALSE,
                  ignore_truncation = TRUE, pick = "longest"
  )
  expect_equal(gsdd_vctr, 500)
})

test_that("Gets growth period all gsdd_vctr.", {
  x <- c(rep(10, 50), rep(0, 255), rep(20, 40))
  gsdd_vctr <- gsdd_vctr(x, window_width = 3, start_temp = 9, end_temp = 9, msgs = FALSE)
  expect_equal(gsdd_vctr, NA_real_)
  gsdd_vctr <- gsdd_vctr(x,
                  window_width = 3, start_temp = 9, end_temp = 9, msgs = FALSE,
                  ignore_truncation = TRUE, pick = "all"
  )
  expect_equal(gsdd_vctr, 1300)
})

test_that("Gets growth period shortest", {
  x <- c(rep(10, 50), rep(0, 255), rep(20, 40))
  gsdd_vctr <- gsdd_vctr(x, window_width = 3, start_temp = 9, end_temp = 9, msgs = FALSE)
  expect_equal(gsdd_vctr, NA_real_)
  gsdd_vctr <- gsdd_vctr(x,
                  window_width = 3, start_temp = 9, end_temp = 9, msgs = FALSE,
                  ignore_truncation = TRUE, pick = "shortest"
  )
  expect_equal(gsdd_vctr, 800)
})

test_that("Gets all by default", {
  x <- c(rep(10, 50), rep(0, 255), rep(20, 40))
  gsdd_vctr <- gsdd_vctr(x,
                         window_width = 3, start_temp = 9, end_temp = 9, msgs = FALSE,
                         ignore_truncation = TRUE
  )
  expect_equal(gsdd_vctr, 1300)
})

test_that("Gets growth period longest", {
  x <- c(rep(10, 50), rep(0, 255), rep(20, 40))
  gsdd_vctr <- gsdd_vctr(x, window_width = 3, start_temp = 9, end_temp = 9, msgs = FALSE)
  expect_equal(gsdd_vctr, NA_real_)
  gsdd_vctr <- gsdd_vctr(x,
                  window_width = 3, start_temp = 9, end_temp = 9, msgs = FALSE,
                  ignore_truncation = TRUE, pick = "longest"
  )
  expect_equal(gsdd_vctr, 500)
})

test_that("Gets growth gives messages with truncation.", {
  x <- c(rep(10, 50), rep(0, 255), rep(20, 40))
  expect_message(expect_identical(gsdd_vctr(x), NA_real_), "The growing season is truncated at the start of the sequence.")
  expect_message(expect_identical(gsdd_vctr(x, ignore_truncation = "start"), NA_real_), "The growing season is truncated at the end of the sequence.")
})

test_that("Gets gsdd_vctr with single boiling day.", {
  x <- c(rep(0, 100), rep(100, 1), rep(0, 100))
  expect_identical(gsdd_vctr(x, min_length = 184), 100)
})

test_that("Gets gsdd_vctr with single hot day.", {
  x <- c(rep(0, 100), rep(36, 1), rep(0, 100))
  expect_identical(gsdd_vctr(x, min_length = 184), 36)
})

test_that("Gets 0 gsdd_vctr with single warm day.", {
  x <- c(rep(0, 100), rep(35, 1), rep(0, 100))
  expect_identical(gsdd_vctr(x, min_length = 184), 0)
})

test_that("gsdd_vctr with two weeks", {
  x <- c(rep(0, 100), rep(5.1, 7), rep(3.8, 7), rep(0, 100))
  expect_gte(mean(c(rep(5.1, 2), rep(3.8, 5))), 4)
  expect_lt(mean(c(rep(5.1, 1), rep(3.8, 6))), 4)
  expect_equal(gsdd_vctr(x, min_length = 184), 5.1 * 7 + 3.8 * 6)
})

test_that("Gets with two weeks and 3 day window width - great test", {
  x <- c(rep(0, 100), rep(5.1, 7), rep(3.8, 7), rep(0, 100))
  expect_gte(mean(c(rep(5.1, 2), rep(3.8, 1))), 4)
  expect_lt(mean(c(rep(5.1, 0), rep(3.8, 3))), 4)
  expect_equal(gsdd_vctr(x, window_width = 3, min_length = 184), 5.1 * 7 + 3.8 * 3)
})

test_that("Gets with two weeks and 3 day window and smaller", {
  x <- c(rep(0, 100), rep(5.1, 7), rep(3, 7), rep(0, 100))
  expect_lt(mean(c(rep(5.1, 6), 0)), 5)
  expect_gte(mean(c(rep(5.1, 2), rep(3, 1))), 4)
  expect_lt(mean(c(rep(5.1, 1), rep(3, 2))), 4)
  expect_equal(gsdd_vctr(x, window_width = 3, min_length = 184), 5.1 * 7 + 3 * 2)
})

test_that("Gets with two weeks and 3 day window and smaller", {
  x <- c(rep(0, 100), rep(5.1, 7), rep(0, 100))
  expect_equal(gsdd_vctr(x, min_length = 184), 5.1 * 7)
})

test_that("Gets one week with end day after of 0", {
  x <- c(rep(0, 180), rep(5.1, 7), rep(1, 0))
  expect_equal(gsdd_vctr(x, ignore_truncation = "end", msgs = FALSE, min_length = 184), 5.1 * 7)
})

test_that("Gets one week with end day after of 1", {
  x <- c(rep(0, 180), rep(5.1, 7), rep(1, 1))
  expect_equal(gsdd_vctr(x, ignore_truncation = "end", msgs = FALSE, min_length = 184), 5.1 * 7 + 1)
})

test_that("Gets with two weeks and 3 day window and smaller", {
  x <- c(rep(0, 180), rep(5.1, 7))
  expect_equal(gsdd_vctr(x, ignore_truncation = "end", msgs = FALSE, min_length = 184), 5.1 * 7)
})

test_that("Gets triangle", {
  x <- c(seq(-5, 9), 10, seq(9, -5), rep(-1, 153))
  ma <- zoo::rollmean(x, k = 7, align = "center", na.pad = TRUE)
  
  testthat::expect_snapshot({
    tibble::tibble(index = 1:length(x), x = x, ma = ma)
  })
  
  expect_equal(gsdd_vctr(x, min_length = 184), sum(x[9:26]))
})

test_that("Gets asymmetric triangle", {
  x <- c(seq(-5, 9), 10, seq(9.5, -5.5), rep(-6, 152))
  ma <- zoo::rollmean(x, k = 7, align = "center", na.pad = TRUE)
  
  testthat::expect_snapshot({
    tibble::tibble(index = 1:length(x), x = x, ma = ma)
  })
  expect_equal(gsdd_vctr(x, min_length = 184), sum(x[9:26]))
})

test_that("2 asymetric triangles, first one longer but lower, second should be chosen.", {
  x <- c(
    rep(0, 3),
    seq(0, 10, by = 0.5),
    seq(10, 2, by = -0.5),
    seq(2, 25, by = 2),
    seq(21, 0, by = -5),
    rep(0, 126)
  )
  ma <- zoo::rollmean(x, k = 7, align = "center", na.pad = TRUE)

  testthat::expect_snapshot({
    tibble::tibble(index = 1:length(x), x = x, ma = ma)
  })
  
  expect_equal(gsdd_vctr(x, pick = "biggest", min_length = 184), sum(x[41:61]))
})

test_that("2 asymetric triangles, first one longer but lower, second should be chosen unless longest.", {
  x <- c(
    rep(0, 3),
    seq(0, 10, by = 0.5),
    seq(10, 2, by = -0.5),
    seq(2, 25, by = 2),
    seq(21, 0, by = -5),
    rep(0, 126)
  )
  ma <- zoo::rollmean(x, k = 7, align = "center", na.pad = TRUE)
  
  testthat::expect_snapshot({
    tibble::tibble(index = 1:length(x), x = x, ma = ma)
  })
  
  expect_equal(gsdd_vctr(x, pick = "longest", min_length = 184), 193)
})

test_that("2 asymetric triangles, second one longer but lower, first one should be chosen.", {
  x <- c(
    rep(0, 3),
    seq(2, 25, by = 2),
    seq(21, 0, by = -5),
    seq(0, 10, by = 0.5),
    seq(10, 0, by = -0.5),
    rep(0, 122)
  )
  ma <- zoo::rollmean(x, k = 7, align = "center", na.pad = TRUE)
  testthat::expect_snapshot({
    tibble::tibble(index = 1:length(x), x = x, ma = ma)
  })
  
  expect_equal(gsdd_vctr(x, pick = "biggest", min_length = 184), sum(x[3:24]))
})

test_that("Right truncated triangle", {
  x <- c(
    rep(0, 163),
    seq(2, 25, by = 2),
    seq(21, 5, by = -2)
  )
  ma <- zoo::rollmean(x, k = 7, align = "center", na.pad = TRUE)
  data <- tibble::tibble(index = 1:length(x), x = x, ma = ma)
  testthat::expect_snapshot({
    tibble::tibble(index = 1:length(x), x = x, ma = ma)
  })
  
  expect_equal(gsdd_vctr(x, msgs = FALSE), NA_real_)
  expect_equal(gsdd_vctr(x, ignore_truncation = "end", msgs = FALSE, min_length = 184), sum(x[15:length(x)]))
})

test_that("Left truncated triangle", {
  x <- c(
    seq(6, 25, by = 2),
    seq(25, 0, by = -2),
    rep(0,161)
  )
  ma <- zoo::rollmean(x, k = 7, align = "center", na.pad = TRUE)
  
  testthat::expect_snapshot({
    tibble::tibble(index = 1:length(x), x = x, ma = ma)
  })
  
  expect_equal(gsdd_vctr(x, msgs = FALSE), NA_real_)
  expect_equal(gsdd_vctr(x, ignore_truncation = "start", msgs = FALSE, min_length = 184), sum(x[0:25]))
})

test_that("NA if less than 14 values after trimming trailing NAs", {
  x <- c(rep(1,13), rep(NA,100))
  expect_message(expect_identical(gsdd_vctr(x, min_length = 14),NA_real_), "The length of the longest non-missing sequence in `x` must be at least 14.")
  x <- c(rep(1,15), rep(NA,100))
  expect_identical(gsdd_vctr(x, min_length = 15),0)
})

test_that("NA if less than 20 values after trimming trailing NAs", {
  x <- c(rep(1,21), rep(NA,100))
  expect_message(expect_identical(gsdd_vctr(x, window_width = 11, min_length = 22),NA_real_), "The length of the longest non-missing sequence in `x` must be at least 22.")
  x <- c(rep(1,22), rep(NA,100))
  expect_identical(gsdd_vctr(x, window_width = 11, min_length = 22),0)
})

test_that("extracts longest non-missing sequence (not just trim tails)", {
  x <- c(NA,1,NA,rep(1,13),NA,1,NA)
  expect_identical(gsdd_vctr(x, msgs = FALSE),NA_real_) 
  x <- c(NA,1,NA,rep(1,14),NA,1,NA)
  expect_identical(gsdd_vctr(x, min_length = 14),0) 
})
