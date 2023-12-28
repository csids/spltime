library(data.table)

# date_to_cal

date_to_calyear_c_internal <- function(x = lubridate::today()) {
  yr <- format.Date(x, "%Y")
  return(yr)
}

date_to_calyear_n_internal <- function(x) {
  yr <- format.Date(x, "%Y")
  yr <- as.integer(yr)
  return(yr)
}

date_to_calmonth_c_internal <- function(x) {
  # wk <- data.table::isoweek(date)
  # wk <- formatC(wk, flag = "0", width = 2)
  wk <- format.Date(x, "%m")
  return(wk)
}

date_to_calmonth_n_internal <- function(x) {
  # wk <- data.table::isoweek(date)
  # wk <- formatC(wk, flag = "0", width = 2)
  wk <- format.Date(x, "%m")
  wk <- as.integer(wk)
  return(wk)
}

date_to_calyearmonth_c_internal <- function(x) {
  format.Date(x, "%Y-M%m")
}

# date_to_iso

date_to_isoyear_c_internal <- function(x) {
  yr <- format.Date(x, "%G")
  return(yr)
}

date_to_isoyear_n_internal <- function(x) {
  yr <- as.integer(date_to_isoyear_c_internal(x))
  return(yr)
}

date_to_isoweek_c_internal <- function(x) {
  # wk <- data.table::isoweek(date)
  # wk <- formatC(wk, flag = "0", width = 2)
  wk <- format.Date(x, "%V")
  return(wk)
}

date_to_isoweek_n_internal <- function(x) {
  wk <- as.integer(date_to_isoweek_c_internal(x))
  return(wk)
}

date_to_isoyearweek_c_internal <- function(x) {
  return(paste0(date_to_isoyear_c_internal(x), "-", date_to_isoweek_c_internal(x)))
}

date_to_isoquarter_c_internal <- function(x) {
  isoweek <- date_to_isoweek_n_internal(x)
  retval <- 1 + floor((isoweek-1)/13)
  retval[retval==5] <- 4
  retval <- as.character(retval)
  return(retval)
}

date_to_isoquarter_n_internal <- function(x) {
  return(as.numeric(date_to_isoquarter_c_internal(x)))
}

date_to_isoyearquarter_c_internal <- function(x){
  return(paste0(date_to_isoyear_c_internal(x), "-Q", date_to_isoquarter_c_internal(x)))
}

conversions_date_to <- data.table(
  date = c(seq(as.Date("1900-01-01"), as.Date("2200-12-31"), 1), as.Date("9999-09-09"))
)
conversions_date_to[, calyear_c := date_to_calyear_c_internal(date)]
conversions_date_to[, calyear_n := date_to_calyear_n_internal(date)]
conversions_date_to[, calmonth_c := date_to_calmonth_c_internal(date)]
conversions_date_to[, calmonth_n := date_to_calmonth_n_internal(date)]
conversions_date_to[, calyear_c := date_to_calyear_c_internal(date)]
conversions_date_to[, calyearmonth_c := date_to_calyearmonth_c_internal(date)]

conversions_date_to[, isoyear_c := date_to_isoyear_c_internal(date)]
conversions_date_to[, isoyear_n := date_to_isoyear_n_internal(date)]
conversions_date_to[, isoweek_c := date_to_isoweek_c_internal(date)]
conversions_date_to[, isoweek_n := date_to_isoweek_n_internal(date)]
conversions_date_to[, isoyearweek_c := date_to_isoyearweek_c_internal(date)]
conversions_date_to[, isoquarter_c := date_to_isoquarter_c_internal(date)]
conversions_date_to[, isoquarter_n := date_to_isoquarter_n_internal(date)]
conversions_date_to[, isoyearquarter_c := date_to_isoyearquarter_c_internal(date)]
conversions_date_c_to <- copy(conversions_date_to)
conversions_date_c_to[, date := as.character(date)]
setnames(conversions_date_c_to, "date", "date_c")

setkey(conversions_date_to, date)
setkey(conversions_date_c_to, date_c)

# saving internal

env = new.env()
if(file.exists("R/sysdata.rda")) load("R/sysdata.rda", envir = env)

env$conversions_date_to <- conversions_date_to
env$conversions_date_c_to <- conversions_date_c_to

for(i in names(env)){
  .GlobalEnv[[i]] <- env[[i]]
}
txt <- paste0("usethis::use_data(",paste0(names(env),collapse=","),", overwrite = TRUE, internal = TRUE, compress = 'xz', version = 3)")
eval(parse(text = txt))



