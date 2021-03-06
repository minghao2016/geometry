context("Comparison of tsearch and tsearchn")
test_that("tsearch and tsearchn give the same results", {
  set.seed(1)
  X <- runif(50)
  Y <- runif(50)
  T <- delaunayn(cbind(X, Y))
  XI <- runif(1000)
  YI <- runif(1000)

  out <- tsearch(X, Y, T, XI, YI)
  outn <- tsearchn(cbind(X, Y), T, cbind(XI, YI), fast=FALSE)

  expect_equal(na.omit(out), na.omit(outn$idx))

  out <- tsearch(X, Y, T, XI, YI, TRUE)
  expect_equal(na.omit(outn$p), na.omit(out$p), tolerance=1e-12)
})
