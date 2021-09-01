test_that("distro() does not error regardless of platform", {
  sysname <- tolower(Sys.info()[["sysname"]])
  if (sysname == "linux") {
    expect_is(distro(), "list")
  } else if (sysname %in% c("darwin", "windows")) {
    expect_null(distro())
  } else {
    expect_error(distro(), NA)
  }
})
