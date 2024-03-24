# gss works

    Code
      gss
    Output
      # A tibble: 1 x 4
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd
        <int> <date>      <date>     <dbl>
      1  2019 1971-03-20  1971-11-07 3899.

---

    Code
      gss
    Output
      # A tibble: 1 x 4
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd
        <int> <date>      <date>     <dbl>
      1  2019 1971-03-17  1971-11-10 3920.

# gss before leap year

    Code
      gss
    Output
      # A tibble: 1 x 4
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd
        <int> <date>      <date>     <dbl>
      1  2019 1972-03-19  1972-11-06 3899.

# gss shifts by 10

    Code
      gss
    Output
      # A tibble: 1 x 4
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd
        <int> <date>      <date>     <dbl>
      1  2019 1971-03-20  1971-11-07 3899.

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

# gss preserves if shift before leap year

    Code
      gss
    Output
      # A tibble: 1 x 4
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd
        <int> <date>      <date>     <dbl>
      1  2019 1972-03-19  1972-11-06 3899.

# gss preserves if shift after leap

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
      1  2019 1971-04-11  1971-05-31   500
      2  2019 1971-07-19  1971-08-30   800

# growth period default t2

    Code
      gss
    Output
      # A tibble: 2 x 4
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd
        <int> <date>      <date>     <dbl>
      1  2019 1971-04-08  1971-06-04   500
      2  2019 1971-07-15  1971-09-03   800

---

    Code
      gss
    Output
      # A tibble: 2 x 4
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd
        <int> <date>      <date>     <dbl>
      1  2019 1972-04-07  1972-06-03   500
      2  2019 1972-07-14  1972-09-02   800

---

    Code
      gss
    Output
      # A tibble: 2 x 4
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd
        <int> <date>      <date>     <dbl>
      1  2019 1972-04-07  1972-06-03   500
      2  2019 1972-07-14  1972-09-02   800

---

    Code
      gss
    Output
      # A tibble: 2 x 4
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd
        <int> <date>      <date>     <dbl>
      1  2019 1971-04-08  1971-06-04   500
      2  2019 1971-07-15  1971-09-03   800

# gss biggest

    Code
      gss
    Output
      # A tibble: 1 x 4
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd
        <int> <date>      <date>     <dbl>
      1  2019 1971-07-15  1971-09-03   800

# gss smallest

    Code
      gss
    Output
      # A tibble: 1 x 4
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd
        <int> <date>      <date>     <dbl>
      1  2019 1971-04-08  1971-06-04   500

# gss longest

    Code
      gss
    Output
      # A tibble: 1 x 4
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd
        <int> <date>      <date>     <dbl>
      1  2019 1971-04-08  1971-06-04   500

# gss shortest

    Code
      gss
    Output
      # A tibble: 1 x 4
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd
        <int> <date>      <date>     <dbl>
      1  2019 1971-07-15  1971-09-03   800

# gss first

    Code
      gss
    Output
      # A tibble: 1 x 4
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd
        <int> <date>      <date>     <dbl>
      1  2019 1971-04-08  1971-06-04   500

# gss last

    Code
      gss
    Output
      # A tibble: 1 x 4
      # Groups:   year [1]
         year start_dayte end_dayte   gsdd
        <int> <date>      <date>     <dbl>
      1  2019 1971-07-15  1971-09-03   800
