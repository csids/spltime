#' Dates of different days within isoyearweeks
#'
#' @format
#' \describe{
#' \item{isoyear}{Isoyear.}
#' \item{isoyearweek}{Isoweek-isoyear.}
#' \item{mon}{Date of Monday.}
#' \item{tue}{Date of Tuesday.}
#' \item{wed}{Date of Wednesday.}
#' \item{thu}{Date of Thursday.}
#' \item{fri}{Date of Friday.}
#' \item{sat}{Date of Saturday.}
#' \item{sun}{Date of Sunday.}
#' \item{weekdays}{List of dates from Mon-Fri}
#' \item{weekend}{List of dates from Sat-Sun}
#' \item{days}{List of dates from Mon-Sun}
#' }
#' @examples
#' # Constructing a vector of dates without removing the Date class
#' do.call("c", dates_by_isoyearweek[isoyearweek %in% c("2021-01", "2021-02")]$weekdays)
"dates_by_isoyearweek"

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
"nor_workdays_by_date"

#' Norwegian workdays and holidays by isoyearweek
#'
#' @format
#' \describe{
#' \item{isoyearweek}{YYYY-WW}
#' \item{public_holiday}{The proportion of the days within the isoyearweek that are public holidays}
#' \item{freeday}{The proportion of the days within the isoyearweek that are either public holidays or Saturday/Sunday}
#' \item{workday}{1 minus freeday}
#' }
"nor_workdays_by_isoyearweek"