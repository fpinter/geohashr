#' @useDynLib geohashr
#' @importFrom Rcpp sourceCpp
NULL

#' Encode geohash.
#'
#' @param lat numeric vector, latitudes
#' @param lng numeric vector, longitudes
#' @param precision integer, precision
#' @return Geohash, as character vector.
#'
#' @export
#' @examples
#' new_geohash <- geohash_encode(0, 0, 5)

geohash_encode <- function(lat, lng, precision) {
  cpp_geohash_encode(lat, lng, precision)
}

#' Decode geohash.
#'
#' @param hash character vector, geohashes
#' @return TBD
#'
#' @export
#' @examples
#' TBD

geohash_decode <- function(hash) {
  # not implemented yet
}
