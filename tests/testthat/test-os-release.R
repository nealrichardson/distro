with_mock_os_release <- function(file, expr) {
  with_mock(
    `distro:::have_lsb_release` = function() FALSE, # Make sure we don't call lsb_release
    `distro:::read_os_release` = function() readLines(test_path(file.path("os-release", file))),
    eval.parent(expr)
  )
}

test_that("os_release", {
  expect_equal(
    with_mock_os_release("debian-bullseye", distro()),
    list(
      id = "debian",
      version = NULL,
      codename = "Debian GNU/Linux bullseye/sid",
      short_version = "11"
    )
  )
  expect_equal(
    with_mock_os_release("ubuntu-xenial", distro()),
    list(
      id = "ubuntu",
      version = "16.04",
      codename = "xenial",
      short_version = "16.04"
    )
  )
  expect_equal(
    with_mock_os_release("centos7", distro()),
    list(
      id = "centos",
      version = "7",
      codename = "CentOS Linux 7 (Core)",
      short_version = "7"
    )
  )
  expect_equal(
    with_mock_os_release("fedora31", distro()),
    list(
      id = "fedora",
      version = "31",
      codename = "",
      short_version = "31"
    )
  )
})

