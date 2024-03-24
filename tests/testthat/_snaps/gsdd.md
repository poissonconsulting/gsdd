# gsdd works

    Code
      gsdd
    Output
      # A tibble: 1 x 2
         year  gsdd
        <int> <dbl>
      1  2019 3899.

# gsdd NA if earlier truncation

    Code
      gsdd
    Output
      # A tibble: 1 x 2
         year  gsdd
        <int> <dbl>
      1  2019    NA

# gsdd NA if truncated

    Code
      gsdd
    Output
      # A tibble: 1 x 2
         year  gsdd
        <int> <dbl>
      1  2019    NA

# gsdd ignore truncation

    Code
      gsdd
    Output
      # A tibble: 1 x 2
         year  gsdd
        <int> <dbl>
      1  2019  545.

# gsdd ignore truncation tiny window

    Code
      gsdd
    Output
      # A tibble: 1 x 2
         year  gsdd
        <int> <dbl>
      1  2019  110.

# gsdd multiple years

    Code
      gsdd
    Output
      # A tibble: 2 x 2
         year  gsdd
        <int> <dbl>
      1  1972  117.
      2  2019  110.

# gsdd spans a year

    Code
      gsdd
    Output
      # A tibble: 1 x 2
         year  gsdd
        <int> <dbl>
      1  2019  742.

