# Growing Degree Days Growth Metric

Growing Degree Days Growth Metric

## Usage

``` r
growth_degdays(vec, Tmin = 0)
```

## Arguments

- vec:

  A numeric vector of mean daily water temperature values.

- Tmin:

  A positive real number of the minimum mean daily water temperature for
  growth.

## Value

A double vector of the growth metric.

## See also

Other growth:
[`growth_days()`](https://poissonconsulting.github.io/gsdd/reference/growth_days.md),
[`growth_pgti_factory()`](https://poissonconsulting.github.io/gsdd/reference/growth_pgti_factory.md),
[`growth_trapezoid_factory()`](https://poissonconsulting.github.io/gsdd/reference/growth_trapezoid_factory.md)

## Examples

``` r
growth_degdays(c(1,2,3,4,5,6,7,8,9,10))
#>  [1]  1  2  3  4  5  6  7  8  9 10
```
