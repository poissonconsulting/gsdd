#' Growing Degree Days Growth Metric
#'
#'
#' @inheritParams params
#' @return A double vector of the growth metric.
#' @family growth
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
#' @return A double vector of the growth metric.
#' @family growth
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
#' @return A double vector of the growth metric.
#' @family growth
#' @export
#'
#' @examples
#' growth_pgti_factory(3,10,17)(1:20)
growth_pgti_factory <- function(Tmin, Topt, Tmax) {
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
}#' Generate Trapezoid Growth Function
#'
#' A function factor to generate trapezoidal growth functions.
#'
#' @inheritParams params
#' @return A double vector of the growth metric.
#' @family growth
#' @export
#'
#' @examples
#' growth_trapezoid_factory(3,10,12,17)(1:20)
growth_trapezoid_factory <- function(Tmin, Topt, Topt2, Tmax) {
  chk_number(Tmin)
  chk_number(Topt)
  chk_number(Topt2)
  chk_number(Tmax)
  chk_gt(Topt)
  chk_gte(Topt2, Topt)
  chk_lt(Tmin, Topt)
  chk_gt(Tmax, Topt2)

  function(x) {
    blw <- 1 - (Topt - x) / (Topt - Tmin)
    abv <- 1 - (x - Topt2) / (Tmax - Topt2)

    y <- rep(1, length(x))
    y[x < Topt] <- blw[x < Topt]
    y[x > Topt2] <- abv[x > Topt2]
    y[y < 0] <- 0
    y
  }
}
