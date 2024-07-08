.atu_index <- function(
    x,
    date,
    atus,
    msgs = TRUE) {
  
  x <- pmax(x, 0)
  x <- cumsum(x)
  wch <- which(x >= atus)
  index <- if(length(wch)) { wch[1]} else { integer(0) }
  tibble::tibble(end_date = date[index], atus = x[index])
}
