# Tests taken from geohash_test.c
library(geohashr)
context("C tests")

test_that("Encoding C tests pass", {
  expect_equal(geohash_encode(42.60498046875, -5.60302734375, 5), "ezs42")
  expect_equal(geohash_encode(40.018141, -105.274858, 12), "9xj5smj4w40m")
  expect_equal(geohash_encode(40.018141, -105.274858, 2), "9x")
  expect_equal(geohash_encode(40.018141, -105.274858, 0), "9xj5sm")
})

test_that("Decoding C tests pass", {
  expect_equal(geohash_decode("ezs42")$lat, 42.60498046875)
  expect_equal(geohash_decode("ezs42")$lng, -5.60302734375)
  expect_equal(geohash_decode("ezs42gx")$lat, 42.602920532226562)
  expect_equal(geohash_decode("ezs42gx")$lng, -5.5817413330078125)
  expect_equal(geohash_decode("9xj5smj4w40")$lat, 40.018140748143196)
  expect_equal(geohash_decode("9xj5smj4w40")$lng, -105.27485780417919)
})
