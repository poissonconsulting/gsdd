# date_atus works

    Code
      date_atus
    Output
      # A tibble: 2 x 4
      # Groups:   year [2]
         year start_date end_date    atus
        <int> <date>     <date>     <dbl>
      1  2018 1971-03-01 NA           NA 
      2  2019 1971-03-01 1971-05-11  617.

# date_atus start year independent

    Code
      date_atus
    Output
      # A tibble: 2 x 4
      # Groups:   year [2]
         year start_date end_date    atus
        <int> <date>     <date>     <dbl>
      1  2018 1971-03-01 NA           NA 
      2  2019 1971-03-01 1971-05-11  617.

# date_atus changes if shift start date

    Code
      date_atus
    Output
      # A tibble: 1 x 4
      # Groups:   year [1]
         year start_date end_date    atus
        <int> <date>     <date>     <dbl>
      1  2019 1972-02-01 1972-05-10  601.

# date_atus shift before leap year

    Code
      date_atus
    Output
      # A tibble: 1 x 4
      # Groups:   year [1]
         year start_date end_date    atus
        <int> <date>     <date>     <dbl>
      1  2019 1972-02-28 1972-05-10  600.

# date_atus shift after leap year

    Code
      date_atus
    Output
      # A tibble: 1 x 4
      # Groups:   year [1]
         year start_date end_date    atus
        <int> <date>     <date>     <dbl>
      1  2019 1971-03-01 1971-05-11  617.

# date_atus change atu and date

    Code
      date_atus
    Output
      # A tibble: 1 x 4
      # Groups:   year [1]
         year start_date end_date    atus
        <int> <date>     <date>     <dbl>
      1  2019 1972-01-01 1972-04-20  304.

# date_atus set negative to 0

    Code
      date_atus
    Output
      # A tibble: 1 x 4
      # Groups:   year [1]
         year start_date end_date    atus
        <int> <date>     <date>     <dbl>
      1  2019 1972-01-01 1972-04-20  304.

# date_atus NA if missing

    Code
      date_atus
    Output
      # A tibble: 1 x 4
      # Groups:   year [1]
         year start_date end_date  atus
        <int> <date>     <date>   <dbl>
      1  2019 1972-01-01 NA          NA

# date_atus no rows if no data

    Code
      date_atus
    Output
      # A tibble: 0 x 4
      # i 4 variables: year <int>, start_date <date>, end_date <date>, atus <dbl>

