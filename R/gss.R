#' Calculate Growing Seasons from a Data Frame
#' 
#'
#' @inheritParams gsdd_vctr
#' @inheritParams gsdd
#' @return A tibble with four columns `year`, `start_dayte`, `end_dayte` and `gsdd`.
#' @seealso [gsdd()]
#' @export
#'
#' @examples
#' data <- gsdd::simulated_data
#' data$temperature <- data$synthetic
#' gss(data)
gss <- function(
    x, 
    start_date = as.Date("1972-01-01"), 
    end_date = as.Date("1972-12-31"), 
    ignore_truncation = FALSE,
    msgs = TRUE, 
    ...) {
  
  .gsdd(x, start_date = start_date, end_date = end_date, 
             ignore_truncation = ignore_truncation,
             msgs = msgs,
             ..., gss = TRUE)
}
