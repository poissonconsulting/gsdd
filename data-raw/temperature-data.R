set.seed(13)
day <- 1:365
temperature_data <-
  -15 * cos((2 * pi / 365) * (day - 10)) + rnorm(365, mean = 10, sd = .5)
temperature_data[temperature_data < 0] <- 0

temperature_data <- tibble::tibble(
  date = seq.Date(
    from = as.Date("2019-01-01"),
    to = as.Date("2019-12-31"),
    by = "day"
  ),
  temperature = temperature_data
)
temperature_data$temperature2 <- c(rep(0, 100), rep(10, 50), rep(0, 50), rep(20, 40), rep(0, 125))

usethis::use_data(temperature_data, overwrite = TRUE)
