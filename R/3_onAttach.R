#' @import data.table
#' @importFrom magrittr %>%
.onAttach <- function(libname, pkgname) {
  version <- tryCatch(
    utils::packageDescription("cstime", fields = "Version"),
    warning = function(w) {
      1
    }
  )

  packageStartupMessage(paste0(
    "cstime ",
    version,
    "\n",
    "https://www.csids.no/cstime/"
  ))
}
