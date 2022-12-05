#' keep_sundays_and_latest_date_internal
#'
#' @param dates dates (later)
#' @param format format (later)
#' @param keep_delete keep_delet (later)
#' @param keep_latest_date keep_latest_date (later)
#'
#' @import data.table

keep_sundays_and_latest_date_internal <- function(dates,
                                                  format = "Uke isoweek_c-1/isoweek_c",
                                                  keep_delete = TRUE,
                                                  keep_latest_date = TRUE) {
  n <- NULL
  isoyearweek <- NULL
  time_description <- NULL
  
  stopifnot(format %in% c(
    "isoyearweek_c",
    "Uke isoweek_c",
    "isoyearweek_c-1/isoyearweek_c",
    "Uke isoweek_c-1/isoweek_c",
    "date"
  ))

  values <- data.table::data.table(
    date = dates,
    order = 1:length(dates),
    isoyearweek = date_to_isoyearweek_c(dates)
  )
  data.table::setorder(values, -date)
  values[, n := 1:.N, by = .(isoyearweek)]
  data.table::setorder(values, date)
  values[, time_description := as.character(date)]
  if (keep_latest_date) {
    values[time_description != max(time_description), time_description := "delete"]
  } else {
    values[, time_description := "delete"]
  }
  if (format == "isoyearweek_c") {
    values[
      date %in% cstime::dates_by_isoyearweek$sun,
      time_description := paste0(date_to_isoyearweek_c(date))
    ]
  } else if (format == "Uke isoweek_c") {
    values[
      date %in% cstime::dates_by_isoyearweek$sun,
      time_description := paste0("Uke ", date_to_isoweek_c(date))
    ]
  } else if (format == "isoyearweek_c-1/isoyearweek_c") {
    values[
      date %in% cstime::dates_by_isoyearweek$sun,
      time_description := paste0(date_to_isoyearweek_c(date - 7), "/", date_to_isoyearweek_c(date))
    ]
  } else if (format == "Uke isoweek_c-1/isoweek_c") {
    values[
      date %in% cstime::dates_by_isoyearweek$sun,
      time_description := paste0("Uke ", date_to_isoweek_c(date - 7), "/", date_to_isoweek_c(date))
    ]
  } else if (format == "date") {
    values[
      date %in% cstime::dates_by_isoyearweek$sun,
      time_description := as.character(date)
    ]
  }
  levels <- unique(c("delete", values$time_description))
  data.table::setorder(values, order)

  retval <- factor(values$time_description, levels = levels)

  if (!keep_delete) {
    retval <- as.character(retval)
    retval <- retval[retval != "delete"]
  }
  return(retval)
}



#' keep_sundays_and_latest_date
#'
#' @param dates dates (later)
#' @param format format (later)
#' @param keep_delete keep_delete (later)
#' @return Date with level: delete or not

keep_sundays_and_latest_date <- function(dates, format = "Uke isoweek_c-1/isoweek_c", keep_delete = TRUE) {
  retval <- keep_sundays_and_latest_date_internal(
    dates = dates,
    format = format,
    keep_delete = keep_delete,
    keep_latest_date = TRUE
  )
  return(retval)
}


#' keep_sundays
#'
#' @param dates dates (later)
#' @param format format (later)
#' @param keep_delete keep_delete (later)
#' @return Label: delete or not

keep_sundays <- function(dates, format = "Uke isoweek_c-1/isoweek_c", keep_delete = TRUE) {
  retval <- keep_sundays_and_latest_date_internal(
    dates = dates,
    format = format,
    keep_delete = keep_delete,
    keep_latest_date = FALSE
  )
  return(retval)
}

