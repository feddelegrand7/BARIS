
<!-- README.md is generated from README.Rmd. Please edit that file -->

# BARIS <a><img src='man/figures/hex.png' align="right" height="200" /></a>

<!-- badges: start -->

<!-- badges: end -->

With **BARIS** you can exploit the [French official data
portal](www.data.gouv.fr) API directly from R. The package offers
several capabalities, from listing the available datasets to extracting
the needed resources. Nevertheless, there are many functionalities
offered by the API (e.g. uploading a dataset, removing a resource among
others) that are not covered in the **BARIS** package which really focus
on the data analysis aspect of the API. The good news about that is that
the user doesn’t need an API key or any credential to run the available
functions provided by **BARIS**. Finally, a distinction has to be made.
The data.gouv API provides several datasets **which contain** one or
many dataframes. The unique identifier (ID) of dataset has this form :
**53699934a3a729239d2051a1** while the ID of an individual dataframe or
resource has this form: **59ea7bba-f38a-4d75-b85f-2d1955050e53**.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("feddelegrand7/BARIS")
```

## BARIS\_home()

Using the function `BARIS_home()` you can list the displayed datasets
within the [home page of the website](www.data.gouv.fr). The function
doesn’t take any argument. This will return a dataframe with the most
important information related to the displayed datasets.

``` r
library(BARIS)

BARIS_home()
#> # A tibble: 9 x 13
#>   id    title organization page  views frequency temporal_cov_st~
#>   <chr> <chr> <chr>        <chr> <chr> <chr>     <chr>           
#> 1 5de8~ Fich~ Institut Na~ http~ 6     unknown   2019-12-31      
#> 2 5e00~ "Con~ Ministère d~ http~ 0     unknown   2019-12-08      
#> 3 5b98~ "Don~ Laboratoire~ http~ 0     hourly    <NA>            
#> 4 5c5a~ Résu~ Ministère d~ http~ 0     monthly   2019-06-30      
#> 5 5c4a~ Dema~ Ministère d~ http~ 23    semiannu~ 2019-06-30      
#> 6 5cc1~ Dema~ Etalab       http~ 14    semiannu~ 2019-06-30      
#> 7 5cd5~ Fich~ Etalab       http~ 2     daily     2024-10-01      
#> 8 5369~ Déco~ OpenStreetM~ http~ 27    annual    <NA>            
#> 9 5c34~ Répe~ Ministère d~ http~ 10    quarterly <NA>            
#> # ... with 6 more variables: temporal_cov_end <chr>, created_at <chr>,
#> #   last_modified <chr>, last_update <chr>, archived <chr>, deleted <chr>
```

The data is quite heavy so I encourage you to use `View()` or
`datatable()` from the `DT` package.

## BARIS\_search()

The `BARIS_search()` function allows you search for a specific dataset.
Suppose we’re interested at the city of Marseille.

``` r

BARIS_search(query = "Marseille", n_pages = 20)
#> # A tibble: 20 x 13
#>    id    title organization page  views frequency temporal_cov_st~
#>    <chr> <chr> <chr>        <chr> <chr> <chr>     <chr>           
#>  1 5369~ Traf~ Ministère d~ http~ 3     annual    2011-12-31      
#>  2 5369~ Déco~ OpenStreetM~ http~ 1     annual    <NA>            
#>  3 5ceb~ Mars~ Ville de Ma~ http~ <NA>  unknown   <NA>            
#>  4 5ceb~ Mars~ Ville de Ma~ http~ <NA>  unknown   <NA>            
#>  5 5ceb~ Mars~ Ville de Ma~ http~ <NA>  unknown   <NA>            
#>  6 5ceb~ Mars~ Ville de Ma~ http~ <NA>  unknown   <NA>            
#>  7 5dd7~ Quar~ Datactivist  http~ <NA>  unknown   <NA>            
#>  8 5ceb~ Mars~ Ville de Ma~ http~ <NA>  unknown   <NA>            
#>  9 5ceb~ Mars~ Ville de Ma~ http~ <NA>  unknown   <NA>            
#> 10 5878~ Arro~ NosDonnées.~ http~ <NA>  unknown   <NA>            
#> 11 5878~ Quar~ NosDonnées.~ http~ <NA>  unknown   <NA>            
#> 12 5369~ Arro~ NosDonnées.~ http~ 4     unknown   <NA>            
#> 13 5ceb~ Mars~ Ville de Ma~ http~ <NA>  unknown   <NA>            
#> 14 5ceb~ Mars~ Ville de Ma~ http~ <NA>  unknown   <NA>            
#> 15 5ceb~ Mars~ Ville de Ma~ http~ <NA>  unknown   <NA>            
#> 16 5ceb~ Mars~ Ville de Ma~ http~ <NA>  unknown   <NA>            
#> 17 5ceb~ Mars~ Ville de Ma~ http~ <NA>  unknown   <NA>            
#> 18 5ceb~ Mars~ Ville de Ma~ http~ <NA>  unknown   <NA>            
#> 19 5ceb~ Mars~ Ville de Ma~ http~ <NA>  unknown   <NA>            
#> 20 5ceb~ Mars~ Ville de Ma~ http~ <NA>  unknown   <NA>            
#> # ... with 6 more variables: temporal_cov_end <chr>, created_at <chr>,
#> #   last_modified <chr>, last_update <chr>, archived <chr>, deleted <chr>
```

The **n\_page** argument is used to specify the number of pages to
search for according to the pagination of the API, by default its value
is equal to 20. Now, in order to choose a dataset, let’s have a look at
two columns, the id and the title of each dataset.

``` r

Marseille_data <- BARIS_search(query = "Marseille", n_pages = 20)

