
#' Title
#'
#' @return
#' @export
#'
#' @examples
#' @importFrom magrittr %>%
#' @importFrom dplyr as_tibble
#' @importFrom data.table fread
#' @importFrom reader get.ext
#' @importFrom downloader download
#' @importFrom sf read_sf
#' @importFrom XML xmlParse
#' @importFrom XML xmlToDataFrame
#' @importFrom httr BROWSE
#' @importFrom rgdal readOGR



BARIS_CSVextract <- function(resourceId) {

  if(!(is.character(resourceId))){

    stop("Please provide the id as a character element")
  }

  basic_url <- "https://www.data.gouv.fr/fr/datasets/r/"

  final_url <- paste("https://www.data.gouv.fr/api/1/datasets/", resourceId, sep = "")

  resp <- httr::GET(final_url)

  #### Reading CSV files ############################################################

  if(http_type(resp) == "csv" || http_type(resp) == "text" || http_type(resp) == "text/csv" ){

    resource <- data.table::fread(final_url, stringsAsFactors = F, sep = "auto")
    resource <- dplyr::as_tibble(resource)
    return(resource)

  #### Reading Excel files ############################################################


  } else if (http_type(resp) == "xls" || http_type(resp) == "xlsx"){


    resource <- rio::import(final_url)

    return(resource)

  #### Reading XML files ############################################################


  } else if (http_type(resp) == "xml" ){



    xml_info <- XML::xmlParse(final_url)

    xmldf <- XML::xmlToDataFrame(nodes = getNodeSet(xml_info, "//record"))

    return(xmldf)

  #### Reading SHP files ############################################################


  } else if (http_type(resp) == "shp" || http_type(resp) == "shapefile"){

    temp <- tempfile()
    temp2 <- tempfile()

    downloader::download(final_url, dest=temp, mode="wb")

    unzip(zipfile = temp, exdir = temp2)

    SHP_file <- list.files(temp2, pattern = ".shp$",full.names=TRUE)

    return(sf::read_sf(SHP_file))

    unlink(c(temp, temp2))


  #### Reading PDF files ############################################################


  } else if (http_type(resp) == "pdf"){

    httr::BROWSE(final_url)

  #### Downloading ZIP file ############################################################


  } else if (http_type(resp) == "zip"){

    httr::BROWSE(final_url)

  #### Downloading GEOJSON file ############################################################


  } else if (http_type(resp) == "geojson"){


    temp <- tempfile()
    temp2 <- tempfile()

    downloader::download(final_url, dest=temp, mode="wb")

    unzip(zipfile = temp, exdir = temp2)

    SHP_file <- list.files(temp2, pattern = "geojson$",full.names=TRUE)

    return(rgdal::readOGR(SHP_file, layer = "OGRGeoJSON"))

    unlink(c(temp, temp2))


  }











}





