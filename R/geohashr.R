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
#' new_geohash <- geohash_encode(c(0, 24), c(0, -25), 12)

geohash_encode <- function(lat, lng, precision) {
  cpp_geohash_encode(lat, lng, precision)
}

#' Encode geohash from sp.
#'
#' @param points_obj \code{SpatialPoints} or \code{SpatialPointsDataFrame}
#'   object
#' @param precision integer, precision
#' @return Geohash, as character vector.
#'
#' @export
#' @examples
#' library(sp)
#' geohash_encode_sp(SpatialPoints(cbind((-20):(-25), 0:5)), precision = 12)

geohash_encode_sp <- function(points_obj, precision) {
  if (!requireNamespace("sp", quietly = TRUE)) {
    stop("sp package is required.")
  }
  points_matrix <- points_obj@coords
  cpp_geohash_encode(points_matrix[,2], points_matrix[,1], precision)
}

#' Decode geohash.
#'
#' @param hash character vector, geohashes
#' @return data.frame with columns lat and lng, corresponding to \code{hash}.
#'
#' @export
#' @examples
#' geohash_decode(c("7zzz", "9hmmy"))

geohash_decode <- function(hash) {
  cpp_geohash_decode(hash)
}

#' Decode geohash to sp.
#'
#' @param hash character vector, geohashes
#' @return \code{SpatialPoints} object corresponding to \code{hash}.
#'
#' @export
#' @examples
#' library(sp)
#' sp_geohash_decode(c("7zzz", "9hmmy"))

sp_geohash_decode <- function(hash) {
  if (!requireNamespace("sp", quietly = TRUE)) {
    stop("sp package is required.")
  }
  out <- cpp_geohash_decode(hash)
  sp::coordinates(out) <- c("lng", "lat")
  out
}
