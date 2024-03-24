#' Calculate Growing Season Degree Days (GSDD) from a vector
#'
#' Growing Season Degree Days (GSDD) is a water temperature metric
#' that is a useful predictor of Cutthroat trout size at the
#' beginning of winter. 
#' It is the accumulated thermal units (in C) 
#' during the growing season based on the mean daily water temperature values.
#' Only GSDD values calculated using the default values should be considered
#' equivalent to those of Coleman and Fausch (2007).
#' 
#' The GSDD is calculated across the longest consecutive sequence of non-missing
#' values which must be at least twice the window width in length otherwise a 
#' missing value is returned.
#' If the vector includes missing values it is recommended that they are
#' replaced by estimates of the actual values.
#'
#' By default the default values and implementation of the 
#' growing season are based on the interpretation of
#' Coleman and Fausch (2007) who stated that
#'
#' We defined the start of the growing season as the
#' beginning of the first week that average stream temperatures exceeded and
#' remained above 5C for the season;
#' the end of the growing season was defined as
#' the last day of the first week that
#' average stream temperature dropped below 4C.
#'
#' For the purposes of the calculation week is assumed to refer to a seven day
#' rolling average as opposed to the calendar week.
#' 
#' If there are multiple growing 'seasons' within the same year then by
#' default the returned value is the sum of the GSDD values for `"all"` seasons.
#' 
#' The user also has the option to pick the `"first"`/`"last"` or
#'  `"longest"`/`"shortest"` season or the season with 
#'  the `"biggest"`/`"smallest"` GSDD.
#'  If the user picks the `"longest"` season but there are multiple seasons
#' with the longest length then the candidate 
#' season with the `"biggest"` GSDD is selected.
#' Conversely in the case of multiple `"shortest"` seasons then the
#' candidate with the `"smallest"` GSDD is selected.
#' 
#' Truncation occurs when the start and/or end
#' of the time series is part way through a growing season.
#' If the user chooses to ignore truncation then the returned value
#' will be less than the actual GSDD.
#'
#' @param x A numeric vector of the
#' mean daily water temperature values for the period
#' of interest in C. It must be consist of no more than 
#' 366 values.
#' @param ignore_truncation A flag specifying whether to ignore truncation
#' of the mean daily water temperature vector 
#' or a string of "start", "end", "none" (equivalent to FALSE) or "both"
#' (equivalent to TRUE) specifying which type of truncation to ignore.
#' @param start_temp A positive real number of the average water temperature
#' at the start of the growing season in C.
#' @param end_temp A positive real number of the average water temperature
#' at the end of the growing season in C. It must be greater than or equal to
#' the start temperature.
#' @param window_width A positive whole number of the
#' width of the rolling mean window in days. By default 7.
#' @param pick A string specifying whether to pick the
#' "longest", "shortest", "first" or "last" 'season' or the season with the
#' "biggest" or "smallest" GSDD. By default the returned value is the
#' the GSDD value for the "longest" 'season'.
#' @param msgs A flag specifying whether to provide messages.
#' @seealso [`gsdd_data()`]
#' @return A non-negative real number of the GSDD.
#' @export
#'
#' @examples
#' gsdd(c(rep(1, 10), rep(10, 20), rep(1, 200)))
#' gsdd(gsdd::simulated_data$synthetic)
gsdd <- function(x,
                    ignore_truncation = FALSE,
                    start_temp = 5,
                    end_temp = 4,
                    window_width = 7,
                    pick = "longest",
                    msgs = TRUE) {

  chk_string(pick)
  chk_subset(
    pick, 
    c("biggest", "smallest", "longest", "shortest", "first", "last", "all"))
  
  data <- .gss(x, ignore_truncation = ignore_truncation, 
              start_temp = start_temp, end_temp = end_temp,
              window_width = window_width, msgs = msgs)
  
  if(vld_scalar(data)) {
    return(data)
  }
  data <- data |> 
    pick_season(pick)
  
  sum(data$gsdd)
}
