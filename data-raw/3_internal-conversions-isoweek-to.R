library(data.table)

isoweek_to_seasonweek_n_internal <- function(isoweek) {
  # take both char/n in input
  
  # real week 30 is the start of season, week 1
  # original: fhi::x(20)
  if (max(isoweek) > 53 | min(isoweek) < 1) {
    stop("ISO week needs to be between 1 to 53")
  }
  
  retval <- isoweek
  retval[isoweek >= 30] <- isoweek[isoweek >= 30] - 29
  retval[isoweek < 30] <- isoweek[isoweek < 30] + 23
  retval[isoweek == 53] <- 23.5
  
  return(retval)
}

isoweek_to_isoquarter_n_internal <- function(isoweek) {
  # take both char/n in input
  retval <- 1 + floor((isoweek-1)/13)
  retval[retval==5] <- 4
  return(retval)
}

conversions_isoweek_n_to <- data.table(
  isoweek_n = 1:53
)
conversions_isoweek_n_to[, seasonweek_n := isoweek_to_seasonweek_n_internal(isoweek_n)]
conversions_isoweek_n_to[, isoquarter_n := isoweek_to_isoquarter_n_internal(isoweek_n)]
conversions_isoweek_n_to[, isoquarter_c := as.character(isoquarter_n)]

conversions_isoweek_c_to_1 <- copy(conversions_isoweek_n_to)
conversions_isoweek_c_to_2 <- copy(conversions_isoweek_n_to)
conversions_isoweek_c_to_1[, isoweek_n := formatC(isoweek_n, flag="0", width = 2)]
conversions_isoweek_c_to_2[, isoweek_n := as.character(isoweek_n)]

conversions_isoweek_c_to <- unique(rbind(conversions_isoweek_c_to_1, conversions_isoweek_c_to_2))
setnames(conversions_isoweek_c_to, "isoweek_n", "isoweek_c")

setkey(conversions_isoweek_n_to, isoweek_n)
setkey(conversions_isoweek_c_to, isoweek_c)

# saving internal

env = new.env()
if(file.exists("R/sysdata.rda")) load("R/sysdata.rda", envir = env)

env$conversions_isoweek_n_to <- conversions_isoweek_n_to
env$conversions_isoweek_c_to <- conversions_isoweek_c_to

for(i in names(env)){
  .GlobalEnv[[i]] <- env[[i]]
}
txt <- paste0("usethis::use_data(",paste0(names(env),collapse=","),", overwrite = TRUE, internal = TRUE, compress = 'xz', version = 3)")
eval(parse(text = txt))



