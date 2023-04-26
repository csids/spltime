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
  UseMethod("date_to_isoyear_c", x)
}

#' @rdname date_to_isoyear_c
#' @export
date_to_isoyear_c.default <- function(x) {
  rep(NA_character_, length(x))
}

#' @rdname date_to_isoyear_c
#' @export
date_to_isoyear_c.character <- function(x = lubridate::today()) {
  conversions_date_c_to[.(x)]$isoyear_c
}

#' @rdname date_to_isoyear_c
#' @export
date_to_isoyear_c.Date <- function(x = lubridate::today()) {
  conversions_date_to[.(x)]$isoyear_c
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
  UseMethod("date_to_isoyear_n", x)
}

#' @rdname date_to_isoyear_n
#' @export
date_to_isoyear_n.default <- function(x) {
  rep(NA_integer_, length(x))
}

#' @rdname date_to_isoyear_n
#' @export
date_to_isoyear_n.character <- function(x = lubridate::today()) {
  conversions_date_c_to[.(x)]$isoyear_n
}

#' @rdname date_to_isoyear_n
#' @export
date_to_isoyear_n.Date <- function(x = lubridate::today()) {
  conversions_date_to[.(x)]$isoyear_n
}

#' ISO week (character) from Date object
#'
#' @param x a Date object or string, in the form of 'yyyy-mm-dd'
#'
#' @return ISO week in character
#' @export
#'
#' @examples
#' date_to_isoweek_c("2021-08-11")
#' date_to_isoweek_c(lubridate::today())
date_to_isoweek_c <- function(x = lubridate::today()) {
  UseMethod("date_to_isoweek_c", x)
}

#' @rdname date_to_isoweek_c
#' @export
date_to_isoweek_c.default <- function(x) {
  rep(NA_character_, length(x))
}

#' @rdname date_to_isoweek_c
#' @export
date_to_isoweek_c.character <- function(x = lubridate::today()) {
  conversions_date_c_to[.(x)]$isoweek_c
}

#' @rdname date_to_isoweek_c
#' @export
date_to_isoweek_c.Date <- function(x = lubridate::today()) {
  conversions_date_to[.(x)]$isoweek_c
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
  UseMethod("date_to_isoweek_n", x)
}

#' @rdname date_to_isoweek_n
#' @export
date_to_isoweek_n.default <- function(x) {
  rep(NA_integer_, length(x))
}

#' @rdname date_to_isoweek_n
#' @export
date_to_isoweek_n.character <- function(x = lubridate::today()) {
  conversions_date_c_to[.(x)]$isoweek_n
}

#' @rdname date_to_isoweek_n
#' @export
date_to_isoweek_n.Date <- function(x = lubridate::today()) {
  conversions_date_to[.(x)]$isoweek_n
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
  UseMethod("date_to_isoyearweek_c", x)
}

#' @rdname date_to_isoyearweek_c
#' @export
date_to_isoyearweek_c.default <- function(x) {
  rep(NA_character_, length(x))
}

#' @rdname date_to_isoyearweek_c
#' @export
date_to_isoyearweek_c.character <- function(x = lubridate::today()) {
  conversions_date_c_to[.(x)]$isoyearweek_c
}

#' @rdname date_to_isoyearweek_c
#' @export
date_to_isoyearweek_c.Date <- function(x = lubridate::today()) {
  conversions_date_to[.(x)]$isoyearweek_c
}

#
# isoyearweek vs isoyear, isoweek ====
#

#' ISO yearweek to year (numeric)
#'
#' This function breaks the string connected with '-' into year/week
#' @param x Year-week, e.g. "2020-19" for 19th week in 2020
#' @return ISO year in numeric
#' @rdname isoyearweek_to_isoyear_n
#' @export
#' 
#' @examples 
#' isoyearweek_to_isoyear_n('2020-10')
isoyearweek_to_isoyear_n <- function(x) {
  UseMethod("isoyearweek_to_isoyear_n", x)
}

#' @rdname isoyearweek_to_isoyear_n
#' @export
isoyearweek_to_isoyear_n.default <- function(x) {
  rep(NA_integer_, length(x))
}

#' @rdname isoyearweek_to_isoyear_n
#' @export
isoyearweek_to_isoyear_n.character <- function(x) {
  conversions_isoyearweek_to[.(x)]$isoyear_n
}

#' ISO yearweek to year (character)
#'
#' This function breaks the string connected with '-' into year/week
#' @param x Year-week, e.g. "2020-19" for 19th week in 2020
#' @return ISO year in character
#' @rdname isoyearweek_to_isoyear_c
#' @export
#' @examples 
#' isoyearweek_to_isoyear_c('2020-10')
isoyearweek_to_isoyear_c <- function(x) {
  UseMethod("isoyearweek_to_isoyear_c", x)
}

#' @rdname isoyearweek_to_isoyear_c
#' @export
isoyearweek_to_isoyear_c.default <- function(x) {
  rep(NA_character_, length(x))
}

#' @rdname isoyearweek_to_isoyear_c
#' @export
isoyearweek_to_isoyear_c.character <- function(x) {
  conversions_isoyearweek_to[.(x)]$isoyear_c
}

#' ISO yearweek to week (numeric)
#'
#' This function breaks the string connected with '-' into year/week
#' @param x Year-week, e.g. "2020-19" for 19th week in 2020
#' @return ISO week in numeric
#' @rdname isoyearweek_to_isoweek_n
#' @export
#' @examples 
#' isoyearweek_to_isoweek_n('2020-19')
isoyearweek_to_isoweek_n <- function(x) {
  UseMethod("isoyearweek_to_isoweek_n", x)
}

