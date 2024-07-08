<!-- NEWS.md is maintained by https://fledge.cynkra.com, contributors should not edit this file -->

# gsdd 0.3.0

- Added `date_atus()` to determine date when ATUs reached. (#9).
- Add `latex = FALSE` argument to `gss_plot()` to turn off use of LaTeX to add degree symbol to y-axis label.


# gsdd 0.2.0

-  Added `complete = FALSE` argument to `gsdd_vctr()` and `gss_vctr()` to specify whether the vector of water temperatures represents the complete growing period.
- Modified `gsdd()`, `gdd()`, `gss()` and `gss_plot()` so that a growing season is not considered to be truncated at the start and/or end if the water temperature is above the threshold at the start and/or end dates.
- Modified `gss_plot()` so
  - growing season now includes border to indicate if truncated.
  - x-axis now always includes start and end dates.
  - y-axis label now includes degree symbol.
  - Mean and 7 Day instead of Series and Moving in legend.
- Fixed shift in `gss()` when time series starts after start date.

# gsdd 0.1.0

- Added `gss_plot()` to output ggplot object of temperature time series.


# gsdd 0.0.2

- Added `truncation` column to output of `gss()` to indicate if season truncated.


# gsdd 0.0.1

- Added a `NEWS.md` file to track changes to the package.
