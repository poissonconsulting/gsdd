# gdd works

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

# gdd shifts by 10

    Code
      gdd
    Output
      # A tibble: 1 x 2
         year   gdd
        <int> <dbl>
      1  2019 3605.

# gdd preserves if shift start date

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

# gdd one message

    Code
      gdd
    Output
      # A tibble: 1 x 2
         year   gdd
        <int> <dbl>
      1  2019    NA

# gdd works shortened

    Code
      gdd
    Output
      # A tibble: 1 x 2
         year   gdd
        <int> <dbl>
      1  2019 3592.

# gdd works very shortened

    Code
      gdd
    Output
      # A tibble: 1 x 2
         year   gdd
        <int> <dbl>
      1  2019  77.0

# gdd present if stops at

    Code
      gdd
    Output
      # A tibble: 1 x 2
         year   gdd
        <int> <dbl>
      1  2019 3605.

# gdd NA if stops before

    Code
      gdd
    Output
      # A tibble: 1 x 2
         year   gdd
        <int> <dbl>
      1  2019    NA

# gdd NA if missing

    Code
      gdd
    Output
      # A tibble: 1 x 2
         year   gdd
        <int> <dbl>
      1  2019    NA

