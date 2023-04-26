#' ISO week to season week (numeric). Season week 1 is natural week 30.
#'
#' @param x ISO week in a year (numeric), between 1 and 53. ISO week 53 is season week 23.5
#' @return Season week in numeric
#' @rdname isoweek_to_seasonweek_n
#' @export
#' @examples 
#' isoweek_to_seasonweek_n(31)
isoweek_to_seasonweek_n <- function(x) {
  UseMethod("isoweek_to_seasonweek_n", x)
}

#' @rdname isoweek_to_seasonweek_n
#' @export
isoweek_to_seasonweek_n.default <- function(x) {
  rep(NA_integer_, length(x))
}

#' @rdname isoweek_to_seasonweek_n
#' @export
isoweek_to_seasonweek_n.character <- function(x) {
  conversions_isoweek_c_to[.(x)]$seasonweek_n
}

#' @rdname isoweek_to_seasonweek_n
#' @export
isoweek_to_seasonweek_n.numeric <- function(x) {
  conversions_isoweek_n_to[.(x)]$seasonweek_n
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
#' @param x Season week in a year (numeric), between 1 and 52
#' @return ISO week in character
#' @rdname seasonweek_to_isoweek_c
#' @export
#' @examples 
#' seasonweek_to_isoweek_c(31)
seasonweek_to_isoweek_c <- function(x) {
  UseMethod("seasonweek_to_isoweek_c", x)
}

#' @rdname seasonweek_to_isoweek_c
#' @export
seasonweek_to_isoweek_c.default <- function(x) {
  rep(NA_character_, length(x))
}

#' @rdname seasonweek_to_isoweek_c
#' @export
seasonweek_to_isoweek_c.numeric <- function(x) {
  conversions_seasonweek_to[.(x)]$isoweek_c
}

#' Season week to ISO week (numeric). Season week 1 is ISO week 30.
#'
#' @param x Season week in a year, between 1 and 52
#' @return ISO week in numeric
#' @rdname seasonweek_to_isoweek_n
#' @export
#' @examples 
#' seasonweek_to_isoweek_n(31)
seasonweek_to_isoweek_n <- function(x) {
  UseMethod("seasonweek_to_isoweek_n", x)
}

#' @rdname seasonweek_to_isoweek_n
#' @export
seasonweek_to_isoweek_n.default <- function(x) {
  rep(NA_integer_, length(x))
}

#' @rdname seasonweek_to_isoweek_n
#' @export
seasonweek_to_isoweek_n.numeric <- function(x) {
  conversions_seasonweek_to[.(x)]$isoweek_n
}

#' ISO yearweek to season.
#'
#' @param x isoyearweek, connected with '-'
#' @return Season, e.g. 2020/2021
#' @rdname isoyearweek_to_season_c
#' @examples
#' isoyearweek_to_season_c(c("2021-01", "2021-50"))
#' @export
isoyearweek_to_season_c <- function(x) {
  UseMethod("isoyearweek_to_season_c", x)
}

#' @rdname isoyearweek_to_season_c
#' @export
isoyearweek_to_season_c.default <- function(x) {
  rep(NA_integer_, length(x))
}

#' @rdname isoyearweek_to_season_c
#' @export
isoyearweek_to_season_c.character <- function(x) {
  conversions_isoyearweek_to[.(x)]$season_c
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
