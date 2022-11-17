#' Norwegian workdays and holidays by date
#'
#' @format
#' \describe{
#' \item{date}{Date.}
#' \item{day_of_week}{Integer. 1 = Monday, 7 = Sunday}
#' \item{mon_to_fri}{Integer. 1 between Monday and Friday, 0 between Saturday and Sunday}
#' \item{sat_to_sun}{Integer. 1 between Saturday and Sunday, 0 between Monday and Friday}
#' \item{public_holiday}{Integer. 1 if public holiday (helligdag), 0 if not public holiday}
#' \item{freeday}{Integer. 1 if public holiday (helligdag) or sat_to_sun==1, 0 otherwise}
#' \item{workday}{Integer. 1 if freeday==0, 0 if freeday==1}
#' }
"norway_workdays_by_date"

#' Norwegian workdays and holidays by isoyearweek
#'
#' @format
#' \describe{
#' \item{isoyearweek}{YYYY-WW}
#' \item{public_holiday}{The proportion of the days within the isoyearweek that are public holidays}
#' \item{freeday}{The proportion of the days within the isoyearweek that are either public holidays or Saturday/Sunday}
#' \item{workday}{1 minus freeday}
#' }
"norway_workdays_by_isoyearweek"

gen_norway_workdays_by_date <- function(){
  # variables used by data.table
  is_current <- NULL
  year_end <- NULL
  is_holiday <- NULL
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


