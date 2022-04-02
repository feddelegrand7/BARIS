
#' Extracting A Data frame From The French Portal data.gouv API
#'
#' @description This function read directly into R a specific data frame (resource) by the mean of its unique ID. Currently, BARIS_extract() can read directly the following types of file : json, csv, xls, xlsx, xml, geojson, and shp.
#'
#' @param resourceId the unique identifier of the individual data frame (resource) to read into R. Not to confound with the global data sets ID that includes many data frames
#' @param format the format of the required file (json, csv, xls, xlsx, xml, geojson or shp)
#'
#' @return a data frame
#'
#' @examples \donttest{
#' BARIS_extract("59ea7bba-f38a-4d75-b85f-2d1955050e53", format = "csv")}
#' @export
#' @importFrom magrittr %>%
#' @importFrom dplyr as_tibble
#' @importFrom data.table fread
#' @importFrom downloader download
#' @importFrom sf read_sf
#' @importFrom XML xmlParse
#' @importFrom XML xmlToDataFrame
#' @importFrom httr BROWSE
#' @importFrom rgdal readOGR
#' @importFrom janitor clean_names
#' @importFrom rio import
#' @importFrom jsonlite fromJSON
#' @importFrom utils unzip
#' @importFrom checkmate assert_character



BARIS_extract <- function(resourceId, format) {

  checkmate::assert_character(resourceId)

  checkmate::assert_character(format)


  basic_url <- "https://www.data.gouv.fr/fr/datasets/r/"

  final_url <- paste(basic_url, resourceId, sep = "")

  response_status <- is_response_successfull(final_url)

  if (!response_status) {
    return(NULL)
  }

  #### Reading CSV files ############################################################

  if(format == "csv" || format == "text" || format == "text/csv"  | format == "txt"){

    df_csv <- fread(final_url, stringsAsFactors = F, sep = "auto", encoding = "UTF-8", showProgress = F)
    df_csv <- as_tibble(df_csv)

    df_csv <- clean_names(df_csv)
    return(df_csv)

  #### Reading Excel files ############################################################


  } else if (format == "xls" || format == "xlsx"){


    df_xlsx <- import(final_url)

    df_xlsx <- clean_names(df_xlsx)

    return(df_xlsx)

  #### Reading XML files ############################################################


  } else if (format == "xml" ){


    xml_info <- xmlParse(httr::GET(final_url))

    xmldf <- xmlToDataFrame(xml_info)


    return(xmldf)

  #### Reading SHP files ############################################################


  } else if (format == "shp" || format == "shapefile"){

    temp <- tempfile()
    temp2 <- tempfile()

    download(final_url, dest=temp, mode="wb")

    unzip(zipfile = temp, exdir = temp2)

    SHP_file <- list.files(temp2, pattern = ".shp$",full.names=TRUE)

    return(read_sf(SHP_file))

    unlink(c(temp, temp2))



  #### Downloading ZIP file ############################################################


  } else if (format == "zip" || format == "html.zip" ){

    BROWSE(final_url)

  #### Downloading GEOJSON file #########################################################


  } else if (format == "geojson"){

    temp <- tempfile()
    temp2 <- tempfile()

    download(final_url, dest=temp, mode="wb")

    unzip(zipfile = temp, exdir = temp2)

    SHP_file <- list.files(temp2, pattern = "geojson$",full.names=TRUE)

    return(readOGR(SHP_file, layer = "OGRGeoJSON"))

    unlink(c(temp, temp2))

  } else if(format == "json") {

    df_json <- fromJSON(final_url)


    return(df_json)

  } else {

    stop("The available extraction capabilities are limited to
      json, csv, text, xls, xlsx, xml, geojson, and shp files. And for downloading, only PDF and ZIP")


  }



}