Marseille_data[, c("id", "title")]
#> # A tibble: 20 x 2
#>    id                    title                                             
#>    <chr>                 <chr>                                             
#>  1 5369a248a3a729239d20~ Trafic aéroport Marseille-Provence : passagers et~
#>  2 53699233a3a729239d20~ Découpage administratif communal français issu d'~
#>  3 5cebfa8506e3e77ffdb3~ Marseille - Cimetières                            
#>  4 5cebfa8706e3e77c78b3~ Marseille - Crèches                               
#>  5 5cebfa869ce2e764aac3~ Marseille - Subventions                           
#>  6 5cebfa839ce2e76116c3~ Marseille - Élus                                  
#>  7 5dd7a9a78b4c41277a7f~ Quartiers de Marseille                            
#>  8 5cebfa869ce2e76116c3~ Marseille - Délibérations                         
#>  9 5cebfa8306e3e77ffdb3~ Marseille - Monuments historiques                 
#> 10 5878ee29a3a7291485ca~ Arrondissements de Marseille                      
#> 11 5878ee75a3a7291484ca~ Quartiers de Marseille                            
#> 12 53698f14a3a729239d20~ Arrondissements de Marseille                      
#> 13 5cebfa839ce2e76116c3~ Marseille - Wifi public                           
#> 14 5cebfa8306e3e77c78b3~ Marseille - Écoles élémentaires                   
#> 15 5cebfa849ce2e764aac3~ Marseille - Écoles maternelles                    
#> 16 5cebfa869ce2e764aac3~ Marseille - Lieux culturels                       
#> 17 5cebfa869ce2e76116c3~ Marseille - Équipements sociaux                   
#> 18 5cebfa8706e3e77ffdb3~ Marseille - Elections départementales             
#> 19 5cebfa8406e3e77ffdb3~ Marseille - Équipements sportifs                  
#> 20 5cebfa8706e3e77c78b3~ Marseille - Parcours culturels
```

Suppose we’re interested in the dataset entitled **Marseille - Monuments
historiques** with the corresponding id: **5cebfa8306e3e77ffdb31ef5**
and we want to know more about this data. In the case, the
`BARIS_explain()` function can be useful.

## BARIS\_explain()

The `BARIS_explain()` function returns a description of a dataset. It
has one argument which the id of the dataset of interest.

``` r

BARIS_explain("5cebfa8306e3e77ffdb31ef5")
#> [1] "Monuments historiques situés sur le territoire de Marseille, avec adresse, numéro de base Mérimée (base de données du Ministère de la Culture recensant les monuments historiques de toute la France) et points de géolocalisation"
```

The description is in French but even non-French speakers can use this
function in conjuction with a translation tool.

## BARIS\_resources()

As mentioned previously, each dataset contains one or several dataframes
or as the API call them **resources**. The `BARIS_resources()` function
allows you to list all the available resources within a determined
dataset.

``` r

BARIS_resources("5cebfa8306e3e77ffdb31ef5") # The "Marseille - Monuments historiques" id
#> # A tibble: 2 x 6
#>   id        title      format published    url           description       
#>   <chr>     <chr>      <chr>  <chr>        <chr>         <chr>             
#> 1 59ea7bba~ MARSEILLE~ csv    2019-05-27T~ https://trou~ Monuments histori~
#> 2 6328f8b3~ Plan des ~ pdf    2019-05-27T~ https://trou~ Edition Janvier 2~
```

Many useful information related to the resource are provided: - The id,
- the title, - the format, - the date of publication, - the url of the
resource, - and a description.

## BARIS\_extract()

The `BARIS_extract()` function allows you to extract directly to your R
session the needed resource. You have to specify the id of the resource
and its format. Currently, only theses formats are supported: json, csv,
xls, xlsx, xml, geojson and shp, nevertheless you can always rely on the
url of the resource to upload manually each resource. As an example, let
us extract the *MARSEILLE\_MONUMENTS\_HISTORIQUES\_2018.csv* file.

``` r

BARIS_extract(resourceId = "59ea7bba-f38a-4d75-b85f-2d1955050e53", format = "csv")
#> # A tibble: 80 x 10
#>    n_base_merimee date_de_protect~ denomination adresse code_postal
#>    <chr>          <chr>            <chr>        <chr>         <int>
#>  1 PA00081336     Classement : li~ Ancienne ég~ /             13002
#>  2 PA00081340     Classement: 13/~ Eglise Sain~ Esplan~       13002
#>  3 PA00081331     Classement: 29/~ Chapelle et~ 2, Rue~       13002
#>  4 PA00081344     Classement: 16/~ Fort Saint-~ ""            13002
#>  5 PA00081325     Inscription : 2~ Les deux bâ~ Quai d~       13002
#>  6 PA00081334     Inscription : 0~ Clocher des~ Montée~       13002
#>  7 PA00081348     Classement: 12/~ Hôtel Davie~ Place ~       13002
#>  8 PA00081363     Classement: 02/~ Maison dite~ 27, Gr~       13002
#>  9 PA00081349     Inscription : 1~ Hôtel-Dieu-~ 6, Pla~       13002
#> 10 PA00081354     Classement: 30/~ Hôtel de Vi~ Quai d~       13002
#> # ... with 70 more rows, and 5 more variables:
#> #   proprietaire_du_monument <chr>, epoque_de_construction <chr>,
#> #   date_de_construction <chr>, longitude <dbl>, latitude <dbl>
```

Finally, I appreciate any feedback, feel free to reach out at
[moh\_fodil](https://twitter.com/moh_fodil) or open an issue on
[Github](https://github.com/feddelegrand7/BARIS/issues).
