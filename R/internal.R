.gss_vctr <- function(x,
                      ignore_truncation,
                      min_length,
                      start_temp,
                      end_temp,
                      window_width,
                      pick,
                      complete,
                      msgs,
                      .rollmean = FALSE) {
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
  chk_string(pick)
  chk_subset(
    pick,
    c("biggest", "smallest", "longest", "shortest", "first", "last", "all")
  )
  chk_flag(complete)
  chk_flag(msgs)
  chk_flag(.rollmean)

  if (length(x) < min_length) {
    if (msgs) {
      msg(paste0("`The length of `x` must be at least ", min_length, "."))
    }
    return(NA_real_)
  }
  run <- longest_run(x)
  complete_start <- complete & run[1] == 1L
  complete_end <- complete & run[length(run)] == length(x)
  x <- x[run]
  length_x <- length(x)
  if (length_x < min_length || anyNA(x)) {
    if (msgs) {
      msg(paste0("The length of the longest non-missing sequence in `x` must be at least ", min_length, "."))
    }
    return(NA_real_)
  }
  # create rolling mean vector from x and window width
  rollmean <- zoo::rollmean(x = x, k = window_width)
  length_rollmean <- length(rollmean)
  if (.rollmean) {
    pad <- floor(window_width / 2)
    index <- seq_len(length_rollmean) + pad + run[1] - 1L
    return(tibble::tibble(index = index, temperature = rollmean))
  }

  # pick which indices have values above start temp that begin runs
  start_index <- index_begin_run(rollmean > start_temp)

  # no GSDD if season never starts
  if (!length(start_index)) {
    return(0)
  }
  # if season starts on first day, ignore_truncation left
  if (start_index[1] == 1L) {
    if (!complete_start && ignore_truncation %in% c("none", "end")) {
      if (msgs) {
        msg("The growing season is truncated at the start of the sequence.")
      }
      return(NA_real_)
    }
  }
  # pick which indices have values above and temp that begin runs
  end_index <- index_begin_run(rollmean < end_temp)
  # if season doesnt end ignore_truncation right
  if (!length(end_index) || max(start_index) > max(end_index)) {
    if (!complete_end && ignore_truncation %in% c("none", "start")) {
      if (msgs) {
        msg("The growing season is truncated at the end of the sequence.")
      }
      return(NA_real_)
    }
    end_index <- as.integer(c(end_index, length_rollmean))
  }

  tidyr::expand_grid(
    start_index = start_index,
    end_index = end_index
  ) |>
    dplyr::filter(.data$start_index <= .data$end_index) |>
    dplyr::group_by(.data$start_index) |>
    dplyr::arrange(.data$end_index) |>
    dplyr::slice(1) |>
    dplyr::ungroup() |>
    dplyr::group_by(.data$end_index) |>
    dplyr::arrange(.data$start_index) |>
    dplyr::slice(1) |>
    dplyr::ungroup() |>
    dplyr::mutate(
      end_index = .data$end_index + (as.integer(window_width) - 1L),
      ndays = .data$end_index - .data$start_index + 1L,
      truncation = dplyr::case_when(
        start_index == 1L & end_index == length_x & rollmean[length_rollmean] > end_temp & !complete_start & !complete_end ~ "both",
        start_index == 1L & !complete_start ~ "start",
        end_index == length_x & rollmean[length_rollmean] > end_temp & !complete_end ~ "end",
        TRUE ~ "none"
      )
    ) |>
    dplyr::mutate(gsdd = purrr::map2_dbl(
      .x = .data$start_index,
      .y = .data$end_index,
      .f = sum_vector,
      ..vector = x
    )) |>
    pick_season(pick = pick) |>
    dplyr::select("start_index", "end_index", "gsdd", "truncation") |>
    dplyr::mutate(
      start_index = .data$start_index + run[1] - 1L,
      end_index = .data$end_index + run[1] - 1L
    ) |>
    dplyr::arrange(.data$start_index)
}

leap_study_year <- function(first_date, start_date) {
  study_year <- dttr2::dtt_study_year(first_date, start_date)
  start_dayte <- dttr2::dtt_dayte(start_date, start_date)

  before <- dttr2::dtt_year(start_dayte) == 1972L

  regex <- if (before) "^\\d{4,4}" else "\\d{4,4}$"

  year <- stringr::str_extract(study_year, regex) |>
    as.integer()

  (year %% 4 == 0) & ((year %% 100 != 0) | (year %% 400 == 0))
}

dayte_seq <- function(start_date, end_date, first_date) {
  end_dayte <- dttr2::dtt_dayte(end_date, start_date)
  start_dayte <- dttr2::dtt_dayte(start_date, start_date)
  x <- dplyr::tibble(dayte = dttr2::dtt_seq(start_dayte, end_dayte))

  if (!leap_study_year(first_date, start_date)) {
    leap_dayte <- dttr2::dtt_date("1972-02-29")
    x <- x |>
      dplyr::filter(.data$dayte != leap_dayte)
  }
  x
}

complete_dates <- function(x, start_date, end_date) {
  end_dayte <- dttr2::dtt_dayte(end_date, start_date)
  start_dayte <- dttr2::dtt_dayte(start_date, start_date)

  x <- x |>
    dplyr::mutate(dayte = dttr2::dtt_dayte(.data$date, start = start_date)) |>
    dplyr::filter(.data$dayte >= start_dayte, .data$dayte <= end_dayte) |>
    dplyr::arrange(.data$dayte)

  if (!nrow(x)) {
    return(x)
  }

  y <- dayte_seq(start_date, end_date, min(x$date))

  x <- x |>
    dplyr::right_join(y, by = "dayte") |>
    dplyr::arrange(.data$dayte)

  x
}

