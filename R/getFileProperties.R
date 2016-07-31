#' Title
#'
#' @param file_ids file IDs for the data files, either a single one or a vector of IDs. For getting IDs see \code{laads_search_files}.
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
#' laads_file_properties(file_ids = files[1:10])}
laads_file_properties <- function(file_ids = "299343600"){
  temp <- laads_get(name_service = "getFileProperties",
                    query_par = list(fileIds = gsub(" ", "", toString(file_ids))))

  # check message
  laads_check(temp)

  # done!
  output <- laads_parse_fileids(temp)
  output

}

# parse
laads_parse_fileids <- function(req){
  text <- httr::content(req, as = "text")
  text <- xml2::read_xml(text)
  # somehow sometimes with bind_rows I get an error
  # "not compatible with STRSXP"
  text <- do.call(rbind, xml2::as_list(text))

  if (nrow(text) == 1){
    text <- tibble::tibble_(list(checksum = lazyeval::interp(~text[1,1][[1]][[1]][1]),
                                 file_id = lazyeval::interp(~text[1,2][[1]][[1]][1]),
                                 file_name = lazyeval::interp(~text[1,3][[1]][[1]][1]),
                                 file_size_bytes = lazyeval::interp(~text[1,4][[1]][[1]][1]),
                                 file_type = lazyeval::interp(~text[1,5][[1]][[1]][1]),
                                 ingest_time = lazyeval::interp(~lubridate::ymd_hms(as.character(text[1,6][[1]][[1]][1]))),
                                 online = lazyeval::interp(~text[1,7][[1]][[1]][1]),
                                 start_time = lazyeval::interp(~lubridate::ymd_hms(as.character(text[1,8][[1]][[1]][1])))))
  }else{
    text <- tibble::as_tibble(apply(text, 2, unlist))
    text <- dplyr::rename_(text,
                           .dots= list(checksum = lazyeval::interp(~V1),
                                       file_id = lazyeval::interp(~V2),
                                       file_name = lazyeval::interp(~V3),
                                       file_size_bytes = lazyeval::interp(~V4),
                                       file_type = lazyeval::interp(~V5),
                                       ingest_time = lazyeval::interp(~V6),
                                       online = lazyeval::interp(~V7),
                                       start_time = lazyeval::interp(~V8)))
  }



  return(text)
}

