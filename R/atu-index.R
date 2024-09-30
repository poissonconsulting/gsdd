.atu_index <- function(
    x,
    date,
    atus) {
  x <- pmax(x, 0)
  x <- cumsum(x)
  wch <- which(x >= atus)
  if (!length(wch)) {
    tibble::tibble(end_date = dttr2::NA_Date_, atus = NA_real_)
  }
  index <- wch[1]
  tibble::tibble(end_date = date[index], atus = x[index])
}
