# Inspired heavily from the simfinR package developed by Marcelo S.Perlin.

#' Sets memoise cache function
#'
#' Uses the memoise package to set a cache function for jsonlite::fromJSON
#' The choice of the cache folder defines where to save the local files. If not set, will use tempdir()
#'
#' @param cache_folder The local folder where to save files
#'
#' @return A memoised function
#'
#' @examples \dontrun{
#' mem_fromJSON <- BARIS_set_fromJSON()
#' }
#' @export
#' @importFrom memoise memoise
#' @importFrom memoise cache_filesystem
#' @importFrom jsonlite fromJSON


BARIS_set_fromJSON <- function(cache_folder = tempdir()) {

  mem_fromJSON <- memoise::memoise(jsonlite::fromJSON,
    cache = memoise::cache_filesystem(cache_folder))

  return(mem_fromJSON)

}
