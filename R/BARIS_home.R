
#' Home Page Datasets
#'
#' @description This function displays the most important information about the datasets that are currently displayed within the home page of the data.gouv.fr website.
#'
#' @return A dataframe with datasets characteristics
#'
#' @examples \dontrun{
#'
#' BARIS_home()}
#' @export
#' @importFrom dplyr as_tibble
#'
BARIS_home <- function() {

  my_url <- "https://www.data.gouv.fr/api/1/site/home/datasets/"

  # set memoise cache fct
  mem_fromJSON <- BARIS_set_fromJSON()

  df_info <- mem_fromJSON(my_url)

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



