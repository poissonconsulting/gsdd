test_that("growth_degdays works", {
    expect_identical(growth_degdays(-1), 0)
    expect_identical(growth_degdays(0), 0)
    expect_identical(growth_degdays(0.5), 0.5)
    expect_identical(growth_degdays(1), 1)
    expect_identical(growth_degdays(c(2,1)), c(2,1))
    expect_identical(growth_degdays(c(-1:20)), c(0,0,1:20))
})

test_that("growth_days works", {
    expect_identical(growth_days(-1), 0)
    expect_identical(growth_days(0), 1)
    expect_identical(growth_days(0.5), 1)
    expect_identical(growth_days(1), 1)
    expect_identical(growth_days(c(2,1)), c(1,1))
    expect_identical(growth_days(c(-1:20)), c(0,rep(1, 21)))
})

test_that("growth_pgti_factory works", {
  pgti_growth <- growth_pgti_factory(4, 10, 16)
  expect_identical(pgti_growth(-1), 0)
  expect_identical(pgti_growth(0), 0)
  expect_identical(pgti_growth(0.5), 0)
  expect_identical(pgti_growth(1), 0)
  expect_identical(pgti_growth(c(2,1)), c(0,0))
  expect_equal(pgti_growth(c(-1:20)), c(0, 0, 0, 0, 0, 0, 0.305555555555556, 0.555555555555556, 0.75, 0.888888888888889, 
0.972222222222222, 1, 0.972222222222222, 0.888888888888889, 0.75, 
0.555555555555556, 0.305555555555556, 0, 0, 0, 0, 0))
})

test_that("growth_trapezoid_factory works", {
  trapezoid_growth <- growth_trapezoid_factory(4, 10, 12, 16)
  expect_identical(trapezoid_growth(-1), 0)
  expect_identical(trapezoid_growth(0), 0)
  expect_identical(trapezoid_growth(0.5), 0)
  expect_identical(trapezoid_growth(1), 0)
  expect_identical(trapezoid_growth(c(2,1)), c(0,0))
  expect_equal(trapezoid_growth(c(-1:20)), c(0, 0, 0, 0, 0, 0, 0.166666666666667, 0.333333333333333, 0.5, 0.666666666666667, 
0.833333333333333, 1, 1, 1, 0.75, 0.5, 0.25, 0, 0, 0, 0, 0))
})

test_that("growth_trapezoid_factory as triangle", {
  triangle_growth <- growth_trapezoid_factory(4, 10, 10, 12)
  expect_equal(triangle_growth(c(-1:14)), c(0, 0, 0, 0, 0, 0, 0.166666666666667, 0.333333333333333, 0.5, 0.666666666666667, 
0.833333333333333, 1, 0.5, 0, 0, 0))
})