#' @rdname isoyearweek_to_isoweek_n
#' @export
isoyearweek_to_isoweek_n.default <- function(x) {
  rep(NA_integer_, length(x))
}

#' @rdname isoyearweek_to_isoweek_n
#' @export
isoyearweek_to_isoweek_n.character <- function(x) {
  conversions_isoyearweek_to[.(x)]$isoweek_n
}

#' ISO yearweek to week (character)
#'
#' This function breaks the string connected with '-' into year/week
#' @param x Year-week, e.g. "2020-19" for 19th week in 2020
#' @return ISO week in character
#' @rdname isoyearweek_to_isoweek_c
#' @export
#' @examples 
#' isoyearweek_to_isoweek_c('2020-19')
isoyearweek_to_isoweek_c <- function(x) {
  UseMethod("isoyearweek_to_isoweek_c", x)
}

#' @rdname isoyearweek_to_isoweek_c
#' @export
isoyearweek_to_isoweek_c.default <- function(x) {
  rep(NA_character_, length(x))
}

#' @rdname isoyearweek_to_isoweek_c
#' @export
isoyearweek_to_isoweek_c.character <- function(x) {
  conversions_isoyearweek_to[.(x)]$isoweek_c
}

#
# Downsizing (isoyear -> isoyearweek/date -> date) ====
#

#' Last ISO yearweek (character) in ISO year
#'
#' Returns the last isoyearweek in the isoyear
#' @param x ISO year, e.g. 2020
#' @return ISO year-week in character, of the last ISO year
#' @rdname isoyear_to_last_isoyearweek_c
#' @examples
#' isoyear_to_last_isoyearweek_c(c(2019, 2019, 2020, 2021))
#' @export
isoyear_to_last_isoyearweek_c <- function(x) {
  UseMethod("isoyear_to_last_isoyearweek_c", x)
}

#' @rdname isoyear_to_last_isoyearweek_c
#' @export
isoyear_to_last_isoyearweek_c.default <- function(x) {
  rep(NA_character_, length(x))
}

#' @rdname isoyear_to_last_isoyearweek_c
#' @export
isoyear_to_last_isoyearweek_c.character <- function(x) {
  conversions_isoyear_c_to[.(x)]$last_isoyearweek_c
}

#' @rdname isoyear_to_last_isoyearweek_c
#' @export
isoyear_to_last_isoyearweek_c.numeric <- function(x) {
  conversions_isoyear_n_to[.(x)]$last_isoyearweek_c
}

#' Last ISO week (numeric) in ISO year
#'
#' Returns the last week in the isoyear
#' @param x ISO year, e.g. 2020
#' @return ISO week in numeric
#' @rdname isoyear_to_last_isoweek_n
#' @examples
#' isoyear_to_last_isoweek_n(c(2019, 2019, 2020, 2021))
#' @export
isoyear_to_last_isoweek_n <- function(x) {
  UseMethod("isoyear_to_last_isoweek_n", x)
}

#' @rdname isoyear_to_last_isoweek_n
#' @export
isoyear_to_last_isoweek_n.default <- function(x) {
  rep(NA_integer_, length(x))
}

#' @rdname isoyear_to_last_isoweek_n
#' @export
isoyear_to_last_isoweek_n.character <- function(x) {
  conversions_isoyear_c_to[.(x)]$last_isoweek_n
}

#' @rdname isoyear_to_last_isoweek_n
#' @export
isoyear_to_last_isoweek_n.numeric <- function(x) {
  conversions_isoyear_n_to[.(x)]$last_isoweek_n
}

#' Last Sunday in ISO year
#'
#' Returns the last Sunday in the isoyear
#' @param x ISO year, e.g. 2020
#' @return Date of the Sunday, for the last week in the isoyear
#' @rdname isoyear_to_last_date
#' @examples
#' isoyear_to_last_date(c(2019, 2019, 2020, 2021))
#' @export
isoyear_to_last_date <- function(x) {
  UseMethod("isoyear_to_last_date", x)
}

#' @rdname isoyear_to_last_date
#' @export
isoyear_to_last_date.default <- function(x) {
  rep(as.Date(NA), length(x))
}

#' @rdname isoyear_to_last_date
#' @export
isoyear_to_last_date.character <- function(x) {
  conversions_isoyear_c_to[.(x)]$last_date
}

#' @rdname isoyear_to_last_date
#' @export
isoyear_to_last_date.numeric <- function(x) {
  conversions_isoyear_n_to[.(x)]$last_date
}

#' Last date in ISO yearweek
#'
#' Returns the Sunday in the isoyearweek
#' @param x ISO yearweek, e.g. "2020-19" for 19th week in 2020
#' @return Date of Sunday of that isoyearweek
#' @rdname isoyearweek_to_last_date
#' @examples
#' isoyearweek_to_last_date(c("2019-19", "2020-01"))
#' @export
isoyearweek_to_last_date <- function(x) {
  UseMethod("isoyearweek_to_last_date", x)
}

#' @rdname isoyearweek_to_last_date
#' @export
isoyearweek_to_last_date.default <- function(x) {
  rep(as.Date(NA), length(x))
}

#' @rdname isoyearweek_to_last_date
#' @export
isoyearweek_to_last_date.character <- function(x) {
  conversions_isoyearweek_to[.(x)]$last_date
}