.roll_mean <- function(
    x,
    start_date,
    end_date,
    window_width) {
  check_data(x, list(date = dttr2::dtt_date("1970-01-01"), temperature = c(1, NA)))
  chk_date(start_date)
  chk_date(end_date)

  end_dayte <- dttr2::dtt_dayte(end_date, start_date)
  start_dayte <- dttr2::dtt_dayte(start_date, start_date)

  x <- x |>
    dplyr::mutate(
      date = dttr2::dtt_date(.data$date)
    ) |>
    check_key("date", x_name = "x") |>
    dplyr::arrange(.data$date)

  x <- x |>
    dplyr::mutate(
      year = dttr2::dtt_study_year(.data$date, start = start_date),
      year = stringr::str_extract(.data$year, "^\\d{4,4}"),
      year = as.integer(.data$year)
    ) |>
    dplyr::group_by(.data$year) |>
    dplyr::group_modify(~ complete_dates(.x, start_date, end_date)) |>
    dplyr::group_modify(~ gss_vctr(
      .x$temperature,
      ignore_truncation = TRUE,
      min_length = window_width * 2,
      start_temp = 5,
      end_temp = 4,
      window_width = window_width,
      msgs = FALSE,
      complete = TRUE,
      .rollmean = TRUE
    ), .keep = TRUE)

  if (!nrow(x)) {
    return(tibble::tibble(
      year = integer(), dayte = as.Date(integer()),
      temperature = numeric()
    ))
  }
  x <- x |>
    dplyr::mutate(
      .start_dayte = start_dayte,
      dayte = dttr2::dtt_add_days(.data$.start_dayte, .data$index - 1L)
    ) |>
    dplyr::select("year", "dayte", "temperature")

  return(x)
}

.gss <- function(
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
    gss = TRUE) {
  check_data(x, list(date = dttr2::dtt_date("1970-01-01"), temperature = c(1, NA)))
  chk_date(start_date)
  chk_date(end_date)
  chk_null_or(min_length, vld = vld_whole_number)

  end_dayte <- dttr2::dtt_dayte(end_date, start_date)
  start_dayte <- dttr2::dtt_dayte(start_date, start_date)

  x <- x |>
    dplyr::mutate(
      date = dttr2::dtt_date(.data$date)
    ) |>
    check_key("date", x_name = "x") |>
    dplyr::arrange(.data$date)

  x <- x |>
    dplyr::mutate(
      year = dttr2::dtt_study_year(.data$date, start = start_date),
      year = stringr::str_extract(.data$year, "^\\d{4,4}"),
      year = as.integer(.data$year)
    ) |>
    dplyr::group_by(.data$year) |>
    dplyr::group_modify(~ complete_dates(.x, start_date, end_date))

  if (is.null(min_length)) {
    min_length <- max(min(as.integer(end_dayte) - as.integer(start_dayte), 364L), 1L)
  }

  if (isFALSE(gss)) {
    x <- x |>
      dplyr::summarise(gsdd = gsdd_vctr(
        .data$temperature,
        ignore_truncation = ignore_truncation,
        min_length = min_length,
        start_temp = start_temp,
        end_temp = end_temp,
        window_width = window_width,
        pick = pick,
        complete = TRUE,
        msgs = msgs
      ), .groups = "keep") |>
      dplyr::ungroup()

    return(x)
  }

  if (isTRUE(gss)) {
    x <- x |>
      dplyr::group_modify(~ gss_vctr(
        .x$temperature,
        ignore_truncation = ignore_truncation,
        min_length = min_length,
        start_temp = start_temp,
        end_temp = end_temp,
        window_width = window_width,
        pick = pick,
        complete = TRUE,
        msgs = msgs
      ), .keep = TRUE)

    if (!nrow(x)) {
      return(tibble::tibble(
        year = integer(), start_dayte = as.Date(integer()),
        end_dayte = as.Date(integer()), gsdd = numeric(), truncation = character()
      ))
    }
    x <- x |>
      dplyr::mutate(
        .start_dayte = start_dayte,
        start_dayte = dttr2::dtt_add_days(.data$.start_dayte, .data$start_index - 1L),
        end_dayte = dttr2::dtt_add_days(.data$.start_dayte, .data$end_index - 1L),
      ) |>
      dplyr::select("year", "start_dayte", "end_dayte", "gsdd", "truncation")

    return(x)
  }
  x <- x |>
    dplyr::filter(!is.na(.data$temperature)) |>
    dplyr::summarise(last_dayte = max(.data$dayte)) |>
    dplyr::ungroup()

  x$end_dayte <- end_dayte
  x
}

pick_season <- function(x, pick) {
  if (pick == "all") {
    return(x)
  }

  x <- if (pick == "biggest") {
    x |> dplyr::filter(.data$gsdd == max(.data$gsdd))
  } else if (pick == "smallest") {
    x |> dplyr::filter(.data$gsdd == min(.data$gsdd))
  } else if (pick == "longest") {
    x |>
      dplyr::filter(.data$ndays == max(.data$ndays)) |>
      dplyr::arrange(dplyr::desc(.data$gsdd))
  } else if (pick == "shortest") {
    x |>
      dplyr::filter(.data$ndays == min(.data$ndays)) |>
      dplyr::arrange(.data$gsdd)
  } else if (pick == "last") {
    x |> dplyr::filter(.data$start_index == max(.data$start_index))
  } else if (pick == "first") {
    x |> dplyr::filter(.data$start_index == min(.data$start_index))
  }
  x |>
    dplyr::slice(1)
}
