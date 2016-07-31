#' Title
#'
#' @param file
#'
#' @return A data.frame (tibble) containing data file properties, including name, id, size, format, ingest time, data start time, and online status.
#' @export
#'
#' @examples \dontrun{
#' files <- laads_search_files(product = "MCD15A2",
#'                               start_time = "2010-01-01",
#'                               end_time = "2010-01-10",
#'                               coords_or_tiles = "global",
#'                               day_night_both = "DNB")$file_id
#' laads_file_properties(file_ids = files)}
laads_file_properties <- function(file_ids = "299343600"){
  temp <- laads_get(name_service = "getFileProperties",
                    query_par = list(fileIds = toString(file_ids)))

  # check message
  laads_check(temp)

  # done!
  output <- laads_parse_fileids(temp)
  output

}
