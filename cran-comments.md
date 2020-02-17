## Test environments
* local OS X install, R 3.6.1
* ubuntu 14.04 (on travis-ci), R 3.6.1
* win-builder (devel and release)

## R CMD check results

-- R CMD check results ---------------------------------------- BARIS 1.0.0 ----
Duration: 1m 53.2s

0 errors v | 0 warnings v | 0 notes v

R CMD check succeeded

* As requested, I've replaced cat() with the error() function within BARIS_extract()
* As requested, I've replaced all /dontrun{} with /donttest{}
