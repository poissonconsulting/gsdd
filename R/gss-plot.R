#' Plot Growing Seasons (GSS)
#' 
#' Plots the growing seasons in a year.
#'
#' @inheritParams params
#' @return A ggplot object.
#' @seealso [gss()]
#' @export
#'
#' @examples
#' gss_plot(gsdd::temperature_data)
gss_plot <- function(
    x, 
    start_date = as.Date("1972-03-01"), 
    end_date = as.Date("1972-11-30"), 
    min_length = NULL,
    ignore_truncation = FALSE,
    start_temp = 5,
    end_temp = 4,
    window_width = 7,
    pick = "all",
    nrow = NULL,
    ncol = NULL,
    msgs = TRUE) {
  
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop(
      "Package \"ggplot2\" must be installed to use this function.",
      call. = FALSE
    )
  }
  
  chk_null_or(nrow, vld = vld_count)
  chk_null_or(ncol, vld = vld_count)
  
  gss <- .gss(
    x, 
    start_date = start_date, 
    end_date = end_date, 
    ignore_truncation = ignore_truncation,
    min_length = min_length,
    start_temp = start_temp,
    end_temp = end_temp,
    window_width = window_width,
    pick = pick,
    msgs = msgs)
  
  moving <- paste(window_width, "Day")
  
  rollmean <- .roll_mean(
    x,
    start_date = start_date, 
    end_date = end_date, 
    window_width = window_width) |>
    dplyr::mutate(series = moving) |>
    dplyr::filter(!is.na(.data$temperature))
  
  start_end_temperature <- tibble::tibble(
    temperature = c(start_temp, end_temp),
    threshold = factor(c("Start", "End"), c("Start", "End"))
  )
  
  data <- x |>
    dplyr::mutate(year = dttr2::dtt_study_year(.data$date, start = start_date),
                  year = stringr::str_extract(.data$year, "^\\d{4,4}"),
                  year = as.integer(.data$year),
                  dayte = dttr2::dtt_dayte(.data$date, start_date)) |>
    dplyr::filter(.data$dayte >= dttr2::dtt_dayte(start_date, start_date),
                  .data$dayte <= dttr2::dtt_dayte(end_date, start_date)) |>
    dplyr::mutate(series = "Daily") |>
    dplyr::bind_rows(rollmean) |>
    dplyr::mutate(series = factor(.data$series, c("Daily", moving)))
  
  range <- range(data$temperature, na.rm = TRUE)
  gss$ymin <- min(c(0, range[1]))
  gss$ymax <- max(c(0, range[2]))
  
  gp <- ggplot2::ggplot(data = data) +
    ggplot2::facet_wrap(~.data$year, nrow = nrow, ncol = ncol) +
    ggplot2::geom_hline(data = start_end_temperature, ggplot2::aes(yintercept = .data$temperature, linetype = .data$threshold),
                        color = "#E8613C") +
    ggplot2::geom_rect(data = gss, ggplot2::aes(xmin = .data$start_dayte, xmax = .data$end_dayte, ymin = .data$ymin, ymax = .data$ymax),
                       alpha = 1/4) +
    ggplot2::geom_line(ggplot2::aes(x = .data$dayte, y = .data$temperature, group = .data$series, color = .data$series)) +
    ggplot2::scale_x_date("Date", date_labels = "%b", date_breaks = "month") +
    ggplot2::scale_y_continuous("Water Temperature (C)") +
    ggplot2::scale_linetype_manual("Threshold", values = c("dotdash", "dashed")) +
    ggplot2::scale_color_manual("Mean", values = c("#3063A3", "black")) +
    ggplot2::expand_limits(y = 0) +
    ggplot2::guides(color = ggplot2::guide_legend(order = 1)) +
    NULL
  
  gp  
}
