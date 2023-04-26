#
# date -> calyear ====
#

#' Date -> calyear (character)
#'
#' @param x a Date object or string, in the form of 'yyyy-mm-dd'
#'
#' @return ISO year in character
#' @rdname date_to_calyear_c
#' @export
#' @examples
#' date_to_calyear_c("2021-08-11")
#' date_to_calyear_c(lubridate::today())
date_to_calyear_c <- function(x = lubridate::today()) {
  UseMethod("date_to_calyear_c", x)
}

#' @rdname date_to_calyear_c
#' @export
date_to_calyear_c.default <- function(x) {
  rep(NA_character_, length(x))
}

#' @rdname date_to_calyear_c
#' @export
date_to_calyear_c.character <- function(x = lubridate::today()) {
  conversions_date_c_to[.(x)]$calyear_c
}

#' @rdname date_to_calyear_c
#' @export
date_to_calyear_c.Date <- function(x = lubridate::today()) {
  conversions_date_to[.(x)]$calyear_c
}


#' Date -> calyear (numeric)
#'
#' @param x a Date object or string, in the form of 'yyyy-mm-dd'
#'
#' @return ISO year in character
#' @rdname date_to_calyear_n
#' @export
#'
#' @examples
#' date_to_calyear_n("2021-08-11")
#' date_to_calyear_n(lubridate::today())
date_to_calyear_n <- function(x = lubridate::today()) {
  UseMethod("date_to_calyear_n", x)
}

#' @rdname date_to_calyear_n
#' @export
date_to_calyear_n.default <- function(x) {
  rep(NA_integer_, length(x))
}

#' @rdname date_to_calyear_n
#' @export
date_to_calyear_n.character <- function(x = lubridate::today()) {
  conversions_date_c_to[.(x)]$calyear_n
}

#' @rdname date_to_calyear_n
#' @export
date_to_calyear_n.Date <- function(x = lubridate::today()) {
  conversions_date_to[.(x)]$calyear_n
}

#' Date -> calmonth (character)
#'
#' @param x a Date object or string, in the form of 'yyyy-mm-dd'
#'
#' @return calmonth ("XX")
#' @rdname date_to_calmonth_c
#' @export
#'
#' @examples
#' date_to_calmonth_c("2021-08-11")
#' date_to_calmonth_c(lubridate::today())
date_to_calmonth_c <- function(x = lubridate::today()) {
  UseMethod("date_to_calmonth_c", x)
}

#' @rdname date_to_calmonth_c
#' @export
date_to_calmonth_c.default <- function(x) {
  rep(NA_character_, length(x))
}

#' @rdname date_to_calmonth_c
#' @export
date_to_calmonth_c.character <- function(x = lubridate::today()) {
  conversions_date_c_to[.(x)]$calmonth_c
}

#' @rdname date_to_calmonth_c
#' @export
date_to_calmonth_c.Date <- function(x = lubridate::today()) {
  conversions_date_to[.(x)]$calmonth_c
}

#' Date -> calmonth (numeric)
#'
#' @param x a Date object or string, in the form of 'yyyy-mm-dd'
#'
#' @return calmonth
#' @rdname date_to_calmonth_n
#' @export
#'
#' @examples
#' date_to_calmonth_n("2021-08-11")
#' date_to_calmonth_n(lubridate::today())
date_to_calmonth_n <- function(x = lubridate::today()) {
  UseMethod("date_to_calmonth_n", x)
}

#' @rdname date_to_calmonth_n
#' @export
date_to_calmonth_n.default <- function(x) {
  rep(NA_integer_, length(x))
}

#' @rdname date_to_calmonth_n
#' @export
date_to_calmonth_n.character <- function(x = lubridate::today()) {
  conversions_date_c_to[.(x)]$calmonth_n
}

#' @rdname date_to_calmonth_n
#' @export
date_to_calmonth_n.Date <- function(x = lubridate::today()) {
  conversions_date_to[.(x)]$calmonth_n
}

#' Date -> calyearmonth (character)
#'
#' @param x a Date object or string, in the form of 'yyyy-mm-dd'
#'
#' @return calyearmonth ("YYYY-MXX")
#' @rdname date_to_calyearmonth_c
#' @export
#'
#' @examples
#' date_to_calyearmonth_c("2021-08-11")
#' date_to_calyearmonth_c(lubridate::today())
date_to_calyearmonth_c <- function(x = lubridate::today()) {
  UseMethod("date_to_calyearmonth_c", x)
}

#' @rdname date_to_calyearmonth_c
#' @export
date_to_calyearmonth_c.default <- function(x) {
  rep(NA_character_, length(x))
}

#' @rdname date_to_calyearmonth_c
#' @export
date_to_calyearmonth_c.character <- function(x = lubridate::today()) {
  conversions_date_c_to[.(x)]$calyearmonth_c
}

#' @rdname date_to_calyearmonth_c
#' @export
date_to_calyearmonth_c.Date <- function(x = lubridate::today()) {
  conversions_date_to[.(x)]$calyearmonth_c
}

