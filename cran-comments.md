-- R CMD check results ------------ BARIS 1.1.2 ----
Duration: 1m 15.2s

0 errors √ | 0 warnings √ | 0 notes √

* Following the email of Professor Brian Ripley, now the functions that call resources on the internet fail gracefully, they return `NULL` in case of the `http` response is not successful. 

* I've modified the `BARIS_search` function by removing the `n_pages` parameter and adding two new parameters to query the results, namely: `page_number` and `page_size`.

Thanks. 
