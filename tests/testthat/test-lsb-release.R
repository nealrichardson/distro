with_mock_lsb <- function(mock, expr) {
  with_mocked_bindings(
    expr,
    have_lsb_release = function() TRUE,
    call_lsb = function(args) mock[[args]]
  )
}

debian_bookworm_testing <- list(
  "-cs" = "bookworm",
  "-is" = "Debian",
  "-rs" = "testing"
)

debian_bookworm_unstable <- list(
  "-cs" = "sid",
  "-is" = "Debian",
  "-rs" = "unstable"
)

debian_bullseye_testing <- list(
  "-cs" = "bullseye",
  "-is" = "Debian",
  "-rs" = "testing"
)

debian_bullseye <- list(
  "-cs" = "bullseye",
  "-is" = "Debian",
  "-rs" = "11"
)

ubuntu_xenial <- list(
  "-cs" = "xenial",
  "-is" = "Ubuntu",
  "-rs" = "16.04"
)

centos_7 <- list(
  "-cs" = "foo",
  "-is" = "CentOS",
  "-rs" = "7.7.1908"
)

fedora_31 <- list(
  "-cs" = "ThirtyOne",
  "-is" = "Fedora",
  "-rs" = "31"
)

test_that("lsb_release", {
  with_mock_lsb(debian_bookworm_testing, {
    expect_equal(
      lsb_release(),
      list(id = "Debian", version = "testing", codename = "bookworm")
    )
    expect_equal(
      distro(),
      list(
        id = "debian",
        version = "testing",
        codename = "bookworm",
        short_version = "12"
      )
    )
  })

  # if it codename is sid, this is always the codename of the latest unstable
  # version, and we can't map to the short version number as we don't know it
  with_mock_lsb(debian_bookworm_unstable, {
    expect_equal(
      distro(),
      list(id = "debian", version = "unstable", codename = "sid")
    )
  })

  with_mock_lsb(debian_bullseye_testing, {
    expect_equal(
      distro(),
      list(
        id = "debian",
        version = "testing",
        codename = "bullseye",
        short_version = "11"
      )
    )
  })

  with_mock_lsb(debian_bullseye, {
    expect_equal(
      distro(),
      list(
        id = "debian",
        version = "11",
        codename = "bullseye",
        short_version = "11"
      )
    )
  })

  expect_equal(
    with_mock_lsb(ubuntu_xenial, distro()),
    list(
      id = "ubuntu",
      version = "16.04",
      codename = "xenial",
      short_version = "16.04"
    )
  )

  expect_equal(
    with_mock_lsb(centos_7, distro()),
    list(
      id = "centos",
      version = "7.7.1908",
      codename = "foo",
      short_version = "7"
    )
  )

  expect_equal(
    with_mock_lsb(fedora_31, distro()),
    list(
      id = "fedora",
      version = "31",
      codename = "ThirtyOne",
      short_version = "31"
    )
  )
})
