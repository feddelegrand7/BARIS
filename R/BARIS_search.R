#' Searching for a dataset
#'
#' @description This function searches specific datasets through the data.gouv API according to the pattern provided into the query argument.
#'
#'
#' @param query a character string through which to search
#' @param n_pages number of pages to consider when searching (default to 20). For more, information check out the pagination section of the data.gouv API documentation
#' @return a character string
#' @examples \donttest{
#'
#' BARIS_search("Marseille")}
#' @export
#' @importFrom dplyr as_tibble
BARIS_search <- function(query, n_pages = 20) {

  base_url <- "https://www.data.gouv.fr/api/1/datasets/?q="

  search <- query

  complement <- "&page=0&page_size="


  size = n_pages

  final_url <- paste(base_url, search, complement, size, sep = "")

  # set memoise cache fct
  mem_fromJSON <- BARIS_set_fromJSON()

  df_info <- mem_fromJSON(final_url)

  df_info <- df_info$data

  id                 <- df_info$id

  title              <- df_info$title

  frequency          <- df_info$frequency

  created_at         <- df_info$created_at

  last_modified      <- df_info$last_modified

  last_update        <- df_info$last_update

  archived           <- df_info$archived

  deleted            <- df_info$deleted

  views              <- df_info$metrics[[4]]

  organization       <- df_info$organization[[6]]

  temporal_cov_start <- df_info$temporal_coverage[[1]]

  temporal_cov_end   <- df_info$temporal_coverage[[2]]

  page               <- df_info$page

  df_info2 <- cbind(
    id,
    title,
    organization,
    page,
    views,
    frequency,
    temporal_cov_start,
    temporal_cov_end,
    created_at,
    last_modified,
    last_update,
    archived,
    deleted

  )

  df_info2 <- as_tibble(df_info2)

  return(df_info2)

}

