test_that("output is a numeric value", {
  x <- simulated_data$synthetic
  gss <- gss(x)
  expect_snapshot({
    gss
  })
})

test_that("vector must be longer than window_width", {
  x <- simulated_data$synthetic[180]
  expect_chk_error(gss(x, window_width = 181))
})

test_that("window_width must be odd", {
  x <- simulated_data$synthetic
  expect_chk_error(gss(x, window_width = 6), "`window_width` must be odd.")
})

test_that("gss returns no rows when missing summer", {
  x <- simulated_data$synthetic
  x[11:360] <- NA_real_
  gss <- gss(x, msgs = FALSE)
  expect_snapshot({
    gss
  })
})

test_that("gss trims missing values", {
  x <- simulated_data$synthetic
  x[c(1,length(x))] <- NA_real_
  gss <- gss(x, msgs = FALSE)
  expect_snapshot({
    gss
  })
})

test_that("start temp must be greater than or equal to end temp", {
  x <- simulated_data$synthetic
  expect_chk_error(gss(x, end_temp = 40, start_temp = 30))
})

test_that("if max temp in vector is lower than start_temp the function return no row", {
  x <- simulated_data$synthetic
  gss <- gss(x, start_temp = 50)
  expect_snapshot({
    gss
  })
})

test_that("if end_temp is reached at end of vector x, indicies do not fall off the edge", {
  x <- simulated_data$synthetic
  gss <- gss(x, end_temp = -4, msgs = FALSE, ignore_truncation = TRUE)
  expect_snapshot({
    gss
  })
})

test_that("if start_temp is reached at start of vector x, indicies do not fall off the edge", {
  x <- simulated_data$synthetic
  x <- x[163:length(x)]
  gss1 <- gss(x, end_temp = 4, msgs = FALSE)
  gss2 <- gss(x, end_temp = 4, msgs = FALSE, ignore_truncation = TRUE)
  expect_snapshot({
    gss1
    gss2
  })
})

test_that("x must have a length less than 366", {
  expect_error(gss(rep(5,367)))
})

test_that("growth period with biggest GSDD even though shorter period.", {
  x <- c(rep(0, 100), rep(10, 50), rep(0, 50), rep(20, 40), rep(0, 115))
  gss <- gss(x, window_width = 3, start_temp = 9, end_temp = 9)
  expect_snapshot({
    gss
  })
})

test_that("growth period with higher GSDD even though shorter period.", {
  x <- c(rep(10, 50), rep(0, 255), rep(20, 40))
  gss1 <- gss(x, window_width = 3, start_temp = 9, end_temp = 9, msgs = FALSE)
  gss2 <- gss(x,
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
  gss <- gss(x)
  expect_snapshot({
    gss
  })
})

test_that("Gets gss with single hot day.", {
  x <- c(rep(0, 100), rep(36, 1), rep(0, 100))
  gss <- gss(x)
  expect_snapshot({
    gss
  })
})

test_that("Gets 0 gss with single warm day.", {
  x <- c(rep(0, 100), rep(35, 1), rep(0, 100))
  gss <- gss(x)
  expect_snapshot({
    gss
  })
})
