#
# date vs iso ====
#

#' ISO year (character) from Date object
#'
#' @param x a Date object or string, in the form of 'yyyy-mm-dd'
#'
#' @return ISO year in character
#' @export
#'
#' @examples
#' date_to_isoyear_c("2021-08-11")
#' date_to_isoyear_c(lubridate::today())
date_to_isoyear_c <- function(x = lubridate::today()) {
  yr <- format.Date(x, "%G")
  return(yr)
}

#' ISO week (character) from Date object
#'
#' @param x a Date object or string, in the form of 'yyyy-mm-dd'
#'
#' @return ISO week in character
#' @export
#'
#' @examples
#' date_to_isoyear_c("2021-08-11")
#' date_to_isoyear_c(lubridate::today())
date_to_isoweek_c <- function(x = lubridate::today()) {
  # wk <- data.table::isoweek(date)
  # wk <- formatC(wk, flag = "0", width = 2)
  wk <- format.Date(x, "%V")
  return(wk)
}

#' ISO year and week (character) from Date object
#'
#' @param x a Date object or string, in the form of 'yyyy-mm-dd'
#'
#' @return ISO year and week in character
#' @export
#'
#' @examples
#' date_to_isoyearweek_c("2021-08-11")
#' date_to_isoyearweek_c(lubridate::today())
date_to_isoyearweek_c <- function(x = lubridate::today()) {
  return(paste0(date_to_isoyear_c(x), "-", date_to_isoweek_c(x)))
}

#' ISO year (numeric) from Date object
#'
#' @param x a Date object or string, in the form of 'yyyy-mm-dd'
#'
#' @return ISO year in numeric
#' @export
#'
#' @examples
#' date_to_isoyear_n("2021-08-11")
#' date_to_isoyear_n(lubridate::today())
date_to_isoyear_n <- function(x = lubridate::today()) {
  yr <- as.integer(date_to_isoyear_c(x))
  return(yr)
}

#' ISO week (numeric) from Date object
#'
#' @param x a Date object or string, in the form of 'yyyy-mm-dd'
#'
#' @return ISO week in numeric
#' @export
#'
#' @examples
#' date_to_isoweek_n("2021-08-11")
#' date_to_isoweek_n(lubridate::today())
date_to_isoweek_n <- function(x = lubridate::today()) {
  wk <- as.integer(date_to_isoweek_c(x))
  return(wk)
}

#
# isoyearweek vs isoyear, isoweek ====
#

#' ISO yearweek to year (numeric)
#'
#' This function breaks the string connected with '-' into year/week
#' @param yrwk Year-week, e.g. "2020-19" for 19th week in 2020
#' @return ISO year in numeric
#' @export
#' 
#' @examples 
#' isoyearweek_to_isoyear_n('2020-10')
isoyearweek_to_isoyear_n <- function(yrwk) {
  year_n <- stringr::str_split(yrwk, pattern = "-") %>%
    purrr::map_chr(., function(x) {
      x[1]
    }) %>%
    as.integer()
  return(year_n)
}

#' ISO yearweek to year (character)
#'
#' This function breaks the string connected with '-' into year/week
#' @param yrwk Year-week, e.g. "2020-19" for 19th week in 2020
#' @return ISO year in character
#' @export
#' @examples 
#' isoyearweek_to_isoyear_c('2020-10')
isoyearweek_to_isoyear_c <- function(yrwk) {
  year_c <- stringr::str_split(yrwk, pattern = "-") %>%
    purrr::map_chr(., function(x) {
      x[1]
    })
  return(year_c)
}

#' ISO yearweek to week (numeric)
#'
#' This function breaks the string connected with '-' into year/week
#' @param yrwk Year-week, e.g. "2020-19" for 19th week in 2020
#' @return ISO week in numeric
#' @export
#' @examples 
#' isoyearweek_to_isoweek_n('2020-19')
isoyearweek_to_isoweek_n <- function(yrwk) {
  week_n <- stringr::str_split(yrwk, pattern = "-") %>%
    purrr::map_chr(., function(x) {
      x[2]
    }) %>%
    as.integer()
  return(week_n)
}

#' ISO yearweek to week (character)
#'
#' This function breaks the string connected with '-' into year/week
#' @param yrwk Year-week, e.g. "2020-19" for 19th week in 2020
#' @return ISO week in character
#' @export
#' @examples 
#' isoyearweek_to_isoweek_c('2020-19')
isoyearweek_to_isoweek_c <- function(yrwk) {
  week_c <- stringr::str_split(yrwk, pattern = "-") %>%
    purrr::map_chr(., function(x) {
      x[2]
    })
  return(week_c)
}

#
# Downsizing (isoyear -> isoyearweek/date -> date) ====
#

#' Last ISO yearweek (character) in ISO year
#'
#' Returns the last isoyearweek in the isoyear
#' @param x ISO year, e.g. 2020
#' @return ISO year-week in character, of the last ISO year
#' @examples
#' isoyear_to_last_isoyearweek_c(c(2019, 2019, 2020, 2021))
#' @export
isoyear_to_last_isoyearweek_c <- function(x) {
  isoyearweek <- NULL
  x <- as.numeric(x)
  retval <- data.table(isoyear = x)[cstime::dates_by_isoyearweek, on = "isoyear", isoyearweek := isoyearweek]$isoyearweek

  return(retval)
}

#' Last ISO week (numeric) in ISO year
#'
#' Returns the last week in the isoyear
#' @param x ISO year, e.g. 2020
#' @return ISO week in numeric
#' @examples
#' isoyear_to_last_isoweek_n(c(2019, 2019, 2020, 2021))
#' @export
isoyear_to_last_isoweek_n <- function(x) {
  isoyearweek_to_isoweek_n(isoyear_to_last_isoyearweek_c(x))
}

#' Last Sunday in ISO year
#'
#' Returns the last Sunday in the isoyear
#' @param x ISO year, e.g. 2020
#' @return Date of the Sunday, for the last week in the isoyear
#' @examples
#' isoyear_to_last_date(c(2019, 2019, 2020, 2021))
#' @export
isoyear_to_last_date <- function(x) {
  sun <- NULL
  x <- as.numeric(x)
  retval <- data.table(isoyear = x)[cstime::dates_by_isoyearweek, on = "isoyear", sun := sun]$sun

  return(retval)
}

#' Last date in ISO yearweek
#'
#' Returns the Sunday in the isoyearweek
#' @param x ISO yearweek, e.g. "2020-19" for 19th week in 2020
#' @return Date of Sunday of that isoyearweek
#' @examples
#' isoyearweek_to_last_date(c("2019-19", "2020-01"))
#' @export
isoyearweek_to_last_date <- function(x) {
  sun <- NULL
  retval <- data.table(isoyearweek = x)[cstime::dates_by_isoyearweek, on = "isoyearweek", sun := sun]$sun

  return(retval)
}
