devtools::load_all()

isoyearweek_to_isoyear_c_internal <- function(yrwk) {
  year_n <- stringr::str_split(yrwk, pattern = "-") %>%
    purrr::map_chr(., function(x) {
      x[1]
    })
  return(year_n)
}

isoyearweek_to_isoyear_n_internal <- function(yrwk) {
  year_n <- stringr::str_split(yrwk, pattern = "-") %>%
    purrr::map_chr(., function(x) {
      x[1]
    }) %>%
    as.integer()
  return(year_n)
}

isoyearweek_to_isoweek_c_internal <- function(yrwk) {
  week_c <- stringr::str_split(yrwk, pattern = "-") %>%
    purrr::map_chr(., function(x) {
      x[2]
    })
  return(week_c)
}

isoyearweek_to_isoweek_n_internal <- function(yrwk) {
  week_n <- stringr::str_split(yrwk, pattern = "-") %>%
    purrr::map_chr(., function(x) {
      x[2]
    }) %>%
    as.integer()
  return(week_n)
}

isoweek_to_isoquarter_n_internal <- function(isoweek) {
  # take both char/n in input
  retval <- 1 + floor((isoweek-1)/13)
  retval[retval==5] <- 4
  return(retval)
}

isoyearweek_to_isoquarter_c_internal <- function(yrwk) {
  week <- isoyearweek_to_isoweek_n_internal(yrwk)
  quarter <- isoweek_to_isoquarter_n_internal(week)
  return(as.character(quarter))
}

isoyearweek_to_isoquarter_n_internal <- function(yrwk) {
  return(as.numeric(isoyearweek_to_isoquarter_c_internal(yrwk)))
}

isoyearweek_to_isoyearquarter_c_internal <- function(yrwk) {
  paste0(isoyearweek_to_isoyear_c_internal(yrwk),"-Q",isoyearweek_to_isoquarter_c_internal(yrwk))
}

isoyearweek_to_last_date_internal <- function(x) {
  sun <- NULL
  retval <- data.table(isoyearweek = x)[cstime::dates_by_isoyearweek, on = "isoyearweek", sun := sun]$sun
  
  return(retval)
}

isoyearweek_to_season_c_internal <- function(x) {
  isoweeks <- isoyearweek_to_isoweek_n(x)
  isoyears <- isoyearweek_to_isoyear_n(x)
  dplyr::case_when(
    isoweeks >= 30 ~ paste0(isoyears, "/", isoyears + 1),
    TRUE ~ paste0(isoyears - 1, "/", isoyears)
  )
}

conversions_isoyearweek_to <- data.table(
  date = c(seq(as.Date("1900-01-01"), as.Date("2200-12-31"), 1), as.Date("9999-09-09"))
)
conversions_isoyearweek_to[, isoyearweek := date_to_isoyearweek_c(date)]
conversions_isoyearweek_to[, date := NULL]
conversions_isoyearweek_to <- unique(conversions_isoyearweek_to)

conversions_isoyearweek_to[, isoyear_c := isoyearweek_to_isoyear_c_internal(isoyearweek)]
conversions_isoyearweek_to[, isoyear_n := isoyearweek_to_isoyear_n_internal(isoyearweek)]
conversions_isoyearweek_to[, isoweek_c := isoyearweek_to_isoweek_c_internal(isoyearweek)]
conversions_isoyearweek_to[, isoweek_n := isoyearweek_to_isoweek_n_internal(isoyearweek)]
conversions_isoyearweek_to[, last_date := isoyearweek_to_last_date_internal(isoyearweek)]
conversions_isoyearweek_to[, season_c := isoyearweek_to_season_c_internal(isoyearweek)]
conversions_isoyearweek_to[, isoquarter_c := isoyearweek_to_isoquarter_c_internal(isoyearweek)]
conversions_isoyearweek_to[, isoquarter_n := isoyearweek_to_isoquarter_n_internal(isoyearweek)]
conversions_isoyearweek_to[, isoyearquarter_c := isoyearweek_to_isoyearquarter_c_internal(isoyearweek)]

setkey(conversions_isoyearweek_to, isoyearweek)

# saving internal

env = new.env()
if(file.exists("R/sysdata.rda")) load("R/sysdata.rda", envir = env)

env$conversions_isoyearweek_to <- conversions_isoyearweek_to

for(i in names(env)){
  .GlobalEnv[[i]] <- env[[i]]
}
txt <- paste0("usethis::use_data(",paste0(names(env),collapse=","),", overwrite = TRUE, internal = TRUE, compress = 'xz', version = 3)")
eval(parse(text = txt))


