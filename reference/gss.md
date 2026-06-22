# Calculate Growing Seasons (GSS)

Calculate the start and end and gsdd values of all growing seasons in a
year.

## Usage

``` r
gss(
  x,
  start_date = as.Date("1972-03-01"),
  end_date = as.Date("1972-11-30"),
  min_length = NULL,
  ignore_truncation = FALSE,
  start_temp = 5,
  end_temp = 4,
  window_width = 7,
  pick = "all",
  fun = growth_degdays,
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

  A flag specifying whether to ignore truncation of the mean daily water
  temperature vector or a string of "start", "end", "none" (equivalent
  to FALSE) or "both" (equivalent to TRUE) specifying which type of
  truncation to ignore.

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

- fun:

  A function that takes a non-zero length double vector of mean daily
  water temperature values and returns a double vector of the equivalent
  growth metrics. Must be able to handle `0` values. The growth metrics
  are summed to give GSDD so if they are multiplicative they should be
  logged by the functions and then exponentiated upon return.

- msgs:

  A flag specifying whether to provide messages.

## Value

A tibble with four columns: `year`, `start_dayte`, `end_dayte` and
`gsdd`.

## See also

[`gsdd()`](https://poissonconsulting.github.io/gsdd/reference/gsdd.md)

## Examples

``` r
gss(gsdd::temperature_data)
#> # A tibble: 1 × 5
#> # Groups:   year [1]
#>    year start_dayte end_dayte   gsdd truncation
#>   <int> <date>      <date>     <dbl> <chr>     
#> 1  2019 1971-03-20  1971-11-07 3899. none      
```
