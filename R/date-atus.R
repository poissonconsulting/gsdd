#' Calculate Date of Accumulated Thermal Units (ATUs)
#' 
#' Calculates the date on which a specified number of Accumulated Thermal Units (ATUs)
#' are meet or exceeded.
#' 
#' @inheritParams params
#' @return A tibble with four columns `year`, `start_date`, `end_date` and `atus`.
#' @export
#'
#' @examples
#' date_atus(gsdd::temperature_data)
date_atus <- function(
    x,
    atus = 600,
    start_date = as.Date("1972-03-01")) {
  
  check_data(x, list(date = dttr2::dtt_date("1970-01-01"), temperature = c(1, NA)))
  chk_date(start_date)
  chk_number(atus)
  chk_gt(atus)

  end_date <- start_date + 364L
  
  end_dayte <- dttr2::dtt_dayte(end_date, start_date)
  start_dayte <- dttr2::dtt_dayte(start_date, start_date)
  
  x <- x |>
    dplyr::mutate(
      date = dttr2::dtt_date(.data$date)) |>
    check_key("date", x_name = "x") |>
    dplyr::arrange(.data$date)
  
  if(!nrow(x)) {
    return(tibble::tibble(
      year = integer(), 
      start_date = as.Date(integer()), 
      end_date = as.Date(integer()), 
      atus = numeric()))
  }
  
  x <- x |>
    dplyr::mutate(
      year = dttr2::dtt_study_year(.data$date, start = start_date),
      year = stringr::str_extract(.data$year, "^\\d{4,4}"),
      year = as.integer(.data$year)) |>
    dplyr::group_by(.data$year) |>
    dplyr::group_modify(~complete_dates(.x, start_date, end_date)) 
  
  x <- x |>
    dplyr::group_modify(~.atu_index(
      .x$temperature,
      .x$date,
      atus = atus), .keep = TRUE) |>
    dplyr::mutate(end_date = dttr2::dtt_dayte(end_date, start_date),
                  start_date = start_dayte) |>
    dplyr::select(c("year", "start_date", "end_date", "atus"))                  
  x
}
