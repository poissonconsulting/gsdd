# Calculate Growing Season Degree Days (GSDD)

Growing Season Degree Days (GSDD) is a water temperature metric that is
a useful predictor of age-0 trout size at the beginning of winter. It is
the accumulated thermal units (in C) during the growing season based on
the mean daily water temperature values.

## Usage

``` r
gsdd(
  x,
  start_date = as.Date("1972-03-01"),
  end_date = as.Date("1972-11-30"),
  ignore_truncation = FALSE,
  min_length = NULL,
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

- ignore_truncation:

  A flag specifying whether to ignore truncation of the mean daily water
  temperature vector or a string of "start", "end", "none" (equivalent
  to FALSE) or "both" (equivalent to TRUE) specifying which type of
  truncation to ignore.

- min_length:

  A whole number of the minimum length to consider. Must be at least
  twice the window width but no more than 365. If NULL then set to be
  the difference between `start_date` and `end_date` (ignoring the
  year).

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

  A string specifying which 'season' to pick when more than one is
  present. One of "longest", "shortest", "first" or "last", or the
  season with the "biggest" or "smallest" GSDD, or "all" to use every
  season. By default "all".

- fun:

  A function that takes a non-zero length double vector of mean daily
  water temperature values and returns a double vector of the equivalent
  growth metrics. Must be able to handle `0` values. The growth metrics
  are summed to give GSDD so if they are multiplicative they should be
  logged by the functions and then exponentiated upon return.

- msgs:

  A flag specifying whether to provide messages.

## Value

A tibble with two columns `year` and `gsdd`.

## Details

The GSDD is calculated across the longest consecutive sequence of
non-missing values. Truncation occurs when the start and/or end of the
sequence of non-missing values is part way through a growing season. If
the user chooses to ignore truncation then the returned value very
likely to be less than the actual value.

The default values and implementation of the growing season are based on
Coleman and Fausch (2007) who stated that

We defined the start of the growing season as the beginning of the first
week that average stream temperatures exceeded and remained above 5C for
the season; the end of the growing season was defined as the last day of
the first week that average stream temperature dropped below 4C.

For the purposes of the calculation week refers to a seven day rolling
average as opposed to the calendar week. If there are multiple growing
'seasons' within the same year then by default the returned value is the
sum of the GSDD values for `"all"` seasons.

The user has the option to pick the `"first"`/`"last"` or
`"longest"`/`"shortest"` season or the season with the
`"biggest"`/`"smallest"` GSDD. If the user picks the `"longest"` season
but there are multiple seasons with the longest length then the
candidate season with the `"biggest"` GSDD is selected. Conversely in
the case of multiple `"shortest"` seasons then the candidate with the
`"smallest"` GSDD is selected.

## References

Coleman, M.A., and Fausch, K.D. 2007. Cold Summer Temperature Limits
Recruitment of Age-0 Cutthroat Trout in High-Elevation Colorado Streams.
Transactions of the American Fisheries Society 136(5): 1231–1244.
doi:10.1577/T05-244.1.

## See also

[`gsdd_vctr()`](https://poissonconsulting.github.io/gsdd/reference/gsdd_vctr.md),
[`gdd()`](https://poissonconsulting.github.io/gsdd/reference/gdd.md) and
[`gss()`](https://poissonconsulting.github.io/gsdd/reference/gss.md)

## Examples

``` r
gsdd(gsdd::temperature_data)
#> # A tibble: 1 × 2
#>    year  gsdd
#>   <int> <dbl>
#> 1  2019 3899.
```
