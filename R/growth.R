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
