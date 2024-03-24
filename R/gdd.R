#' Calculate Growing Degree Days (GDD)
#' 
#' Calculate the number of growing degree days to the specified end date.
#'
#' @inheritParams params
#' @param ignore_truncation A flag specifying whether to ignore start truncation (end truncation is always ignored).
#' @return A tibble with two columns `year` and `gdd`.
#' `year`, which is an integer vector, indicates the year in which the window
#' began and `gdd` which is a non-negative real number provides the GDD value.
#' @seealso [gsdd()]
#' @export
#'
#' @examples
#' gdd(gsdd::temperature_data)
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
    window_width = window_width,
    pick = pick) |>
    dplyr::rename(gdd = "gsdd")
}
