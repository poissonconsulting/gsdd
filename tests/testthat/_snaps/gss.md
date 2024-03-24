# gss works

    Code
      gss
    Output
      # A tibble: 1 x 4
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd
        <int> <date>      <date>     <dbl>
      1  2019 1972-03-19  1972-11-06 3899.

---

    Code
      gss
    Output
      # A tibble: 1 x 4
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd
        <int> <date>      <date>     <dbl>
      1  2019 1972-03-16  1972-11-09 3920.

# gss shifts by 10

    Code
      gss
    Output
      # A tibble: 1 x 4
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd
        <int> <date>      <date>     <dbl>
      1  2019 1972-03-09  1972-10-27 3899.

# gss preserves if shift start date

    Code
      gss
    Output
      # A tibble: 1 x 4
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd
        <int> <date>      <date>     <dbl>
      1  2019 1972-03-19  1972-11-06 3899.

---

    Code
      gss
    Output
      # A tibble: 1 x 4
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd
        <int> <date>      <date>     <dbl>
      1  2019 1971-03-20  1971-11-07 3899.

# gss one message

    Code
      gss
    Output
      # A tibble: 0 x 4
      # i 4 variables: year <int>, start_dayte <date>, end_dayte <date>, gsdd <dbl>

# gss works shortened

    Code
      gss
    Output
      # A tibble: 0 x 4
      # i 4 variables: year <int>, start_dayte <date>, end_dayte <date>, gsdd <dbl>

# gss NA if stops before

    Code
      gss
    Output
      # A tibble: 0 x 4
      # i 4 variables: year <int>, start_dayte <date>, end_dayte <date>, gsdd <dbl>

# gss NA if missing

    Code
      gss
    Output
      # A tibble: 0 x 4
      # i 4 variables: year <int>, start_dayte <date>, end_dayte <date>, gsdd <dbl>

# growth period with biggest GSDD even though shorter period.

    Code
      gss
    Output
      # A tibble: 2 x 4
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd
        <int> <date>      <date>     <dbl>
      1  2022 1972-04-10  1972-05-30   500
      2  2022 1972-07-18  1972-08-29   800
