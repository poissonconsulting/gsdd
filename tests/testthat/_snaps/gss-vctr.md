# output is a numeric value

    Code
      gss
    Output
      # A tibble: 1 x 4
        start_index end_index  gsdd truncation
              <int>     <int> <dbl> <chr>     
      1          79       311 3899. none      

# gss returns no rows when missing summer

    Code
      gss
    Output
      # A tibble: 0 x 4
      # i 4 variables: start_index <int>, end_index <int>, gsdd <dbl>,
      #   truncation <chr>

# gss trims missing values

    Code
      gss
    Output
      # A tibble: 1 x 4
        start_index end_index  gsdd truncation
              <int>     <int> <dbl> <chr>     
      1          78       310 3899. none      

# if max temp in vector is lower than start_temp the function return no row

    Code
      gss
    Output
      # A tibble: 0 x 4
      # i 4 variables: start_index <int>, end_index <int>, gsdd <dbl>,
      #   truncation <chr>

# if end_temp is reached at end of vector x, indicies do not fall off the edge

    Code
      gss
    Output
      # A tibble: 1 x 4
        start_index end_index  gsdd truncation
              <int>     <int> <dbl> <chr>     
      1          79       365 3922. end       

# if start_temp is reached at start of vector x, indicies do not fall off the edge

    Code
      gss1
    Output
      # A tibble: 0 x 4
      # i 4 variables: start_index <int>, end_index <int>, gsdd <dbl>,
      #   truncation <chr>
    Code
      gss2
    Output
      # A tibble: 1 x 4
        start_index end_index  gsdd truncation
              <int>     <int> <dbl> <chr>     
      1           1       149 2688. start     

# growth period with biggest GSDD even though shorter period.

    Code
      gss
    Output
      # A tibble: 2 x 4
        start_index end_index  gsdd truncation
              <int>     <int> <dbl> <chr>     
      1         101       151   500 none      
      2         200       242   800 none      

# growth period with higher GSDD even though shorter period.

    Code
      gss1
    Output
      # A tibble: 0 x 4
      # i 4 variables: start_index <int>, end_index <int>, gsdd <dbl>,
      #   truncation <chr>
    Code
      gss2
    Output
      # A tibble: 2 x 4
        start_index end_index  gsdd truncation
              <int>     <int> <dbl> <chr>     
      1           1        51   500 start     
      2         305       345   800 end       

# Gets gss with single boiling day.

    Code
      gss
    Output
      # A tibble: 1 x 4
        start_index end_index  gsdd truncation
              <int>     <int> <dbl> <chr>     
      1          95       108   100 none      

# Gets gss with single hot day.

    Code
      gss
    Output
      # A tibble: 1 x 4
        start_index end_index  gsdd truncation
              <int>     <int> <dbl> <chr>     
      1          95       108    36 none      

# Gets 0 gss with single warm day.

    Code
      gss
    Output
      # A tibble: 0 x 4
      # i 4 variables: start_index <int>, end_index <int>, gsdd <dbl>,
      #   truncation <chr>

# pick all

    Code
      gss
    Output
      # A tibble: 2 x 4
        start_index end_index  gsdd truncation
              <int>     <int> <dbl> <chr>     
      1          98       155   500 none      
      2         196       246   800 none      

# pick smallest

    Code
      gss
    Output
      # A tibble: 1 x 4
        start_index end_index  gsdd truncation
              <int>     <int> <dbl> <chr>     
      1          98       155   500 none      

# pick biggest

    Code
      gss
    Output
      # A tibble: 1 x 4
        start_index end_index  gsdd truncation
              <int>     <int> <dbl> <chr>     
      1         196       246   800 none      

# pick longest

    Code
      gss
    Output
      # A tibble: 1 x 4
        start_index end_index  gsdd truncation
              <int>     <int> <dbl> <chr>     
      1          98       155   500 none      

# pick shortest

    Code
      gss
    Output
      # A tibble: 1 x 4
        start_index end_index  gsdd truncation
              <int>     <int> <dbl> <chr>     
      1         196       246   800 none      

# pick first

    Code
      gss
    Output
      # A tibble: 1 x 4
        start_index end_index  gsdd truncation
              <int>     <int> <dbl> <chr>     
      1          98       155   500 none      

# pick last

    Code
      gss
    Output
      # A tibble: 1 x 4
        start_index end_index  gsdd truncation
              <int>     <int> <dbl> <chr>     
      1          98       155   500 none      

