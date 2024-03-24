# Gets triangle

    Code
      tibble::tibble(index = 1:length(x), x = x, ma = ma)
    Output
      # A tibble: 184 x 3
         index     x    ma
         <int> <dbl> <dbl>
       1     1    -5    NA
       2     2    -4    NA
       3     3    -3    NA
       4     4    -2    -2
       5     5    -1    -1
       6     6     0     0
       7     7     1     1
       8     8     2     2
       9     9     3     3
      10    10     4     4
      # i 174 more rows

# Gets asymmetric triangle

    Code
      tibble::tibble(index = 1:length(x), x = x, ma = ma)
    Output
      # A tibble: 184 x 3
         index     x    ma
         <int> <dbl> <dbl>
       1     1    -5    NA
       2     2    -4    NA
       3     3    -3    NA
       4     4    -2    -2
       5     5    -1    -1
       6     6     0     0
       7     7     1     1
       8     8     2     2
       9     9     3     3
      10    10     4     4
      # i 174 more rows

# 2 asymetric triangles, first one longer but lower, second should be chosen.

    Code
      tibble::tibble(index = 1:length(x), x = x, ma = ma)
    Output
      # A tibble: 184 x 3
         index     x     ma
         <int> <dbl>  <dbl>
       1     1   0   NA    
       2     2   0   NA    
       3     3   0   NA    
       4     4   0    0.429
       5     5   0.5  0.714
       6     6   1    1.07 
       7     7   1.5  1.5  
       8     8   2    2    
       9     9   2.5  2.5  
      10    10   3    3    
      # i 174 more rows

# 2 asymetric triangles, first one longer but lower, second should be chosen unless longest.

    Code
      tibble::tibble(index = 1:length(x), x = x, ma = ma)
    Output
      # A tibble: 184 x 3
         index     x     ma
         <int> <dbl>  <dbl>
       1     1   0   NA    
       2     2   0   NA    
       3     3   0   NA    
       4     4   0    0.429
       5     5   0.5  0.714
       6     6   1    1.07 
       7     7   1.5  1.5  
       8     8   2    2    
       9     9   2.5  2.5  
      10    10   3    3    
      # i 174 more rows

# 2 asymetric triangles, second one longer but lower, first one should be chosen.

    Code
      tibble::tibble(index = 1:length(x), x = x, ma = ma)
    Output
      # A tibble: 184 x 3
         index     x    ma
         <int> <dbl> <dbl>
       1     1     0 NA   
       2     2     0 NA   
       3     3     0 NA   
       4     4     2  2.86
       5     5     4  4.29
       6     6     6  6   
       7     7     8  8   
       8     8    10 10   
       9     9    12 12   
      10    10    14 14   
      # i 174 more rows

# Right truncated triangle

    Code
      tibble::tibble(index = 1:length(x), x = x, ma = ma)
    Output
      # A tibble: 184 x 3
         index     x    ma
         <int> <dbl> <dbl>
       1     1     0    NA
       2     2     0    NA
       3     3     0    NA
       4     4     0     0
       5     5     0     0
       6     6     0     0
       7     7     0     0
       8     8     0     0
       9     9     0     0
      10    10     0     0
      # i 174 more rows

# Left truncated triangle

    Code
      tibble::tibble(index = 1:length(x), x = x, ma = ma)
    Output
      # A tibble: 184 x 3
         index     x    ma
         <int> <dbl> <dbl>
       1     1     6  NA  
       2     2     8  NA  
       3     3    10  NA  
       4     4    12  12  
       5     5    14  14  
       6     6    16  16  
       7     7    18  18  
       8     8    20  19.9
       9     9    22  21.1
      10    10    24  21.9
      # i 174 more rows

