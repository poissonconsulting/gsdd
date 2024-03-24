set.seed(13)
day <- 1:365
simulated_data <-
  -15 * cos((2 * pi / 365) * (day - 10)) + rnorm(365, mean = 10, sd = .5)
simulated_data[simulated_data < 0] <- 0

simulated_data <- tibble::tibble(
  date = seq.Date(
    from = as.Date("2019-01-01"),
    to = as.Date("2019-12-31"),
    by = "day"
  ),
  synthetic = simulated_data
)
usethis::use_data(simulated_data, overwrite = TRUE)
