# Changelog

## gsdd 0.3.0.9001

- Same as previous version.

## gsdd 0.3.0.9000

- Internal changes.

## gsdd 0.3.0

- Added
  [`date_atus()`](https://poissonconsulting.github.io/gsdd/reference/date_atus.md)
  to determine date when ATUs reached.
  ([\#9](https://github.com/poissonconsulting/gsdd/issues/9)).
- Add `latex = FALSE` argument to
  [`gss_plot()`](https://poissonconsulting.github.io/gsdd/reference/gss_plot.md)
  to turn off use of LaTeX to add degree symbol to y-axis label.

## gsdd 0.2.0

- Added `complete = FALSE` argument to
  [`gsdd_vctr()`](https://poissonconsulting.github.io/gsdd/reference/gsdd_vctr.md)
  and `gss_vctr()` to specify whether the vector of water temperatures
  represents the complete growing period.
- Modified
  [`gsdd()`](https://poissonconsulting.github.io/gsdd/reference/gsdd.md),
  [`gdd()`](https://poissonconsulting.github.io/gsdd/reference/gdd.md),
  [`gss()`](https://poissonconsulting.github.io/gsdd/reference/gss.md)
  and
  [`gss_plot()`](https://poissonconsulting.github.io/gsdd/reference/gss_plot.md)
  so that a growing season is not considered to be truncated at the
  start and/or end if the water temperature is above the threshold at
  the start and/or end dates.
- Modified
  [`gss_plot()`](https://poissonconsulting.github.io/gsdd/reference/gss_plot.md)
  so
  - growing season now includes border to indicate if truncated.
  - x-axis now always includes start and end dates.
  - y-axis label now includes degree symbol.
  - Mean and 7 Day instead of Series and Moving in legend.
- Fixed shift in
  [`gss()`](https://poissonconsulting.github.io/gsdd/reference/gss.md)
  when time series starts after start date.

## gsdd 0.1.0

- Added
  [`gss_plot()`](https://poissonconsulting.github.io/gsdd/reference/gss_plot.md)
  to output ggplot object of temperature time series.

## gsdd 0.0.2

- Added `truncation` column to output of
  [`gss()`](https://poissonconsulting.github.io/gsdd/reference/gss.md)
  to indicate if season truncated.

## gsdd 0.0.1

- Added a `NEWS.md` file to track changes to the package.
