# Calculate Growing Degree Days (GDD)

Calculate the number of growing degree days to the specified end date.

## Usage

``` r
gdd(
  x,
  start_date = as.Date("1972-03-01"),
  end_date = as.Date("1972-09-30"),
  min_length = NULL,
  ignore_truncation = FALSE,
  start_temp = 5,
  end_temp = 4,
  window_width = 7,
  pick = "all",
  msgs = TRUE
)
```

## Arguments

- x:

  A data frame with two columns `date` and `temperature`. `date`, which
  must be of class Date provides the dates and `temperature` which must
  be a numeric vector provides the mean daily water temperature in
  degrees centigrade.

- start_date:

  A Date scalar of the first date within each year to consider (the year
  is ignored). \#' If `start_date` occurs before the `end_date` (when
  ignoring the year) then the window is considered to span two calendar
  years.

- end_date:

  A Date scalar of the last date within each year to consider (the year
  is ignored).

- min_length:

  A whole number of the minimum length to consider. Must be at least
  twice the window width but no more than 365. If NULL then set to be
  the difference between `start_date` and `end_date` (ignoring the
  year).

- ignore_truncation:

  A flag specifying whether to ignore start truncation (end truncation
  is always ignored).

- start_temp:

  A positive real number of the average water temperature at the start
  of the growing season(s) in C.

- end_temp:

  A positive real number of the average water temperature at the end of
  the growing season(s) in C. It must be greater than or equal to the
  start temperature.

- window_width:

  A positive whole number of the width of the rolling mean window in
  days. By default 7.

- pick:

  A string specifying whether to pick the "longest", "shortest", "first"
  or "last" 'season' or the season with the "biggest" or "smallest"
  GSDD. By default the returned value is the the GSDD value for the
  "longest" 'season'.

- msgs:

  A flag specifying whether to provide messages.

## Value

A tibble with two columns `year` and `gdd`.

## See also

[`gsdd()`](https://poissonconsulting.github.io/gsdd/reference/gsdd.md)

## Examples

``` r
gdd(gsdd::temperature_data)
#> # A tibble: 1 × 2
#>    year   gdd
#>   <int> <dbl>
#> 1  2019 3605.
```
