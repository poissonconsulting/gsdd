gss_vctr <- function(
    x,
    ignore_truncation = FALSE,
    min_length = 274,
    start_temp = 5,
    end_temp = 4,
    window_width = 7,
    pick = "all",
    complete = FALSE,
    msgs = TRUE,
    .rollmean = FALSE) {
  gss <- .gss_vctr(
    x,
    min_length = min_length,
    ignore_truncation = ignore_truncation,
    start_temp = start_temp,
    end_temp = end_temp,
    window_width = window_width,
    pick = pick,
    complete = complete,
    msgs = msgs,
    .rollmean = .rollmean
  )

  if (vld_data(gss)) {
    return(gss)
  }
  if (.rollmean) {
    tibble::tibble(index = integer(0), temperature = numeric(0))
  }
  tibble::tibble(start_index = integer(0), end_index = integer(0), gsdd = numeric(0), truncation = character(0))
}
