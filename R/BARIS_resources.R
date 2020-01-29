#' Displaying resources within a dataset
#'
#' @description The data.gouv API provides access to several datasets in which one can find several individual dataframes to exploit. The BARIS_resources lists all the dataframes available within a specific dataset along with the main information concerning the dataframes.
#'
#' @param datasetId the unique identifier of a dataset
#'
#' @return a dataframe of all the dataframes (resources) included within a specific dataset and their main characteristics
#'
#' @examples \donttest{
#'
#' BARIS_resources("53699934a3a729239d2051a1")}
#' @export
#' @importFrom dplyr as_tibble
#'
BARIS_resources <- function(datasetId) {


  basic_url <- "https://www.data.gouv.fr/api/1/datasets/"

  final_url <- paste("https://www.data.gouv.fr/api/1/datasets/", datasetId, "/", sep = "")

  # set memoise cache fct
  mem_fromJSON <- BARIS_set_fromJSON()

  df <- mem_fromJSON(final_url)

  df <- df$resources[, c("id", "title",'format', 'published', 'url', 'description')]

  df <- as_tibble(df)

  return(df)
}



