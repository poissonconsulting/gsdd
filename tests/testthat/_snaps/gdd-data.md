# gdd_data works

    Code
      gdd
    Output
      # A tibble: 1 x 2
         year   gdd
        <int> <dbl>
      1  2019 3605.

---

    Code
      gdd
    Output
      # A tibble: 1 x 2
         year   gdd
        <int> <dbl>
      1  2019 3617.

# gdd_data shifts by 10

    Code
      gdd
    Output
      # A tibble: 1 x 2
         year   gdd
        <int> <dbl>
      1  2019 3605.

# gdd_data preserves if shift start date

    Code
      gdd
    Output
      # A tibble: 1 x 2
         year   gdd
        <int> <dbl>
      1  2019 3605.

---

    Code
      gdd
    Output
      # A tibble: 1 x 2
         year   gdd
        <int> <dbl>
      1  2019 3605.

# gdd_data one message

    Code
      gdd
    Output
      # A tibble: 1 x 2
         year   gdd
        <int> <dbl>
      1  2019    NA

# gdd_data works shortened

    Code
      gdd
    Output
      # A tibble: 1 x 2
         year   gdd
        <int> <dbl>
      1  2019 3592.

# gdd_data works very shortened

    Code
      gdd
    Output
      # A tibble: 1 x 2
         year   gdd
        <int> <dbl>
      1  2019  77.0

# gdd_data NA if stops before

    Code
      gdd
    Output
      # A tibble: 1 x 2
         year   gdd
        <int> <dbl>
      1  2019 3592.

# gdd_data NA if missing

    Code
      gdd
    Output
      # A tibble: 1 x 2
         year   gdd
        <int> <dbl>
      1  2019 3592.

