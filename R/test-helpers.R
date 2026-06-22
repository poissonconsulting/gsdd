save_png <- function(x, width = 400, height = 400) {
  path <- tempfile(fileext = ".png")
  grDevices::png(path, width = width, height = height)
  on.exit(grDevices::dev.off())
  print(x)

  path
}

expect_snapshot_plot <- function(x, name) {
  # Raster PNG plot snapshots are not portable across machines (graphics stack
  # version differences produce byte mismatches), so they are only run locally.
  testthat::skip_on_ci()
  testthat::skip_on_os("windows")
  testthat::skip_on_os("linux")

  path <- save_png(x)
  testthat::expect_snapshot_file(path, paste0(name, ".png"))
}
