#
# date -> calyear ====
#

#' Date -> calyear (character)
#'
#' @param x a Date object or string, in the form of 'yyyy-mm-dd'
#'
#' @return ISO year in character
#' @export
#'
#' @examples
#' date_to_calyear_c("2021-08-11")
#' date_to_calyear_c(lubridate::today())
date_to_calyear_c <- function(x = lubridate::today()) {
  csutil::apply_fn_via_hash_table(x, date_to_calyear_c_internal)
}
date_to_calyear_c_internal <- function(x = lubridate::today()) {
  yr <- format.Date(x, "%Y")
  return(yr)
}

#' Date -> calyear (numeric)
#'
#' @param x a Date object or string, in the form of 'yyyy-mm-dd'
#'
#' @return ISO year in character
#' @export
#'
#' @examples
#' date_to_calyear_n("2021-08-11")
#' date_to_calyear_n(lubridate::today())
date_to_calyear_n <- function(x = lubridate::today()) {
  csutil::apply_fn_via_hash_table(x, date_to_calyear_n_internal)
}
date_to_calyear_n_internal <- function(x) {
  yr <- format.Date(x, "%Y")
  yr <- as.integer(yr)
  return(yr)
}

#' Date -> calmonth (character)
#'
#' @param x a Date object or string, in the form of 'yyyy-mm-dd'
#'
#' @return calmonth ("XX")
#' @export
#'
#' @examples
#' date_to_calmonth_c("2021-08-11")
#' date_to_calmonth_c(lubridate::today())
date_to_calmonth_c <- function(x = lubridate::today()) {
  csutil::apply_fn_via_hash_table(x, date_to_calmonth_c_internal)
}
date_to_calmonth_c_internal <- function(x) {
  # wk <- data.table::isoweek(date)
  # wk <- formatC(wk, flag = "0", width = 2)
  wk <- format.Date(x, "%m")
  return(wk)
}

#' Date -> calmonth (numeric)
#'
#' @param x a Date object or string, in the form of 'yyyy-mm-dd'
#'
#' @return calmonth
#' @export
#'
#' @examples
#' date_to_calmonth_n("2021-08-11")
#' date_to_calmonth_n(lubridate::today())
date_to_calmonth_n <- function(x = lubridate::today()) {
  csutil::apply_fn_via_hash_table(x, date_to_calmonth_n_internal)
}
date_to_calmonth_n_internal <- function(x) {
  # wk <- data.table::isoweek(date)
  # wk <- formatC(wk, flag = "0", width = 2)
  wk <- format.Date(x, "%m")
  wk <- as.integer(wk)
  return(wk)
}

#' Date -> calyearmonth (character)
#'
#' @param x a Date object or string, in the form of 'yyyy-mm-dd'
#'
#' @return calyearmonth ("YYYY-MXX")
#' @export
#'
#' @examples
#' date_to_calyearmonth_c("2021-08-11")
#' date_to_calyearmonth_c(lubridate::today())
date_to_calyearmonth_c <- function(x = lubridate::today()) {
  csutil::apply_fn_via_hash_table(x, date_to_calyearmonth_c_internal)
}
date_to_calyearmonth_c_internal <- function(x) {
  format.Date(x, "%Y-M%m")
}
