.gss <- function(x,
                 ignore_truncation,
                 min_length,
                 start_temp,
                 end_temp,
                 window_width,
                 msgs) {
  chk_numeric(x)
  chk_vector(x)
  chk_lte(length(x), 366)
  chkor_vld(vld_flag(ignore_truncation), vld_string(ignore_truncation))
  if (isTRUE(ignore_truncation)) {
    ignore_truncation <- "both"
  } else if (isFALSE(ignore_truncation)) {
    ignore_truncation <- "none"
  }
  chk_subset(ignore_truncation, c("none", "start", "end", "both"))
  chk_whole_number(min_length)
  chk_range(min_length, c(window_width * 2, 365))
  chk_number(start_temp)
  chk_number(end_temp)
  chk_gt(start_temp)
  chk_gte(start_temp, end_temp)
  chk_count(window_width)
  chk_range(window_width, c(3, 14))
  if (is_even(window_width)) {
    abort_chk("`window_width` must be odd.")
  }
  chk_flag(msgs)
  
  if(length(x) < min_length) {
    if (msgs) {
      msg(paste0("`The length of `x` must be at least ", min_length, "."))
    }
    return(NA_real_)
  }
  x <- longest_run(x)
  if(length(x) < min_length || anyNA(x)) {
    if(msgs) {
      msg(paste0("The length of the longest non-missing sequence in `x` must be at least ", min_length, "."))
    }
    return(NA_real_)
  }
  # create rolling mean vector from x and window width
  rollmean <- zoo::rollmean(x = x, k = window_width)
  
  # pick which indices have values above start temp that begin runs
  start_index <- index_begin_run(rollmean > start_temp)
  
  # no GSDD if season never starts
  if (!length(start_index)) {
    return(0)
  }
  truncated <- FALSE
  # if season starts on first day, ignore_truncation left
  if (start_index[1] == 1L) {
    truncated <- TRUE
    if (ignore_truncation %in% c("none", "end")) {
      if (msgs) {
        msg("The growing season is truncated at the start of the sequence.")
      }
      return(NA_real_)
    }
  }
  # pick which indices have values above and temp that begin runs
  index_end <- index_begin_run(rollmean < end_temp)
  # if season doesnt end ignore_truncation right
  if (!length(index_end) || max(start_index) > max(index_end)) {
    if (ignore_truncation %in% c("none", "start")) {
      if (msgs) {
        msg("The growing season is truncated at the end of the sequence.")
      }
      return(NA_real_)
    }
    index_end <- as.integer(c(index_end, length(rollmean)))
  }
  
  tidyr::expand_grid(
    start_index = start_index,
    index_end = index_end
  ) |>
    dplyr::filter(.data$start_index <= .data$index_end) |>
    dplyr::group_by(.data$start_index) |>
    dplyr::arrange(.data$index_end) |>
    dplyr::slice(1) |>
    dplyr::ungroup() |>
    dplyr::group_by(.data$index_end) |>
    dplyr::arrange(.data$start_index) |>
    dplyr::slice(1) |>
    dplyr::ungroup() |>
    dplyr::mutate(
      index_end = .data$index_end + (as.integer(window_width) - 1L),
      ndays = .data$index_end - .data$start_index + 1L
    ) |>
    dplyr::mutate(gsdd = purrr::map2_dbl(
      .x = .data$start_index,
      .y = .data$index_end,
      .f = sum_vector,
      ..vector = x
    ))
}

.gsdd <- function(
    x, 
    start_date, 
    end_date, 
    ignore_truncation,
    min_length,
    start_temp,
    end_temp,
    window_width,
    pick,
    msgs,
    gss = FALSE) {
  check_data(x, list(date = dttr2::dtt_date("1970-01-01"), temperature = c(1, NA)))
  chk_date(start_date)
  chk_date(end_date)
  chk_null_or(min_length, vld = vld_whole_number)
  
  end_dayte <- dttr2::dtt_dayte(end_date, start_date)
  start_dayte <- dttr2::dtt_dayte(start_date, start_date)
  
  x <- x |>
    dplyr::mutate(
      date = dttr2::dtt_date(.data$date)) |>
    check_key("date", x_name = "x") |>
    dplyr::arrange(.data$date)
  
  x <- x |>
    dplyr::mutate(
      year = dttr2::dtt_study_year(.data$date, start = start_date),
      year = stringr::str_extract(.data$year, "^\\d{4,4}"),
      year = as.integer(.data$year),
      dayte = dttr2::dtt_dayte(.data$date, start = start_date)) |>
    dplyr::filter(.data$dayte >= start_dayte, .data$dayte <= end_dayte) |>
    dplyr::group_by(.data$year) |>
    dplyr::arrange(.data$dayte)
  
  if(is.null(min_length)) {
    min_length <- max(min(as.integer(end_dayte) - as.integer(start_dayte), 364L), 1L)
  }

  gsdd <- x |>
    dplyr::summarise(gsdd = gsdd_vctr(
      .data$temperature,     
      ignore_truncation = ignore_truncation, min_length = min_length, msgs = msgs, start_temp, end_temp = end_temp, window_width = window_width, pick = pick), .groups = "keep") |>
    dplyr::ungroup()
  
  if(!gss) {
    return(gsdd)
  }
  
  x <- x |>
    dplyr::group_modify(~gss_vctr(
      .x$temperature,
      ignore_truncation = ignore_truncation, 
      min_length = min_length,
      start_temp = start_temp,
      end_temp = end_temp, 
      window_width = window_width, 
      pick = pick,
      msgs = FALSE), .keep = TRUE)
  
  if(!nrow(x)) {
    return(tibble::tibble(year = integer(), start_dayte = as.Date(integer()),
                          end_dayte = as.Date(integer()), gsdd = numeric()))
  }
  x |>
    dplyr::mutate(.start_dayte = start_dayte,
                  start_dayte = dttr2::dtt_add_days(.data$.start_dayte, .data$start_index - 1L),
                  end_dayte = dttr2::dtt_add_days(.data$.start_dayte, .data$end_index - 1L),
    ) |>
    dplyr::select("year", "start_dayte", "end_dayte", "gsdd")
}

pick_season <- function(x, pick) {
  if(pick == "all") {
    return(x)
  }
  
  x <- if(pick == "biggest") {
    x |> dplyr::filter(.data$gsdd == max(.data$gsdd))
  } else if(pick == "smallest") {
    x |> dplyr::filter(.data$gsdd == min(.data$gsdd))
  } else if(pick == "longest") {
    x |> dplyr::filter(.data$ndays == max(.data$ndays)) |>
      dplyr::arrange(dplyr::desc(.data$gsdd))
  } else if(pick == "shortest") {
    x |> dplyr::filter(.data$ndays == min(.data$ndays))  |>
      dplyr::arrange(.data$gsdd)
  } else if(pick == "last") {
    x |> dplyr::filter(.data$start_index == max(.data$start_index))
  } else if(pick == "first") {
    x |> dplyr::filter(.data$start_index == min(.data$start_index))
  }
  x |>
    dplyr::slice(1)
}
