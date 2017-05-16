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

  output <- NULL

  # not too many IDs at once
  request <- split(file_ids, ceiling(seq_along(file_ids)/100))

  for(i in 1:length(request)) {

    temp <- laads_get(name_service = "getFileProperties",
                      query_par = list(fileIds = gsub(" ", "", toString(request[[i]]))))

    # check message
    laads_check(temp)

    # done!
    output <- dplyr::bind_rows(output,
                               laads_parse_fileids(temp))
  }



  output <- dplyr::mutate_(output, online = lazyeval::interp(~online == "true"))
  output

}

# parse
laads_parse_fileids <- function(req){
  text <- httr::content(req, as = "text")
  text <- xml2::read_xml(text)
  # somehow sometimes with bind_rows I get an error
  # "not compatible with STRSXP"
  text <- do.call(rbind, xml2::as_list(text))
  text <- tibble::as_tibble(apply(text, 2, unlist))
  text <- dplyr::rename_(text, file_id = ~fileId)
  text <- dplyr::rename_(text, file_name = ~fileName)
  text <- dplyr::rename_(text, file_size_bytes = ~fileSizeBytes)
  text <- dplyr::rename_(text, file_type = ~fileType)
  text <- dplyr::rename_(text, ingest_time = ~ingestTime)
  text <- dplyr::rename_(text, start_time = ~startTime)
  text <- dplyr::mutate_(text, ingest_time = lazyeval::interp(~lubridate::ymd_hms(ingest_time)))


  return(text)
}

