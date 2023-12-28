devtools::load_all()

seasonweek_to_isoweek_c_internal <- function(seasonweek) {
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

seasonweek_to_isoweek_n_internal <- function(seasonweek) {
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

conversions_seasonweek_to <- data.table(
  seasonweek = c(1:23, 23.5, 24:52)
)

conversions_seasonweek_to[, isoweek_c := seasonweek_to_isoweek_c_internal(seasonweek)]
conversions_seasonweek_to[, isoweek_n := seasonweek_to_isoweek_n_internal(seasonweek)]

setkey(conversions_seasonweek_to, seasonweek)

# saving internal

env = new.env()
if(file.exists("R/sysdata.rda")) load("R/sysdata.rda", envir = env)

env$conversions_seasonweek_to <- conversions_seasonweek_to

for(i in names(env)){
  .GlobalEnv[[i]] <- env[[i]]
}
txt <- paste0("usethis::use_data(",paste0(names(env),collapse=","),", overwrite = TRUE, internal = TRUE, compress = 'xz', version = 3)")
eval(parse(text = txt))



