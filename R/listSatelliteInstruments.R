#' Available satellite instruments.
#'
#' @return A data.frame (tibble) with the Name and Description of available satellites/instruments
#' @export
#'
#' @examples
#' \dontrun{
#' laads_satellite_instruments()
#' }
laads_satellite_instruments <- function(){
  temp <- laads_get(name_service = "listSatelliteInstruments",
              query_par = NULL)

  # check message
  laads_check(temp)

  # done!
  output <- laads_parse(temp)
  dplyr::rename(output, Name = V1, Description = V2)
}
