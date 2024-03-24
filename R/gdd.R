#' Calculate Growing Degree Days (GDD)
#' 
#' Calculate the number of growing degree days to the specified end date.
#'
#' @inheritParams params
#' @param ignore_truncation A flag specifying whether to ignore start truncation (end truncation is always ignored).
#' @return A tibble with two columns `year` and `gdd`.
#' @seealso [gsdd()]
#' @export
#'
#' @examples
#' gdd(gsdd::temperature_data)
gdd <- function(
    x, 
    start_date = as.Date("1972-03-01"), 
    end_date = as.Date("1972-09-30"),
    min_length = NULL,
    ignore_truncation = FALSE,
    start_temp = 5,
    end_temp = 4,
    window_width = 7,
    pick = "all",
    msgs = TRUE) {
  
  chk_flag(ignore_truncation)
  
  if(!ignore_truncation) {
    ignore_truncation <- "end"
  }
  
  gdd <- .gss(
    x, 
    start_date = start_date, 
    end_date = end_date, 
    ignore_truncation = ignore_truncation, 
    min_length = min_length,
    start_temp = start_temp,
    end_temp = end_temp,
    window_width = window_width,
    pick = pick,
    msgs = msgs) |>
    dplyr::rename(gdd = "gsdd")
  
  if(!nrow(gdd) || all(is.na(gdd$gdd))) {
    return(gdd)
  }
  
  gss <- .gss(
    x, 
    start_date = start_date, 
    end_date = end_date, 
    ignore_truncation = ignore_truncation, 
    min_length = min_length,
    start_temp = start_temp,
    end_temp = end_temp,
    window_width = window_width,
    pick = "last",
    msgs = msgs,
    gss = TRUE) |>
    dplyr::select("year", "end_dayte")
  
  gdd <- gdd |> dplyr::right_join(gss, by = "year")
  
  gdd |>
    dplyr::select("year", "gdd")
}
