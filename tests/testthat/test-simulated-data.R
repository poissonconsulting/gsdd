test_that("check temperature_data", {
  chk::check_data(
    gsdd::temperature_data, 
    values = list(date = as.Date(c("2019-01-01", "2019-12-31")),
                  temperature = c(0, 26),
                  temperature2 = c(0, 20)),
    exclusive = TRUE,
    order = TRUE,
    nrow = 365,
    key = "date")
})
