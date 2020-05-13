with_mock_lsb <- function(mock, expr) {
  with_mock(
    `distro:::have_lsb_release` = function() TRUE,
    `distro:::call_lsb` = function(args) mock[[args]],
    eval.parent(expr)
  )
}

debian_lsb <- list(
  "-cs" = "bullseye",
  "-is" = "Debian",
  "-rs" = "testing"
)

ubuntu_lsb <- list(
  "-cs" = "xenial",
  "-is" = "Ubuntu",
  "-rs" = "16.04"
)

centos_lsb <- list(
  "-cs" = "foo",
  "-is" = "CentOS",
  "-rs" = "7.7.1908"
)

fedora_lsb <- list(
  "-cs" = "ThirtyOne",
  "-is" = "Fedora",
  "-rs" = "31"
)

test_that("lsb_release", {
  with_mock_lsb(debian_lsb, {
    expect_equal(lsb_release(), list(id="Debian", version="testing", codename="bullseye"))
    expect_equal(distro(), list(id="debian", version="testing", codename="bullseye", short_version="11"))
  })

  expect_equal(
    with_mock_lsb(ubuntu_lsb, distro()),
    list(id="ubuntu", version="16.04", codename="xenial", short_version="16.04")
  )

  expect_equal(
    with_mock_lsb(centos_lsb, distro()),
    list(id="centos", version="7.7.1908", codename="foo", short_version="7")
  )

  expect_equal(
    with_mock_lsb(fedora_lsb, distro()),
    list(id="fedora", version="31", codename="ThirtyOne", short_version="31")
  )
})

