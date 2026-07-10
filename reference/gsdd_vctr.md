# Calculate Growing Season Degree Days (GSDD) from a vector

Calculate Growing Season Degree Days (GSDD) from a vector

## Usage

``` r
gsdd_vctr(
  x,
  ignore_truncation = FALSE,
  min_length = 274,
  start_temp = 5,
  end_temp = 4,
  window_width = 7,
  pick = "all",
  fun = growth_degdays,
  complete = FALSE,
  msgs = TRUE
)
```

## Arguments

- x:

  A numeric vector of the mean daily water temperature values for the
  period of interest in C.

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

- complete:

  A flag specifying whether the vector of water temperatures represents
  the complete possible growing period (by default FALSE). If TRUE a
  growing season is not considered to be truncated at the start and/or
  end if the water temperature is above the threshold at the start
  and/or ends.

- msgs:

  A flag specifying whether to provide messages.

## Value

A non-negative real number of the GSDD.

## See also

[`gsdd()`](https://poissonconsulting.github.io/gsdd/reference/gsdd.md)

## Examples

``` r
gsdd_vctr(c(rep(1, 10), rep(10, 20), rep(1, 200)))
#> `The length of `x` must be at least 274.
#> [1] NA
gsdd_vctr(gsdd::temperature_data$temperature)
#> [1] 3898.806
```
