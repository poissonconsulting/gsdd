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
