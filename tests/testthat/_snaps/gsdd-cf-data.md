# gsdd_cf_data works

    Code
      gsdd
    Output
      # A tibble: 1 x 2
         year  gsdd
        <int> <dbl>
      1  2019 3899.

# gsdd_cf_data NA if middle truncation

    Code
      gsdd
    Output
      # A tibble: 1 x 2
         year  gsdd
        <int> <dbl>
      1  2019    NA

# gsdd_cf_data NA if earlier truncation

    Code
      gsdd
    Output
      # A tibble: 1 x 2
         year  gsdd
        <int> <dbl>
      1  2019    NA

# gsdd_cf_data NA if truncated

    Code
      gsdd
    Output
      # A tibble: 1 x 2
         year  gsdd
        <int> <dbl>
      1  2019    NA

# gsdd_cf_data ignore truncation

    Code
      gsdd
    Output
      # A tibble: 1 x 2
         year  gsdd
        <int> <dbl>
      1  2019  545.

# gsdd_cf_data ignore truncation tiny window

    Code
      gsdd
    Output
      # A tibble: 1 x 2
         year  gsdd
        <int> <dbl>
      1  2019  93.7

# gsdd_cf_data multiple years

    Code
      gsdd
    Output
      # A tibble: 2 x 2
         year  gsdd
        <int> <dbl>
      1  1972  99.7
      2  2019  93.7

# gsdd_cf_data spans a year

    Code
      gsdd
    Output
      # A tibble: 1 x 2
         year  gsdd
        <int> <dbl>
      1  2019  742.

