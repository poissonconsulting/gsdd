gss <- function(x,
                   ignore_truncation = FALSE,
                   start_temp = 5,
                   end_temp = 4,
                   window_width = 7,
                   msgs = TRUE) {
  data <- .gss(x, ignore_truncation = ignore_truncation, 
               start_temp = start_temp, end_temp = end_temp,
               window_width = window_width, msgs = msgs)
  
  if(vld_scalar(data)) {
    return(tibble::tibble(start_index = integer(0), end_index = integer(0), gsdd = numeric(0)))
  }
  data |>
    dplyr::select(start_index = "index_start",
                  end_index = "index_end",
                  "gsdd") |>
    dplyr::arrange(.data$start_index)
}
