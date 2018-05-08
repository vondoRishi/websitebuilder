context("test-test-path-r.R")

test_that("path",{
  unlink("_site", recursive = TRUE)
  prepareSite(ymlFile = "site.yml")
  expect_equal(TRUE,dir.exists("_site"))
})
