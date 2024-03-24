#' Calculate Growing Degree Days (GDD) from a Data Frame
#' 
#' The GDD which is a the growing degree days to the end date 
#' is calculated for each study year from a data frame. 
#' with `date` and `temperature` columns. 
#' `date`, which must be of class Date provides the dates and 
#' `temperature` which must be a numeric vector provides the 
#' mean daily water temperature in degrees centigrade.
#'
#' @param x A data frame with two columns `date` and `temperature`. 
#' @param start_date A Date scalar of the first date within each year to consider (the year
#' is ignored).
#' @param end_date A Date scalar of the end date for the growing degree days
#'  (the year is ignored).
#' If `end_date` is less than `start_date` (ignoring the year) then the window is considered 
#' to span two calendar years.
#' @inheritParams gsdd_vctr
#' @param ignore_truncation A flag specifying whether to ignore start truncation (end truncation is always ignored).
#' @return A tibble with two columns `year` and `gdd`.
#' `year`, which is an integer vector, indicates the year in which the window
#' began and `gdd` which is a non-negative real number provides the GSDD
#' or a missing value if it cannot be calculated.
#' @seealso [gsdd()]
#' @export
#'
#' @examples
#' data <- gsdd::simulated_data
#' data$temperature <- data$synthetic
#' gdd(data)
gdd <- function(
    x, 
    start_date = as.Date("1972-01-01"), 
    end_date = as.Date("1972-09-30"),
    ignore_truncation = FALSE,
    start_temp = 5,
    end_temp = 4,
    window_width = 7,
    pick = "longest",
    msgs = TRUE) {
  
  chk_flag(ignore_truncation)
  
  if(!ignore_truncation) {
    ignore_truncation <- "end"
  }
  
  .gsdd(
    x, 
    start_date, 
    end_date, 
    ignore_truncation = ignore_truncation, 
    msgs = msgs,
    start_temp = start_temp,
    end_temp = end_temp,
    window_width = window_width) |>
    dplyr::rename(gdd = "gsdd")
}
