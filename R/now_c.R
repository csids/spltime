#' Current time as character
#' @param format Defaults to %Y-%m-%d %H:%M:%S
#' @export
now_c <- function(format = "%Y-%m-%d %H:%M:%S"){
  format(Sys.time(), format)
}
