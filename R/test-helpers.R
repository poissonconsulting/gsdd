save_png <- function(x, width = 400, height = 400) {
  path <- tempfile(fileext = ".png")
  grDevices::png(path, width = width, height = height)
  on.exit(grDevices::dev.off())
  print(x)

  path
}

expect_snapshot_plot <- function(x, name) {
  testthat::skip_on_os("windows")
  testthat::skip_on_os("linux")

  path <- save_png(x)
  testthat::expect_snapshot_file(path, paste0(name, ".png"))
}
