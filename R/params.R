#' Parameters for functions
#'
#' Descriptions of the parameters for functions
#' @param complete A flag specifying whether the vector of water temperatures 
#' represents the complete possible growing period (by default FALSE). 
#' If TRUE a growing season is not considered to be truncated 
#' at the start and/or end if the water temperature is above the threshold
#' at the start and/or ends.
#' @param end_date A Date scalar of the last date 
#' within each year to consider (the year is ignored).
#' @param end_temp A positive real number of the average water temperature
#' at the end of the growing season(s) in C. 
#' It must be greater than or equal to
#' the start temperature.
#' @param ignore_truncation A flag specifying whether to ignore truncation
#' of the mean daily water temperature vector 
#' or a string of "start", "end", "none" (equivalent to FALSE) or "both"
#' (equivalent to TRUE) specifying which type of truncation to ignore.
#' @param latex A flag specifying whether to use LaTeX to include degree
#' symbol in y-axis label.
#' @param min_length A whole number of the minimum length to consider.
#' Must be at least twice the window width but no more than 365.
#' If NULL then set to be the difference between `start_date` and `end_date`
#' (ignoring the year).
#' @param msgs A flag specifying whether to provide messages.
#' @param ncol A count of the number of columns to facet by.
#' @param nrow A count of the number of rows to facet by.
#' @param pick A string specifying whether to pick the
#' "longest", "shortest", "first" or "last" 'season' or the season with the
#' "biggest" or "smallest" GSDD. By default the returned value is the
#' the GSDD value for the "longest" 'season'.
#' @param start_date A Date scalar of the first date 
#' within each year to consider (the year is ignored).
#' #' If `start_date` occurs before the `end_date` (when ignoring the year) 
#' then the window is considered  to span two calendar years.
#' @param start_temp A positive real number of the average water temperature
#' at the start of the growing season(s) in C.
#' @param window_width A positive whole number of the
#' width of the rolling mean window in days. By default 7.
#' @param x A data frame with two columns `date` and `temperature`. 
#' `date`, which must be of class Date provides the dates and 
#' `temperature` which must be a numeric vector provides the 
#' mean daily water temperature in degrees centigrade.
#' @keywords internal
#' @name params
NULL
