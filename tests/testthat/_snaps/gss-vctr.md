# output is a numeric value

    Code
      gss
    Output
      # A tibble: 1 x 3
        start_index end_index  gsdd
              <int>     <int> <dbl>
      1          79       311 3899.

# gss returns no rows when missing summer

    Code
      gss
    Output
      # A tibble: 0 x 3
      # i 3 variables: start_index <int>, end_index <int>, gsdd <dbl>

# gss trims missing values

    Code
      gss
    Output
      # A tibble: 1 x 3
        start_index end_index  gsdd
              <int>     <int> <dbl>
      1          78       310 3899.

# if max temp in vector is lower than start_temp the function return no row

    Code
      gss
    Output
      # A tibble: 0 x 3
      # i 3 variables: start_index <int>, end_index <int>, gsdd <dbl>

# if end_temp is reached at end of vector x, indicies do not fall off the edge

    Code
      gss
    Output
      # A tibble: 1 x 3
        start_index end_index  gsdd
              <int>     <int> <dbl>
      1          79       365 3922.

# if start_temp is reached at start of vector x, indicies do not fall off the edge

    Code
      gss1
    Output
      # A tibble: 0 x 3
      # i 3 variables: start_index <int>, end_index <int>, gsdd <dbl>
    Code
      gss2
    Output
      # A tibble: 1 x 3
        start_index end_index  gsdd
              <int>     <int> <dbl>
      1           1       149 2688.

# growth period with biggest GSDD even though shorter period.

    Code
      gss
    Output
      # A tibble: 2 x 3
        start_index end_index  gsdd
              <int>     <int> <dbl>
      1         101       151   500
      2         200       242   800

# growth period with higher GSDD even though shorter period.

    Code
      gss1
    Output
      # A tibble: 0 x 3
      # i 3 variables: start_index <int>, end_index <int>, gsdd <dbl>
    Code
      gss2
    Output
      # A tibble: 2 x 3
        start_index end_index  gsdd
              <int>     <int> <dbl>
      1           1        51   500
      2         305       345   800

# Gets gss with single boiling day.

    Code
      gss
    Output
      # A tibble: 1 x 3
        start_index end_index  gsdd
              <int>     <int> <dbl>
      1          95       108   100

# Gets gss with single hot day.

    Code
      gss
    Output
      # A tibble: 1 x 3
        start_index end_index  gsdd
              <int>     <int> <dbl>
      1          95       108    36

# Gets 0 gss with single warm day.

    Code
      gss
    Output
      # A tibble: 0 x 3
      # i 3 variables: start_index <int>, end_index <int>, gsdd <dbl>

