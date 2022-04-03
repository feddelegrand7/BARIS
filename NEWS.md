# BARIS 1.1.3
* Checking for the `http` responses using a `HEAD` method instead of a `GET` which takes too much time on large `CSV` files. 

# BARIS 1.1.2
* The functions that query data now check for the API response, and if not successful, they return `NULL`.

* In `BARIS_search`, removing the `n_pages` parameter and adding two new parameters to query the results, namely: `page_number` and `page_size`


# BARIS 1.1.1

* minor bugs fixing 
* added assertion features

# BARIS 1.1.0

* I've added an add-in that allows the user to use the package in an interactive manner. 

# BARIS 1.0.0

* First release of BARIS. 
