# Generate Trapezoid Growth Function

A function factor to generate trapezoidal growth functions.

## Usage

``` r
growth_trapezoid_factory(Tmin, Topt, Topt2, Tmax)
```

## Arguments

- Tmin:

  A positive real number of the minimum mean daily water temperature for
  growth.

- Topt:

  A positive real number of the optimum mean daily water temperature for
  growth.

- Topt2:

  A positive real number of the upper optimum mean daily water
  temperature for growth.

- Tmax:

  A positive real number of the maximum mean daily water temperature for
  growth.

## Value

A double vector of the growth metric.

## See also

Other growth:
[`growth_days()`](https://poissonconsulting.github.io/gsdd/reference/growth_days.md),
[`growth_degdays()`](https://poissonconsulting.github.io/gsdd/reference/growth_degdays.md),
[`growth_pgti_factory()`](https://poissonconsulting.github.io/gsdd/reference/growth_pgti_factory.md)

## Examples

``` r
growth_trapezoid_factory(3,10,12,17)(1:20)
#>  [1] 0.0000000 0.0000000 0.0000000 0.1428571 0.2857143 0.4285714 0.5714286
#>  [8] 0.7142857 0.8571429 1.0000000 1.0000000 1.0000000 0.8000000 0.6000000
#> [15] 0.4000000 0.2000000 0.0000000 0.0000000 0.0000000 0.0000000
```
