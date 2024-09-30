longest_run <- function(x) {
  rle <- rle(!is.na(x))
  wch <- which(rle$values)
  if (!length(wch)) {
    return(numeric(0))
  }
  wch <- wch[which.max(rle$length[rle$values])]
  cumsum <- cumsum(rle$lengths)
  to <- cumsum[wch]
  from <- if (wch == 1) 1L else cumsum[wch - 1] + 1L
  from:to
}

sum_vector <- function(from, to, ..vector) {
  sum(..vector[from:to])
}

is_even <- function(x) {
  !(x %% 2)
}

index_begin_run <- function(x) {
  index <- which(x)
  if (length(index) <= 1) {
    return(index)
  }
  index[c(TRUE, diff(index) > 1)]
}

.data <- NULL
