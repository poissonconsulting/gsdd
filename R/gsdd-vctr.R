#' Calculate Growing Season Degree Days (GSDD) from a vector
#'
#' @param x A numeric vector of the
#' mean daily water temperature values for the period
#' of interest in C.
#' @inheritParams params
#' @seealso [`gsdd()`]
#' @return A non-negative real number of the GSDD.
#' @export
#'
#' @examples
#' gsdd_vctr(c(rep(1, 10), rep(10, 20), rep(1, 200)))
#' gsdd_vctr(gsdd::temperature_data$temperature)
gsdd_vctr <- function(
    x,
    ignore_truncation = FALSE,
    min_length = 274,
    start_temp = 5,
    end_temp = 4,
    window_width = 7,
    pick = "all",
    msgs = TRUE) {
  gss <- .gss_vctr(
    x, 
    ignore_truncation = ignore_truncation, 
    min_length = min_length,
    start_temp = start_temp, 
    end_temp = end_temp,
    window_width = window_width,
    pick = pick,
    msgs = msgs)
  
  if(vld_scalar(gss)) {
    return(gss)
  }
  sum(gss$gsdd)
}
