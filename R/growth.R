#' Growing Degree Days Growth Metric
#'
#'
#' @inheritParams params
#' @return A double vector of the growing degree days.
#' @seealso [growth_days()]
#' @export
#'
#' @examples
#' growth_gdd(c(1,2,3,4,5,6,7,8,9,10))
growth_gdd <- function(vec) {
  vec
}

#' Days Growth Metric
#'
#'
#' @inheritParams params
#' @return A double vector of the days.
#' @seealso [growth_gdd()]
#' @export
#'
#' @examples
#' growth_days(c(1,2,3,4,5,6,7,8,9,10))
growth_days <- function(vec) {
  rep(1, length(vec))
}


#' Generate PGTI Growth Function
#'
#' A function factor to generate PGTI growth functions.
#'
#' @inheritParams params
#' @return A tibble with two columns `year` and `gdd`.
#' @seealso [gsdd()]
#' @export
#'
#' @examples
#' gdd(gsdd::temperature_data)
pgti_growth_factory <- function(Tmin, Topt, Tmax) {
  chk_number(Tmin)
  chk_number(Topt)
  chk_number(Tmax)
  chk_gt(Topt)
  chk_lt(Tmin, Topt)
  chk_gt(Tmax, Topt)

  function(x) {
    y <- (x - Tmin) * (x - Tmax) 
    x <- y / (y - (x - Topt)^2)
    x[x < 0] <- 0
    x
  }
}

