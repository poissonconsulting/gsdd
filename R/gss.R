#' Calculate Growing Seasons
#' 
#'
#' @inheritParams gsdd_vctr
#' @inheritParams gsdd
#' @return A tibble with four columns `year`, `start_dayte`, `end_dayte` and `gsdd`.
#' @seealso [gsdd()]
#' @export
#'
#' @examples
#' data <- gsdd::temperature_data
#' gss(data)
gss <- function(
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
        msgs = msgs, gss = TRUE)
}
