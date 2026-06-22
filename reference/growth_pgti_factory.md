# Generate PGTI Growth Function

A function factor to generate PGTI growth functions.

## Usage

``` r
growth_pgti_factory(Tmin, Topt, Tmax)
```

## Arguments

- Tmin:

  A positive real number of the minimum mean daily water temperature for
  growth.

- Topt:

  A positive real number of the optimum mean daily water temperature for
  growth.

- Tmax:

  A positive real number of the maximum mean daily water temperature for
  growth.

## Value

A double vector of the growth metric.

## See also

Other growth:
[`growth_days()`](https://poissonconsulting.github.io/gsdd/reference/growth_days.md),
[`growth_degdays()`](https://poissonconsulting.github.io/gsdd/reference/growth_degdays.md),
[`growth_trapezoid_factory()`](https://poissonconsulting.github.io/gsdd/reference/growth_trapezoid_factory.md)

## Examples

``` r
growth_pgti_factory(3,10,17)(1:20)
#>  [1] 0.0000000 0.0000000 0.0000000 0.2653061 0.4897959 0.6734694 0.8163265
#>  [8] 0.9183673 0.9795918 1.0000000 0.9795918 0.9183673 0.8163265 0.6734694
#> [15] 0.4897959 0.2653061 0.0000000 0.0000000 0.0000000 0.0000000
```
