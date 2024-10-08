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
    latex = FALSE,
    nrow = NULL,
    ncol = NULL,
    msgs = TRUE) {
  
  rlang::check_installed("ggplot2", reason = "to use this function.")
  rlang::check_installed("latex2exp", reason = "to use this function.")

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
    msgs = msgs
  )

  moving <- paste(window_width, "Day")

  rollmean <- .roll_mean(
    x,
    start_date = start_date,
    end_date = end_date,
    window_width = window_width
  ) |>
    dplyr::mutate(series = moving) |>
    dplyr::filter(!is.na(.data$temperature))

  start_end_temperature <- tibble::tibble(
    temperature = c(start_temp, end_temp),
    threshold = factor(c("Start", "End"), c("Start", "End"))
  )

  start_dayte <- dttr2::dtt_dayte(start_date, start_date)
  end_dayte <- dttr2::dtt_dayte(end_date, start_date)

  data <- x |>
    dplyr::mutate(
      year = dttr2::dtt_study_year(.data$date, start = start_date),
      year = stringr::str_extract(.data$year, "^\\d{4,4}"),
      year = as.integer(.data$year),
      dayte = dttr2::dtt_dayte(.data$date, start_date)
    ) |>
    dplyr::filter(
      .data$dayte >= start_dayte,
      .data$dayte <= end_dayte
    ) |>
    dplyr::mutate(series = "Daily") |>
    dplyr::bind_rows(rollmean) |>
    dplyr::mutate(series = factor(.data$series, c("Daily", moving)))

  range <- range(data$temperature, na.rm = TRUE)
  gss$ymin <- min(c(0, range[1]))
  gss$ymax <- max(c(0, range[2]))

  gss_start <- gss |>
    dplyr::filter(!.data$truncation %in% c("both", "start"))

  gss_end <- gss |>
    dplyr::filter(!.data$truncation %in% c("both", "end"))

  ylab <- if (latex) {
    latex2exp::TeX("Water Temperature $($$^{\\circ}C)$")
  } else {
    "Water Temperature (C)"
  }

  gp <- ggplot2::ggplot(data = data) +
    ggplot2::facet_wrap(~ .data$year, nrow = nrow, ncol = ncol) +
    ggplot2::geom_hline(
      data = start_end_temperature, ggplot2::aes(yintercept = .data$temperature, linetype = .data$threshold),
      color = "#E8613C"
    ) +
    ggplot2::geom_rect(
      data = gss, ggplot2::aes(xmin = .data$start_dayte, xmax = .data$end_dayte, ymin = .data$ymin, ymax = .data$ymax),
      alpha = 1 / 4
    ) +
    ggplot2::geom_segment(
      data = gss, ggplot2::aes(x = .data$start_dayte, xend = .data$end_dayte, y = .data$ymin),
      alpha = 1 / 2
    ) +
    ggplot2::geom_segment(
      data = gss, ggplot2::aes(x = .data$start_dayte, xend = .data$end_dayte, y = .data$ymax),
      alpha = 1 / 2
    ) +
    ggplot2::geom_segment(
      data = gss_start, ggplot2::aes(y = .data$ymin, yend = .data$ymax, x = .data$start_dayte),
      alpha = 1 / 2
    ) +
    ggplot2::geom_segment(
      data = gss_end, ggplot2::aes(y = .data$ymin, yend = .data$ymax, x = .data$end_dayte),
      alpha = 1 / 2
    ) +
    ggplot2::geom_line(ggplot2::aes(x = .data$dayte, y = .data$temperature, group = .data$series, color = .data$series)) +
    ggplot2::scale_x_date("Date", date_labels = "%b", date_breaks = "month") +
    ggplot2::scale_y_continuous(ylab) +
    ggplot2::scale_linetype_manual("Threshold", values = c("dotdash", "dashed")) +
    ggplot2::scale_color_manual("Mean", values = c("#3063A3", "black")) +
    ggplot2::expand_limits(x = c(start_dayte, end_dayte), y = 0) +
    ggplot2::guides(color = ggplot2::guide_legend(order = 1)) +
    NULL

  gp
}
