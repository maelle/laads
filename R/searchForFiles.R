#' Returns a list of file IDs matching the given search criteria.
#'
#' @param product product name(s), e.g. \code{"MCD43C1"} or \code{c("MCD43C1", "MCD43B4")}. See \code{laads_products}.
#' @param collection collection number. Default is the default collection for the product. See \code{laads_collection}.
#' @param start_time start date (and optional time) of the temporal window, "YYYY-MM-DD" or "YYYY-MM-DD hh:mm:ss".
#' @param end_time end date (and optional time) of the temporal window, "YYYY-MM-DD" or "YYYY-MM-DD hh:mm:ss".
#' @param north North boundary of the spatial window, -90 to 90 for coords or 0 to 17 for tiles.
#' @param south South boundary of the spatial window, -90 to 90 for coords or 0 to 17 for tiles.
#' @param east East boundary of the spatial window, -180 to 180 for coords or 0 to 35 for tiles.
#' @param west West boundary of the spatial window, -180 to 180 for coords or 0 to 35 for tiles.
#' @param coords_or_tiles "coords", "tiles" or "global", specifies whether the north/south/west/east parameters are coords or tiles. The north/south/west/east parameters are ignored if global.
#' @param day_night_both specifies whether to include data files which only have day data (D), only have night data (N), or only have both day and night data (B). Possible values are these combinations: "D", "N", "B", "DN", "DB", "NB", "DNB". Default is "DNB".
#'
#' @return A data.frame (tibble) with only one column, "file_id".
#' @export
#'
#' @examples \dontrun{
#' laads_search_files(product = "MCD15A2",
#'                      start_time = "2010-01-01",
#'                     end_time = "2015-05-02",
#'                     coords_or_tiles = "global",
#'                     day_night_both = "DNB")}
#'
laads_search_files <- function(product = "MCD15A2",
                               collection = NULL,
                               start_time = "2010-01-01",
                               end_time = "2015-05-02",
                               north = NULL,
                               south = NULL,
                               east = NULL,
                               west = NULL,
                               coords_or_tiles = "global",
                               day_night_both = "DNB"){

  #
  if(length(product) == 1){
    query_par <- list(product = product,
                      collection = collection,
                      startTime = start_time,
                      endTime = end_time,
                      north = north,
                      south = south,
                      east = east,
                      west = west,
                      coordsOrTiles = coords_or_tiles,
                      dayNightBoth = day_night_both)
  }else{
    query_par <- list(products = gsub(" ", "", toString(product)),
                      collection = collection,
                      startTime = start_time,
                      endTime = end_time,
                      north = north,
                      south = south,
                      east = east,
                      west = west,
                      coordsOrTiles = coords_or_tiles,
                      dayNightBoth = day_night_both)
  }


  temp <- laads_get(name_service = "searchForFiles",
                    query_par = query_par)

  # check message
  laads_check(temp)

  # done!
  output <- laads_parse(temp)
  dplyr::rename_(output, .dots= list(file_id = lazyeval::interp(~V1)))

}
