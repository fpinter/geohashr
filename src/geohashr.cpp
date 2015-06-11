#include <Rcpp.h>

extern "C" {
  #include "geohash.h"
}

// [[Rcpp::export]]
Rcpp::CharacterVector cpp_geohash_encode(Rcpp::NumericVector lat,
                                         Rcpp::NumericVector lng,
                                         int precision) {

  int outlen = std::min(lat.size(), lng.size());
  Rcpp::CharacterVector geohash_out(outlen);

  Rcpp::NumericVector::iterator it_lat, it_lng;
  Rcpp::CharacterVector::iterator it_out;
  for(it_lat = lat.begin(), it_lng = lng.begin(), it_out = geohash_out.begin();
      it_lat != lat.end() && it_lng != lng.end() && it_out != geohash_out.end();
      ++it_lat, ++it_lng, ++it_out) {
    char *geohash = geohash_encode(*it_lat, *it_lng, precision);
    Rcpp::String curr_hash(geohash);
    *it_out = curr_hash;
  }
  return geohash_out;
}

// [[Rcpp::export]]
Rcpp::DataFrame cpp_geohash_decode(Rcpp::CharacterVector hash) {

  int outlen = hash.size();
  Rcpp::NumericVector lat(outlen);
  Rcpp::NumericVector lng(outlen);

  Rcpp::CharacterVector::iterator it_hash;
  Rcpp::NumericVector::iterator it_lat, it_lng;
  for(it_hash = hash.begin(), it_lat = lat.begin(), it_lng = lng.begin();
      it_hash != hash.end() && it_lat != lat.end() && it_lng != lng.end();
      ++it_hash, ++it_lat, ++it_lng) {
    char *hash0 = *it_hash;
    GeoCoord decoded_hash = geohash_decode(hash0);
    *it_lat = decoded_hash.latitude;
    *it_lng = decoded_hash.longitude;
  }

  return Rcpp::DataFrame::create(Rcpp::Named("lat")=lat,
                                 Rcpp::Named("lng")=lng);
}
