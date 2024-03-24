#' Calculate Growing Seasons (GSS)
#' 
#' Calculate the start and end and gsdd values of all growing seasons in a year.
#'
#' @inheritParams params
#' @return A tibble with four columns:
#' `year`, `start_dayte`, `end_dayte` and `gsdd`.
#' @seealso [gsdd()]
#' @export
#'
#' @examples
#' gss(gsdd::temperature_data)
gss <- function(
    x, 
    start_date = as.Date("1972-02-28"), 
    end_date = as.Date("1972-12-31"),
    min_length = NULL,
    ignore_truncation = FALSE,
    start_temp = 5,
    end_temp = 4,
    window_width = 7,
    pick = "all",
    msgs = TRUE) {
  
  .gsdd(
    x, 
    start_date = start_date, 
    end_date = end_date, 
    ignore_truncation = ignore_truncation,
    min_length = min_length,
    start_temp = start_temp,
    end_temp = end_temp,
    window_width = window_width,
    pick = pick,
    msgs = msgs, 
    gss = TRUE)
}
