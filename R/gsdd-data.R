#' Calculate Growing Season Degree Days (GSDD) from a Data Frame
#' 
#' The GSDD is calculated for each study year from a data frame 
#' with `date` and `temperature` columns. 
#' `date`, which must be of class Date provides the dates and 
#' `temperature` which must be a numeric vector provides the 
#' mean daily water temperature in degrees centigrade. For additional information on 
#' GSDD and the various arguments that can be passed via `...` see [`gsdd()`].
#'
#' @param x A data frame with two columns `date` and `temperature`. 
#' @param start_date A Date scalar of the first date within each year to consider (the year
#' is ignored).
#' @param end_date A Date scalar of the last date within each year to consider (the year is ignored).
#' If `end_date` is less than `start_date` (ignoring the year) then the window is considered 
#' to span two calendar years.
#' @inheritParams gsdd_vctr
#' @param ... Additional arguments passed to [`gsdd_vctr()`].
#' @return A tibble with two columns `year` and `gsdd`.
#' `year`, which is an integer vector, indicates the year in which the window
#' began and `gsdd` which is a non-negative real number provides the GSDD
#' or a missing value if it cannot be calculated.
#' @seealso [gsdd()] and [gdd()]
#' @export
#'
#' @examples
#' data <- gsdd::simulated_data
#' data$temperature <- data$synthetic
#' gsdd_data(data)
gsdd_data <- function(
    x, 
    start_date = as.Date("1972-01-01"), 
    end_date = as.Date("1972-12-31"), 
    ignore_truncation = FALSE,
    msgs = TRUE, 
    ...) {
  
  .gsdd_data(x, start_date = start_date, end_date = end_date, 
             ignore_truncation = ignore_truncation,
             msgs = msgs,
             ...)
}
