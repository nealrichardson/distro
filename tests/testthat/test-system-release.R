with_mock_system_release <- function(string, expr) {
  with_mocked_bindings(
    expr,
    have_lsb_release = function() FALSE, # Make sure we don't call lsb_release
    read_os_release = function() NULL, # Or use /etc/os_release
    read_system_release = function() string
  )
}

test_that("system_release", {
  expect_equal(
    with_mock_system_release("CentOS Linux release 7.7.1908 (Core)", distro()),
    list(
      id = "centos",
      version = "7.7.1908",
      codename = NA,
      short_version = "7"
    )
  )
})
