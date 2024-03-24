#' Calculate Growing Season Degree Days (GSDD)
#' 
#' Growing Season Degree Days (GSDD) is a water temperature metric
#' that is a useful predictor of age-0 trout size at the
#' beginning of winter. 
#' It is the accumulated thermal units (in C) 
#' during the growing season based on the mean daily water temperature values.
#' 
#' The GSDD is calculated across the longest consecutive sequence of non-missing
#' values.
#' Truncation occurs when the start and/or end
#' of the sequence of non-missing values is part way through a growing season.
#' If the user chooses to ignore truncation then the returned value
#' very likely to be less than the actual value.
#' 
#' The default values and implementation of the 
#' growing season are based on
#' Coleman and Fausch (2007) who stated that
#'
#' We defined the start of the growing season as the
#' beginning of the first week that average stream temperatures exceeded and
#' remained above 5C for the season;
#' the end of the growing season was defined as
#' the last day of the first week that
#' average stream temperature dropped below 4C.
#'
#' For the purposes of the calculation week refers to a seven day
#' rolling average as opposed to the calendar week.
#' If there are multiple growing 'seasons' within the same year then by
#' default the returned value is the sum of the GSDD values for `"all"` seasons.
#' 
#' The user has the option to pick the `"first"`/`"last"` or
#'  `"longest"`/`"shortest"` season or the season with 
#'  the `"biggest"`/`"smallest"` GSDD.
#'  If the user picks the `"longest"` season but there are multiple seasons
#' with the longest length then the candidate 
#' season with the `"biggest"` GSDD is selected.
#' Conversely in the case of multiple `"shortest"` seasons then the
#' candidate with the `"smallest"` GSDD is selected.
#'
#' @references Coleman, M.A., and Fausch, K.D. 2007. 
#' Cold Summer Temperature Limits Recruitment of Age-0 Cutthroat Trout in 
#' High-Elevation Colorado Streams. 
#' Transactions of the American Fisheries Society 136(5): 1231–1244. 
#' doi:10.1577/T05-244.1.
#' @inheritParams params
#' @return A tibble with two columns `year` and `gsdd`.
#' @seealso [gsdd_vctr()], [gdd()] and [gss()]
#' @export
#'
#' @examples
#' gsdd(gsdd::temperature_data)
gsdd <- function(
    x, 
    start_date = as.Date("1972-03-01"), 
    end_date = as.Date("1972-11-30"), 
    ignore_truncation = FALSE,
    min_length = NULL,
    start_temp = 5,
    end_temp = 4,
    window_width = 7,
    pick = "all",
    msgs = TRUE) {
  
  .gss(
    x, 
    start_date = start_date, 
    end_date = end_date, 
    ignore_truncation = ignore_truncation,
    min_length = min_length,
    start_temp = start_temp,
    end_temp = end_temp,
    window_width = window_width,
    pick = pick,
    msgs = msgs,
    gss = FALSE)
}
