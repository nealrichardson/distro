
# distro

<!-- badges: start -->
[![R build status](https://github.com/nealrichardson/distro/workflows/R-CMD-check/badge.svg)](https://github.com/nealrichardson/distro/actions)
<!-- badges: end -->

The goal of `distro` is to provide a standardized interface to version and other
facts about the current system's Linux distribution. It is similar in spirit
(though far more limited in scope) to the Python 
[`distro`](https://distro.readthedocs.io/en/latest/) package.

Different Linux distributions and versions record version information in a
number of different files and commands. The `lsb_release` command line utility
standardizes some of the access to this information, but it is not guaranteed
to be installed. This package draws from the various possible locations of
version information and provides a single function for querying them.

## Installation

`distro` is not yet on CRAN, but you can install it with:

``` r
remotes::install_github("nealrichardson/distro")
```

## Example

There is only one public function in the package:

```r
distro::distro()

# $id
# [1] "ubuntu"
# 
# $version
# [1] "16.04"
# 
# $codename
# [1] "xenial"
# 
# $short_version
# [1] "16.04"
```

