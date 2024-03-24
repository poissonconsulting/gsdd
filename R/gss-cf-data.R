#' Calculate Growing Seasons from a Data Frame
#' 
#'
#' @inheritParams gsdd_cf
#' @inheritParams gsdd_cf_data
#' @return A tibble with four columns `year`, `start_dayte`, `end_dayte` and `gsdd`.
#' @seealso [gsdd_cf_data()]
#' @export
#'
#' @examples
#' data <- gsdd::simulated_data
#' data$temperature <- data$synthetic
#' gss_cf_data(data)
gss_cf_data <- function(
    x, 
    start_date = as.Date("1972-01-01"), 
    end_date = as.Date("1972-12-31"), 
    ignore_truncation = FALSE,
    msgs = TRUE, 
    ...) {
  
  .gsdd_data(x, start_date = start_date, end_date = end_date, 
             ignore_truncation = ignore_truncation,
             msgs = msgs,
             ..., gss = TRUE)
}
