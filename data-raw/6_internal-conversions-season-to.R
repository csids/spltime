devtools::load_all()

conversions_season_to <- conversions_isoyearweek_to[,.(
  last_date = max(last_date)
), keyby=.(season = season_c)]

setkey(conversions_season_to, season)

# saving internal

env = new.env()
if(file.exists("R/sysdata.rda")) load("R/sysdata.rda", envir = env)

env$conversions_season_to <- conversions_season_to

for(i in names(env)){
  .GlobalEnv[[i]] <- env[[i]]
}
txt <- paste0("usethis::use_data(",paste0(names(env),collapse=","),", overwrite = TRUE, internal = TRUE, compress = 'xz', version = 3)")
eval(parse(text = txt))



