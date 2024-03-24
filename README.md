
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/poissonconsulting/gsdd/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/poissonconsulting/gsdd/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/poissonconsulting/gsdd/branch/main/graph/badge.svg)](https://app.codecov.io/gh/poissonconsulting/gsdd?branch=main)
[![License:
MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
<!-- badges: end -->

# gsdd

## Introduction

`gsdd` is an R package to calculate Growing Season Degree Days (GSDD),
Growing Degree Days (GDD) and Growing Seasons (GSS) from water
temperature data.

GSSD is a water temperature metric that is a useful predictor of age-0
trout size at the beginning of winter. It is the accumulated thermal
units (in C) during the growing season based on the mean daily water
temperature values. GDD is the GSSD to a particular date.

The GSDD is calculated across the longest consecutive sequence of
non-missing values. Truncation occurs when the start and/or end of the
sequence of non-missing values is part way through a growing season. If
the user chooses to ignore truncation then the returned value(s) are
very likely to be less than the actual value(s).

The default values and implementation of the growing season are based on
Coleman and Fausch (2007) who stated that

> We defined the start of the growing season as the beginning of the
> first week that average stream temperatures exceeded and remained
> above 5C for the season; the end of the growing season was defined as
> the last day of the first week that average stream temperature dropped
> below 4C.

For the purposes of the calculation week refers to a seven day rolling
average as opposed to the calendar week. If there are multiple growing
‘seasons’ within the same year then by default the returned value is the
sum of the GSDD values for `"all"` seasons.

### Reference

Coleman, M.A., and Fausch, K.D. 2007. Cold Summer Temperature Limits
Recruitment of Age-0 Cutthroat Trout in High-Elevation Colorado Streams.
Transactions of the American Fisheries Society 136(5): 1231–1244.
<doi:10.1577/T05-244.1>.

## Installation

``` r
install.packages("remotes")
remotes::install_github("poissonconsulting/gsdd")
```

## Implementation

The `gssd` package provides to calculate the GSSD, GDD and GSS from
water temperature data.

``` r
library(gsdd)
data <- gsdd::temperature_data

gsdd(data)
#> # A tibble: 1 × 2
#>    year  gsdd
#>   <int> <dbl>
#> 1  2019 3899.
gdd(data)
#> # A tibble: 1 × 2
#>    year   gdd
#>   <int> <dbl>
#> 1  2019 3605.
gss(data)
#> # A tibble: 1 × 4
#> # Groups:   year [1]
#>    year start_dayte end_dayte   gsdd
#>   <int> <date>      <date>     <dbl>
#> 1  2019 1971-03-20  1971-11-07 3899.
```

It also provides a function to calculate GSDD from a vector.

``` r
x <- gsdd::temperature_data$temperature

gsdd_vctr(x)
#> [1] 3898.806
```

### Multiple Seasons

The user has the option to pick the `"first"`/`"last"` or
`"longest"`/`"shortest"` season or the season with the
`"biggest"`/`"smallest"` GSDD. If the user picks the `"longest"` season
but there are multiple seasons with the longest length then the
candidate season with the `"biggest"` GSDD is selected. Conversely in
the case of multiple `"shortest"` seasons then the candidate with the
`"smallest"` GSDD is selected.

In most cases there will only be one season and the choice will be
immaterial.

However, consider the following edge case with two growing seasons.

``` r
data$temperature <- data$temperature2

gss(data)
#> # A tibble: 2 × 4
#> # Groups:   year [1]
#>    year start_dayte end_dayte   gsdd
#>   <int> <date>      <date>     <dbl>
#> 1  2019 1971-04-08  1971-06-04   500
#> 2  2019 1971-07-15  1971-09-03   800
```

Different selection criteria result in very different answers. In fact
choosing the longest season results in the lowest GSDD! It is for this
reason that the `gsdd` package by default calculates the GSDD and GDD
across `"all"` growing seasons.

``` r
gsdd(data, pick = "longest")
#> # A tibble: 1 × 2
#>    year  gsdd
#>   <int> <dbl>
#> 1  2019   500
gsdd(data, pick = "shortest")
#> # A tibble: 1 × 2
#>    year  gsdd
#>   <int> <dbl>
#> 1  2019   800
gsdd(data)
#> # A tibble: 1 × 2
#>    year  gsdd
#>   <int> <dbl>
#> 1  2019  1300
```
