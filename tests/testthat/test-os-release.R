with_mock_os_release <- function(file, expr) {
  with_mocked_bindings(
    expr,
    have_lsb_release = function() FALSE, # Make sure we don't call lsb_release
    read_os_release = function() {
      readLines(test_path(file.path("os-release", file)))
    }
  )
}

test_that("os_release", {
  expect_equal(
    with_mock_os_release("debian-bookworm-testing", distro()),
    list(
      id = "debian",
      version = NULL,
      # Codename should be bookworm right?
      codename = "Debian GNU/Linux bookworm/sid",
      short_version = "12"
    )
  )
  expect_equal(
    with_mock_os_release("debian-bullseye-testing", distro()),
    list(
      id = "debian",
      version = NULL,
      # Codename should be bullseye right?
      codename = "Debian GNU/Linux bullseye/sid",
      short_version = "11"
    )
  )
  expect_equal(
    with_mock_os_release("debian-bullseye", distro()),
    list(
      id = "debian",
      version = "11",
      # Codename should be bullseye right?
      codename = "bullseye",
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
