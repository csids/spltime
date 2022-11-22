# gen_dates_by_isoyearweek ----
days <- data.table::data.table(day = seq.Date(as.Date("1950-01-02"), as.Date("2100-01-01"), by = "days"))
days[, isoyear := as.integer(format.Date(day, format = "%G"))]
days[, isoyearweek := format.Date(day, format = "%G-%V")]
days <- days[, .(mon = as.Date(min(day))), by = .(isoyear, isoyearweek)]
days[, tue := mon + 1]
days[, wed := mon + 2]
days[, thu := mon + 3]
days[, fri := mon + 4]
days[, sat := mon + 5]
days[, sun := mon + 6]
days[, weekdays := list(list(c(mon[1], tue[1], wed[1], thu[1], fri[1]))), by = isoyearweek]
days[, weekend := list(list(c(sat[1], sun[1]))), by = isoyearweek]
days[, days := list(list(c(mon[1], tue[1], wed[1], thu[1], fri[1], sat[1], sun[1]))), by = isoyearweek]

setkey(days, isoyear, isoyearweek, mon, tue, wed, thu, fri, sat, sun)

dates_by_isoyearweek <- days
save(dates_by_isoyearweek, file = "data/dates_by_isoyearweek.rda", compress = "xz")



gen_norway_workdays_by_date <- function(){
  # variables used by data.table
  is_current <- NULL
  year_end <- NULL
  is_holiday <- NULL
  day_of_week <- NULL
  mon_to_fri <- NULL
  #
  
  info <- readxl::read_excel(
    system.file("rawdata", "norway_holidays.xlsx", package = "cstime")
  )
  info$date <- as.Date(info$date)
  setDT(info)
  
  year_min <- lubridate::year(min(info$date))
  year_max <- lubridate::year(max(info$date))
  
  date_min <- as.Date(glue::glue("{year_min}-01-01"))
  date_max <- as.Date(glue::glue("{year_max}-12-31"))
  
  norway_workdays_by_date <- data.table(date = seq.Date(date_min, date_max, by = 1))
  
  norway_workdays_by_date[, day_of_week := lubridate::wday(date, week_start = 1)]
  
  norway_workdays_by_date[, mon_to_fri := 0]
  norway_workdays_by_date[day_of_week %in% c(1:5), mon_to_fri := 1]
  
  norway_workdays_by_date[, sat_to_sun := 0]
  norway_workdays_by_date[day_of_week %in% c(6:7), sat_to_sun := 1]
  
  norway_workdays_by_date[, public_holiday := 0]
  norway_workdays_by_date[info, on = "date", public_holiday := 1]
  
  norway_workdays_by_date[, freeday := pmax(sat_to_sun, public_holiday)]
  norway_workdays_by_date[, workday := 1 - freeday]
  
  return(norway_workdays_by_date)
}

gen_norway_workdays_by_isoyearweek <- function(){
  norway_workdays_by_date <- gen_norway_workdays_by_date()
  norway_workdays_by_date[, isoyearweek := date_to_isoyearweek_c(date)]
  
  norway_workdays_by_isoyearweek <- norway_workdays_by_date[, .(
    days = .N,
    public_holiday = round(mean(public_holiday),2),
    freeday = round(mean(freeday),2),
    workday = round(mean(workday),2)
  ),
  keyby = .(
    isoyearweek
  )]
  
  norway_workdays_by_isoyearweek <- norway_workdays_by_isoyearweek[days==7]
  norway_workdays_by_isoyearweek[, days := NULL]
  
  return(norway_workdays_by_isoyearweek)
}

# gen_norway_workdays_by_date ----
nor_workdays_by_date <- gen_norway_workdays_by_date()
save(nor_workdays_by_date, file = "data/nor_workdays_by_date.rda", compress = "xz")

# gen_norway_workdays_by_isoyearweek ----
nor_workdays_by_isoyearweek <- gen_norway_workdays_by_isoyearweek()
save(nor_workdays_by_isoyearweek, file = "data/nor_workdays_by_isoyearweek.rda", compress = "xz")

