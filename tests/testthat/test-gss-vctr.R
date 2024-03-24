test_that("output is a numeric value", {
  x <- temperature_data$temperature
  gss <- gss_vctr(x)
  expect_snapshot({
    gss
  })
})

test_that("vector must be longer than window_width", {
  x <- temperature_data$temperature[180]
  expect_chk_error(gss_vctr(x, window_width = 181))
})

test_that("window_width must be odd", {
  x <- temperature_data$temperature
  expect_chk_error(gss_vctr(x, window_width = 6), "`window_width` must be odd.")
})

test_that("gss returns no rows when missing summer", {
  x <- temperature_data$temperature
  x[11:360] <- NA_real_
  gss <- gss_vctr(x, msgs = FALSE)
  expect_snapshot({
    gss
  })
})

test_that("gss trims missing values", {
  x <- temperature_data$temperature
  x[c(1,length(x))] <- NA_real_
  gss <- gss_vctr(x, msgs = FALSE)
  expect_snapshot({
    gss
  })
})

test_that("start temp must be greater than or equal to end temp", {
  x <- temperature_data$temperature
  expect_chk_error(gss_vctr(x, end_temp = 40, start_temp = 30))
})

test_that("if max temp in vector is lower than start_temp the function return no row", {
  x <- temperature_data$temperature
  gss <- gss_vctr(x, start_temp = 50)
  expect_snapshot({
    gss
  })
})

test_that("if end_temp is reached at end of vector x, indicies do not fall off the edge", {
  x <- temperature_data$temperature
  gss <- gss_vctr(x, end_temp = -4, msgs = FALSE, ignore_truncation = TRUE)
  expect_snapshot({
    gss
  })
})

test_that("if start_temp is reached at start of vector x, indicies do not fall off the edge", {
  x <- temperature_data$temperature
  x <- x[163:length(x)]
  gss1 <- gss_vctr(x, end_temp = 4, msgs = FALSE)
  gss2 <- gss_vctr(x, end_temp = 4, msgs = FALSE, ignore_truncation = TRUE, min_length = 184)
  expect_snapshot({
    gss1
    gss2
  })
})

test_that("x must have a length less than 366", {
  expect_error(gss_vctr(rep(5,367)))
})

test_that("growth period with biggest GSDD even though shorter period.", {
  gss <- gss_vctr(temperature_data$temperature2, window_width = 3, start_temp = 9, end_temp = 9)
  expect_snapshot({
    gss
  })
})

test_that("growth period with higher GSDD even though shorter period.", {
  x <- c(rep(10, 50), rep(0, 255), rep(20, 40))
  gss1 <- gss_vctr(x, window_width = 3, start_temp = 9, end_temp = 9, msgs = FALSE)
  gss2 <- gss_vctr(x,
                  window_width = 3, start_temp = 9, end_temp = 9, msgs = FALSE,
                  ignore_truncation = TRUE
  )
  expect_snapshot({
    gss1
    gss2
  })
})

test_that("Gets gss with single boiling day.", {
  x <- c(rep(0, 100), rep(100, 1), rep(0, 100))
  gss <- gss_vctr(x, min_length = 184)
  expect_snapshot({
    gss
  })
})

test_that("Gets gss with single hot day.", {
  x <- c(rep(0, 100), rep(36, 1), rep(0, 100))
  gss <- gss_vctr(x, min_length = 184)
  expect_snapshot({
    gss
  })
})

test_that("Gets 0 gss with single warm day.", {
  x <- c(rep(0, 100), rep(35, 1), rep(0, 100))
  gss <- gss_vctr(x, min_length = 184)
  expect_snapshot({
    gss
  })
})

test_that("pick all", {
  gss <- gss_vctr(temperature_data$temperature2)
  expect_snapshot({
    gss
  })
})

test_that("pick smallest", {
  gss <- gss_vctr(temperature_data$temperature2, pick = "smallest")
  expect_snapshot({
    gss
  })
})

test_that("pick biggest", {
  gss <- gss_vctr(temperature_data$temperature2, pick = "biggest")
  expect_snapshot({
    gss
  })
})

test_that("pick longest", {
  gss <- gss_vctr(temperature_data$temperature2, pick = "longest")
  expect_snapshot({
    gss
  })
})

test_that("pick shortest", {
  gss <- gss_vctr(temperature_data$temperature2, pick = "shortest")
  expect_snapshot({
    gss
  })
})

test_that("pick first", {
  gss <- gss_vctr(temperature_data$temperature2, pick = "first")
  expect_snapshot({
    gss
  })
})

test_that("pick last", {
  gss <- gss_vctr(temperature_data$temperature2, pick = "first")
  expect_snapshot({
    gss
  })
})
