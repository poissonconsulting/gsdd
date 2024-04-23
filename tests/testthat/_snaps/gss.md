# gss works

    Code
      gss
    Output
      # A tibble: 1 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1971-03-20  1971-11-07 3899. none      

---

    Code
      gss
    Output
      # A tibble: 1 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1971-03-17  1971-11-10 3920. none      

# gss before leap year

    Code
      gss
    Output
      # A tibble: 1 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1972-03-19  1972-11-06 3899. none      

# gss shifts by 10

    Code
      gss
    Output
      # A tibble: 1 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1971-03-20  1971-11-07 3899. none      

# gss preserves if shift start date

    Code
      gss
    Output
      # A tibble: 1 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1972-03-19  1972-11-06 3899. none      

---

    Code
      gss
    Output
      # A tibble: 1 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1971-03-20  1971-11-07 3899. none      

# gss preserves if shift before leap year

    Code
      gss
    Output
      # A tibble: 1 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1972-03-19  1972-11-06 3899. none      

# gss preserves if shift after leap

    Code
      gss
    Output
      # A tibble: 1 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1971-03-20  1971-11-07 3899. none      

# gss one message

    Code
      gss
    Output
      # A tibble: 0 x 5
      # i 5 variables: year <int>, start_dayte <date>, end_dayte <date>, gsdd <dbl>,
      #   truncation <chr>

# gss works shortened

    Code
      gss
    Output
      # A tibble: 0 x 5
      # i 5 variables: year <int>, start_dayte <date>, end_dayte <date>, gsdd <dbl>,
      #   truncation <chr>

# gss works shortened truncated

    Code
      gss
    Output
      # A tibble: 1 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1971-03-20  1971-09-28 3580. end       

# gss NA if stops before

    Code
      gss
    Output
      # A tibble: 0 x 5
      # i 5 variables: year <int>, start_dayte <date>, end_dayte <date>, gsdd <dbl>,
      #   truncation <chr>

# gss NA if missing

    Code
      gss
    Output
      # A tibble: 0 x 5
      # i 5 variables: year <int>, start_dayte <date>, end_dayte <date>, gsdd <dbl>,
      #   truncation <chr>

# growth period with biggest GSDD even though shorter period.

    Code
      gss
    Output
      # A tibble: 2 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1971-04-11  1971-05-31   500 none      
      2  2019 1971-07-19  1971-08-30   800 none      

# growth period default t2

    Code
      gss
    Output
      # A tibble: 2 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1971-04-08  1971-06-04   500 none      
      2  2019 1971-07-15  1971-09-03   800 none      

---

    Code
      gss
    Output
      # A tibble: 2 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1972-04-07  1972-06-03   500 none      
      2  2019 1972-07-14  1972-09-02   800 none      

---

    Code
      gss
    Output
      # A tibble: 2 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1972-04-07  1972-06-03   500 none      
      2  2019 1972-07-14  1972-09-02   800 none      

---

    Code
      gss
    Output
      # A tibble: 2 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1971-04-08  1971-06-04   500 none      
      2  2019 1971-07-15  1971-09-03   800 none      

# gss biggest

    Code
      gss
    Output
      # A tibble: 1 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1971-07-15  1971-09-03   800 none      

# gss smallest

    Code
      gss
    Output
      # A tibble: 1 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1971-04-08  1971-06-04   500 none      

# gss longest

    Code
      gss
    Output
      # A tibble: 1 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1971-04-08  1971-06-04   500 none      

# gss shortest

    Code
      gss
    Output
      # A tibble: 1 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1971-07-15  1971-09-03   800 none      

# gss first

    Code
      gss
    Output
      # A tibble: 1 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1971-04-08  1971-06-04   500 none      

# gss last

    Code
      gss
    Output
      # A tibble: 1 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1971-07-15  1971-09-03   800 none      

# gss truncation start

    Code
      gss
    Output
      # A tibble: 2 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1971-03-02  1971-06-04   736 start     
      2  2019 1971-07-15  1971-09-03   800 none      

# gss truncation end

    Code
      gss
    Output
      # A tibble: 2 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1971-04-08  1971-06-04   500 none      
      2  2019 1971-07-15  1971-11-29  1250 end       

# gss truncation both ends

    Code
      gss
    Output
      # A tibble: 2 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1971-03-02  1971-06-04   736 start     
      2  2019 1971-07-15  1971-11-29  1250 end       

# gss truncation all

    Code
      gss
    Output
      # A tibble: 1 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1971-03-02  1971-11-29  1638 both      

# gss not shift

    Code
      gss
    Output
      # A tibble: 1 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1971-06-08  1971-09-29  738. none      

# gss above from start to finish

    Code
      gss
    Output
      # A tibble: 1 x 5
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd truncation
        <int> <date>      <date>     <dbl> <chr>     
      1  2019 1971-03-01  1971-11-30  1650 none      

# gss truncated if missing

    Code
      gss
    Output
      # A tibble: 0 x 5
      # i 5 variables: year <int>, start_dayte <date>, end_dayte <date>, gsdd <dbl>,
      #   truncation <chr>

