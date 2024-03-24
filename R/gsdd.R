#' Calculate Growing Season Degree Days (GSDD)
#' 
#' The GSDD is calculated for each study year.
#'
#' @inheritParams params
#' @return A tibble with two columns `year` and `gsdd`.
#' `year`, which is an integer vector, indicates the year in which the window
#' began and `gsdd` which is a non-negative real number provides the GSDD
#' or a missing value if it cannot be calculated.
#' @seealso [gsdd_vctr()], [gdd()] and [gss()]
#' @export
#'
#' @examples
#' data <- gsdd::simulated_data
#' data$temperature <- data$synthetic
#' gsdd(data)
gsdd <- function(
    x, 
    start_date = as.Date("1972-01-01"), 
    end_date = as.Date("1972-12-31"), 
    ignore_truncation = FALSE,
    start_temp = 5,
    end_temp = 4,
    window_width = 7,
    pick = "longest",
    msgs = TRUE) {
  
  .gsdd(x, start_date = start_date, end_date = end_date, 
        ignore_truncation = ignore_truncation,
        start_temp = start_temp,
        end_temp = end_temp,
        window_width = window_width,
        pick = pick,
        msgs = msgs)
}
