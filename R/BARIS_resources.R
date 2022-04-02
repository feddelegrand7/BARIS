#' Displaying resources within a data set
#'
#' @description The data.gouv API provides access to several data sets in which one can find several individual data frames to exploit. The BARIS_resources lists all the data frames available within a specific data set along with the main information concerning the data frames.
#'
#' @param datasetId the unique identifier of a data set
#'
#' @return a table of all the data frames (resources) included within a specific data set and their main characteristics
#'
#' @examples \donttest{
#'
#' BARIS_resources("53699934a3a729239d2051a1")}
#' @export
#' @importFrom dplyr as_tibble
#' @importFrom checkmate assert_character


BARIS_resources <- function(datasetId) {


  checkmate::assert_character(datasetId)

  basic_url <- "https://www.data.gouv.fr/api/1/datasets/"

  final_url <- paste("https://www.data.gouv.fr/api/1/datasets/", datasetId, "/", sep = "")

  response_status <- is_response_successfull(final_url)

  if (!response_status) {
    return(NULL)
  }

  # set memoise cache fct
  mem_fromJSON <- BARIS_set_fromJSON()

  df <- mem_fromJSON(final_url)

  df <- df$resources[, c("id", "title",'format', 'published', 'url', 'description')]

  df <- as_tibble(df)

  return(df)
}



