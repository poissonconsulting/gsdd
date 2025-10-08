test_that("growth_gdd works", {
    expect_identical(growth_gdd(-1), -1)
    expect_identical(growth_gdd(0), 0)
    expect_identical(growth_gdd(0.5), 0.5)
    expect_identical(growth_gdd(1), 1)
    expect_identical(growth_gdd(c(2,1)), c(2,1))
    expect_identical(growth_gdd(c(1:20)), c(1:20))
})

test_that("growth_days works", {
    expect_identical(growth_days(-1), 1)
    expect_identical(growth_days(0), 1)
    expect_identical(growth_days(0.5), 1)
    expect_identical(growth_days(1), 1)
    expect_identical(growth_days(c(2,1)), c(1,1))
    expect_identical(growth_days(c(1:20)), c(rep(1, 20)))
})

test_that("growth_pgti_factory works", {
  pgti_growth <- growth_pgti_factory(4, 10, 16)
  expect_identical(pgti_growth(-1), 0)
  expect_identical(pgti_growth(0), 0)
  expect_identical(pgti_growth(0.5), 0)
  expect_identical(pgti_growth(1), 0)
  expect_identical(pgti_growth(c(2,1)), c(0,0))
  expect_equal(pgti_growth(c(1:20)), c(0, 0, 0, 0, 0.305555555555556, 0.555555555555556, 0.75, 0.888888888888889, 
0.972222222222222, 1, 0.972222222222222, 0.888888888888889, 0.75, 
0.555555555555556, 0.305555555555556, 0, 0, 0, 0, 0))
})
