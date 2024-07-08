test_that("date_atus works", {
  date_atus <- date_atus(gsdd::temperature_data)
  expect_snapshot({
    date_atus
  })
})

test_that("date_atus start year independent", {
  date_atus <- date_atus(gsdd::temperature_data, start_date = as.Date("1956-03-01"))
  expect_snapshot({
    date_atus
  })
})


test_that("date_atus changes if shift start date", {
  data <- gsdd::temperature_data
  data <- data[-(1:10),]
  date_atus <- date_atus(data, start_date = as.Date("2019-02-01"), min_length = 100)
  expect_snapshot({
    date_atus
  })
})
# 
test_that("date_atus shift before leap year", {
  data <- gsdd::temperature_data
  data <- data[-(1:10),]
  date_atus <- date_atus(data, start_date = as.Date("2019-02-28"), min_length = 100)
  expect_snapshot({
    date_atus
  })
})

test_that("date_atus shift after leap year", {
  data <- gsdd::temperature_data
  data <- data[-(1:10),]
  date_atus <- date_atus(data, start_date = as.Date("2019-03-01"), min_length = 100)
  expect_snapshot({
    date_atus
  })
})

test_that("date_atus change atu and date", {
  data <- gsdd::temperature_data
  date_atus <- date_atus(data, start_date = as.Date("2019-01-01"), atu = 300)
  expect_snapshot({
    date_atus
  })
})

test_that("date_atus set negative to 0", {
  data <- gsdd::temperature_data
  data$temperature[2:10] <- -100
  date_atus <- date_atus(data, start_date = as.Date("2019-01-01"), atu = 300)
  expect_snapshot({
    date_atus
  })
})

test_that("date_atus NA if missing", {
  data <- gsdd::temperature_data
  data$temperature[2] <- NA
  date_atus <- date_atus(data, start_date = as.Date("2019-01-01"), atu = 300)
  expect_snapshot({
    date_atus
  })
})


test_that("date_atus no rows if no data", {
  data <- gsdd::temperature_data[FALSE,]
  date_atus <- date_atus(data, start_date = as.Date("2019-01-01"), atu = 300)
  expect_snapshot({
    date_atus
  })
})
