#' Growing Degree Days Growth Metric
#'
#' @inheritParams params
#' @return A double vector of the growth metric.
#' @family growth
#' @export
#'
#' @examples
#' growth_degdays(c(1,2,3,4,5,6,7,8,9,10))
growth_degdays <- function(vec, Tmin = 0) {
  chk_numeric(vec)
  chk_not_any_na(vec)
  chk_number(Tmin)
  chk_gte(Tmin)
  y <- vec
  y[vec <= Tmin] <- 0
  y
}

#' Days Growth Metric
#'
#' @inheritParams params
#' @return A double vector of the growth metric.
#' @family growth
#' @export
#'
#' @examples
#' growth_days(c(1,2,3,4,5,6,7,8,9,10))
growth_days <- function(vec, Tmin = 0) {
  chk_numeric(vec)
  chk_not_any_na(vec)
  chk_number(Tmin)
  chk_gte(Tmin)
  y <- rep(1, length(vec))
  y[vec <= Tmin] <- 0
  y
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

  function(vec) {
    chk_numeric(vec)
    chk_not_any_na(vec)

    y <- (vec - Tmin) * (vec - Tmax)
    y <- y / (y - (vec - Topt)^2)
    y[y < 0] <- 0
    y[vec <= 0] <- 0
    y
  }
}
#' Generate Trapezoid Growth Function
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

  function(vec) {
    chk_numeric(vec)
    chk_not_any_na(vec)

    blw <- 1 - (Topt - vec) / (Topt - Tmin)
    abv <- 1 - (vec - Topt2) / (Tmax - Topt2)

    y <- rep(1, length(vec))
    y[vec < Topt] <- blw[vec < Topt]
    y[vec > Topt2] <- abv[vec > Topt2]
    y[y < 0] <- 0
    y[vec <= 0] <- 0
    y
  }
}
