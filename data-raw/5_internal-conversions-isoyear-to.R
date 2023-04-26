devtools::load_all()

isoyear_to_last_isoyearweek_c_internal <- function(x) {
  isoyearweek <- NULL
  y <- as.numeric(x)
  retval <- data.table(isoyear = x)[cstime::dates_by_isoyearweek, on = "isoyear", isoyearweek := isoyearweek]$isoyearweek
  
  return(retval)
}

isoyear_to_last_isoweek_c_internal <- function(x) {
  isoyearweek_to_isoweek_c(isoyear_to_last_isoyearweek_c_internal(x))
}

isoyear_to_last_isoweek_n_internal <- function(x) {
  isoyearweek_to_isoweek_n(isoyear_to_last_isoyearweek_c_internal(x))
}

isoyear_to_last_date_internal <- function(x) {
  sun <- NULL
  x <- as.numeric(x)
  retval <- data.table(isoyear = x)[cstime::dates_by_isoyearweek, on = "isoyear", sun := sun]$sun
  
  return(retval)
}

conversions_isoyear_n_to <- data.table(
  isoyear_n = c(seq(1950, 2100, 1), 9999)
)

conversions_isoyear_n_to[, last_isoyearweek_c := isoyear_to_last_isoyearweek_c_internal(isoyear_n)]
conversions_isoyear_n_to[, last_isoweek_c := isoyear_to_last_isoweek_c_internal(isoyear_n)]
conversions_isoyear_n_to[, last_isoweek_n := isoyear_to_last_isoweek_n_internal(isoyear_n)]
conversions_isoyear_n_to[, last_date := isoyear_to_last_date_internal(isoyear_n)]
conversions_isoyear_n_to <- na.omit(conversions_isoyear_n_to)

conversions_isoyear_c_to <- copy(conversions_isoyear_n_to)
conversions_isoyear_c_to[, isoyear_n := as.character(isoyear_n)]
setnames(conversions_isoyear_c_to, "isoyear_n", "isoyear_c")

setkey(conversions_isoyear_n_to, isoyear_n)
setkey(conversions_isoyear_c_to, isoyear_c)

# saving internal

env = new.env()
if(file.exists("R/sysdata.rda")) load("R/sysdata.rda", envir = env)

env$conversions_isoyear_n_to <- conversions_isoyear_n_to
env$conversions_isoyear_c_to <- conversions_isoyear_c_to

for(i in names(env)){
  .GlobalEnv[[i]] <- env[[i]]
}
txt <- paste0("usethis::use_data(",paste0(names(env),collapse=","),", overwrite = TRUE, internal = TRUE, compress = 'xz', version = 3)")
eval(parse(text = txt))



