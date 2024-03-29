
#' Data set description
#'
#' @description This function provides in French a detailed description of a data set.
#' @param datasetId the unique id of a data set
#'
#' @return a character string describing a data set
#'
#' @examples \donttest{
#'
#' BARIS_explain("53699934a3a729239d2051a1")}
#' @export
#' @importFrom magrittr %>%
#' @importFrom dplyr as_tibble
#' @importFrom stringr str_replace_all
#' @importFrom stringr str_trim
#' @importFrom checkmate assert_character


BARIS_explain <- function(datasetId) {

  checkmate::assert_character(datasetId)

  basic_url <- "https://www.data.gouv.fr/api/1/datasets/"

  final_url <- paste("https://www.data.gouv.fr/api/1/datasets/", datasetId, "/", sep = "")

  response_status <- is_response_successfull(final_url)

  if (!response_status) {
    return(NULL)
  }

  # set memoise cache fct
  mem_fromJSON <- BARIS_set_fromJSON()

  df_explain <- mem_fromJSON(final_url)

  Encoding(df_explain$description) <- "UTF-8"


  return(df_explain$description)
}





