# Calculate Date of Accumulated Thermal Units (ATUs)

Calculates the date on which a specified number of Accumulated Thermal
Units (ATUs) are meet or exceeded.

## Usage

``` r
date_atus(x, atus = 600, start_date = as.Date("1972-03-01"))
```

## Arguments

- x:

  A data frame with two columns `date` and `temperature`. `date`, which
  must be of class Date provides the dates and `temperature` which must
  be a numeric vector provides the mean daily water temperature in
  degrees centigrade.

- atus:

  A positive number of the accumulated thermal units to exceed.

- start_date:

  A Date scalar of the first date within each year to consider (the year
  is ignored). \#' If `start_date` occurs before the `end_date` (when
  ignoring the year) then the window is considered to span two calendar
  years.

## Value

A tibble with four columns `year`, `start_date`, `end_date` and `atus`.

## Examples

``` r
date_atus(gsdd::temperature_data)
#> # A tibble: 2 × 4
#> # Groups:   year [2]
#>    year start_date end_date    atus
#>   <int> <date>     <date>     <dbl>
#> 1  2018 1971-03-01 NA           NA 
#> 2  2019 1971-03-01 1971-05-11  617.
```
