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
    msgs = TRUE) {
  
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop(
      "Package \"ggplot2\" must be installed to use this function.",
      call. = FALSE
    )
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
    pick = pick,
    msgs = msgs)
  
  start_end_temperature <- tibble::tibble(
    temperature = c(start_temp, end_temp),
    threshold = factor(c("Start", "End"), c("Start", "End"))
    )
  
  gp <- x |>
    ggplot2::ggplot() +
    ggplot2::aes(x = .data$date, y = .data$temperature) +
    ggplot2::geom_hline(data = start_end_temperature, ggplot2::aes(yintercept = .data$temperature, linetype = .data$threshold),
                        color = "red") +
    ggplot2::geom_line() +
    ggplot2::scale_x_date("Date", date_labels = "%b", date_breaks = "month") +
    ggplot2::scale_y_continuous("Water Temperature (C)") +
    ggplot2::scale_linetype_manual("Threshold", values = c("dotdash", "dashed")) +
    ggplot2::expand_limits(y = 0) +
    NULL

  gp  
}

