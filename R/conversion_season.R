#' ISO week to season week (numeric). Season week 1 is natural week 30.
#'
#' @param isoweek ISO week in a year (numeric), between 1 and 53. ISO week 53 is season week 23.5
#' @return Season week in numeric
#' @export
#' @examples 
#' isoweek_to_seasonweek_n(31)
isoweek_to_seasonweek_n <- function(isoweek) {
  # take both char/n in input

  # real week 30 is the start of season, week 1
  # original: fhi::x(20)
  if (max(isoweek) > 53 | min(isoweek) < 1) {
    stop("ISO week needs to be between 1 to 53")
  }

  retval <- isoweek
  retval[isoweek >= 30] <- isoweek[isoweek >= 30] - 29
  retval[isoweek < 30] <- isoweek[isoweek < 30] + 23
  retval[isoweek == 53] <- 23.5

  return(retval)
}

#' ISO yearweek to season week (numeric). Season week 1 is natural week 30.
#'
#' @param x ISO yearweek
#' @return Season week in numeric
#' @examples
#' isoyearweek_to_seasonweek_n(c("2021-01"))
#' @export
isoyearweek_to_seasonweek_n <- function(x) {
  isoweek_to_seasonweek_n(isoyearweek_to_isoweek_n(x))
}


#' Season week to ISO week (character). Season week 1 is ISO week 30.
#'
#' @param seasonweek Season week in a year (numeric), between 1 and 52
#' @return ISO week in character
#' @export
#' @examples 
#' seasonweek_to_isoweek_c(31)
seasonweek_to_isoweek_c <- function(seasonweek) {
  # influenza week 1 (x) is real week 30
  if (max(seasonweek) > 52 | min(seasonweek) < 1) {
    stop("seasonweek needs to be between 1 to 52, or 23.5")
  }

  retval <- seasonweek
  retval[seasonweek <= 23] <- seasonweek[seasonweek <= 23] + 29
  retval[seasonweek > 23] <- seasonweek[seasonweek > 23] - 23
  retval[seasonweek == 23.5] <- 53
  # return double digit: 01, 09, 10, 11
  retval <- formatC(retval, width = 2, flag = "0")

  return(retval)
}




#' Season week to ISO week (numeric). Season week 1 is ISO week 30.
#'
#' @param seasonweek Season week in a year, between 1 and 52
#' @return ISO week in numeric
#' @export
#' @examples 
#' seasonweek_to_isoweek_n(31)
seasonweek_to_isoweek_n <- function(seasonweek) {
  # influenza week 1 (x) is real week 30
  if (max(seasonweek) > 52 | min(seasonweek) < 1) {
    stop("seasonweek needs to be between 1 to 52, or 23.5")
  }

  retval <- seasonweek
  retval[seasonweek <= 23] <- seasonweek[seasonweek <= 23] + 29
  retval[seasonweek > 23] <- seasonweek[seasonweek > 23] - 23
  retval[seasonweek == 23.5] <- 53
  return(as.integer(retval))
}

#' ISO yearweek to season.
#'
#' @param x isoyearweek, connected with '-'
#' @return Season, e.g. 2020/2021
#' @examples
#' isoyearweek_to_season_c(c("2021-01", "2021-50"))
#' @export
isoyearweek_to_season_c <- function(x) {
  isoweeks <- isoyearweek_to_isoweek_n(x)
  isoyears <- isoyearweek_to_isoyear_n(x)
  dplyr::case_when(
    isoweeks >= 30 ~ paste0(isoyears, "/", isoyears + 1),
    TRUE ~ paste0(isoyears - 1, "/", isoyears)
  )
}

#' Date to season.
#'
#' @param x date
#' @return Season, e.g. 2020/2021
#' @examples
#' date_to_season_c(c("2021-01-01", "2021-12-01"))
#' @export
date_to_season_c <- function(x) {
  isoyearweek_to_season_c(date_to_isoyearweek_c(x))
}

#' Date to season week.
#'
#' @param x date
#' @return Season week in numeric
#' @examples
#' date_to_seasonweek_n(c("2021-01-01", "2021-12-01"))
#' @export
date_to_seasonweek_n <- function(x) {
  isoyearweek_to_seasonweek_n(date_to_isoyearweek_c(x))
}
