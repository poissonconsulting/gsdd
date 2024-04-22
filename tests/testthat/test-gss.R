test_that("gss works", {
  gss <- gss(temperature_data)
  expect_snapshot({
    gss
  })
})

test_that("gss before leap year", {
  gss <- gss(temperature_data, start_date = as.Date("1972-02-28"))
  expect_snapshot({
    gss
  })
})

test_that("gss shifts by 10", {
  data <- temperature_data
  data <- data[-(1:10),]
  gss <- gss(data, min_length = 100)
  expect_snapshot({
    gss
  })
})

test_that("gss preserves if shift start date", {
  data <- temperature_data
  data <- data[-(1:10),]
  gss <- gss(data, start_date = as.Date("2019-02-01"), min_length = 100)
  expect_snapshot({
    gss
  })
})

test_that("gss preserves if shift before leap year", {
  data <- temperature_data
  data <- data[-(1:10),]
  gss <- gss(data, start_date = as.Date("2019-02-28"), min_length = 100)
  expect_snapshot({
    gss
  })
})

test_that("gss preserves if shift after leap", {
  data <- temperature_data
  data <- data[-(1:10),]
  gss <- gss(data, start_date = as.Date("2019-03-01"), min_length = 100)
  expect_snapshot({
    gss
  })
})

test_that("gss preserves if shift start date", {
  gss <- gss(temperature_data, start_date = as.Date("2019-03-20"), ignore_truncation = TRUE)
  expect_snapshot({
    gss
  })
})

test_that("gss one message", {
  data <- temperature_data
  data <- data[-(1:100),]
  expect_message(gss <- gss(data, min_length = 100), "The growing season is truncated at the start of the sequence.")
  expect_snapshot({
    gss
  })
})


test_that("gss works", {
  gss <- gss(temperature_data, window_width = 13)
  expect_snapshot({
    gss
  })
})

test_that("gss works shortened", {
  expect_message(gss <- gss(temperature_data, min_length = 100, end_date = as.Date("1972-09-29")),
                 "The growing season is truncated at the end of the sequence.")
  expect_snapshot({
    gss
  })
})

test_that("gss NA if stops before", {
  data <- temperature_data
  data <- data[data$date < as.Date("2019-09-30"),]
  expect_message(gss <- gss(data))
  expect_snapshot({
    gss
  })
})

test_that("gss NA if missing", {
  data <- temperature_data
  data$temperature[data$date == as.Date("2019-09-30")] <- NA_real_
  expect_message(gss <- gss(data))
  expect_snapshot({
    gss
  })
})

test_that("growth period with biggest GSDD even though shorter period.", {
  data <- gsdd::temperature_data
  data$temperature <- data$temperature2
  gss <- gss(data, window_width = 3, start_temp = 9, end_temp = 9)
  expect_snapshot({
    gss
  })
})

test_that("growth period default t2", {
  data <- gsdd::temperature_data
  data$temperature <- data$temperature2
  gss <- gss(data)
  expect_snapshot({
    gss
  })
})

test_that("growth period default t2", {
  data <- gsdd::temperature_data
  data$temperature <- data$temperature2
  gss <- gss(data, start_date = as.Date("1972-01-02"))
  expect_snapshot({
    gss
  })
})

test_that("growth period default t2", {
  data <- gsdd::temperature_data
  data$temperature <- data$temperature2
  gss <- gss(data, start_date = as.Date("1972-02-28"))
  expect_snapshot({
    gss
  })
})
test_that("growth period default t2", {
  data <- gsdd::temperature_data
  data$temperature <- data$temperature2
  gss <- gss(data, start_date = as.Date("1972-03-02"))
  expect_snapshot({
    gss
  })
})

test_that("gss biggest", {
  data <- gsdd::temperature_data
  data$temperature <- data$temperature2
  gss <- gss(data, pick = "biggest")
  expect_snapshot({
    gss
  })
})

test_that("gss smallest", {
  data <- gsdd::temperature_data
  data$temperature <- data$temperature2
  gss <- gss(data, pick = "smallest")
  expect_snapshot({
    gss
  })
})

test_that("gss longest", {
  data <- gsdd::temperature_data
  data$temperature <- data$temperature2
  gss <- gss(data, pick = "longest")
  expect_snapshot({
    gss
  })
})

test_that("gss shortest", {
  data <- gsdd::temperature_data
  data$temperature <- data$temperature2
  gss <- gss(data, pick = "shortest")
  expect_snapshot({
    gss
  })
})

test_that("gss first", {
  data <- gsdd::temperature_data
  data$temperature <- data$temperature2
  gss <- gss(data, pick = "first")
  expect_snapshot({
    gss
  })
})

test_that("gss last", {
  data <- gsdd::temperature_data
  data$temperature <- data$temperature2
  gss <- gss(data, pick = "last")
  expect_snapshot({
    gss
  })
})

test_that("gss truncation start", {
  data <- gsdd::temperature_data
  data$temperature <- data$temperature2
  data$temperature[data$date <= as.Date("2019-04-11")] <- 6
  gss <- gss(data, ignore_truncation =TRUE)
  expect_snapshot({
    gss
  })
})

test_that("gss truncation end", {
  data <- gsdd::temperature_data
  data$temperature <- data$temperature2
  data$temperature[data$date >= as.Date("2019-08-28")] <- 5
  gss <- gss(data, ignore_truncation =TRUE)
  expect_snapshot({
    gss
  })
})

test_that("gss truncation both ends", {
  data <- gsdd::temperature_data
  data$temperature <- data$temperature2
  data$temperature[data$date <= as.Date("2019-04-11")] <- 6
  data$temperature[data$date >= as.Date("2019-08-28")] <- 5
  gss <- gss(data, ignore_truncation =TRUE)
  expect_snapshot({
    gss
  })
})

test_that("gss truncation all", {
  data <- gsdd::temperature_data
  data$temperature <- data$temperature2
  data$temperature <- 6
  gss <- gss(data, ignore_truncation =TRUE)
  expect_snapshot({
    gss
  })
})

test_that("gss not shift", {
  data <- structure(list(date = structure(c(
    18050, 18051, 18052, 18053, 
    18054, 18055, 18056, 18057, 18058, 18059, 18060, 18061, 18062, 
    18063, 18064, 18065, 18066, 18067, 18068, 18069, 18070, 18071, 
    18072, 18073, 18074, 18075, 18076, 18077, 18078, 18079, 18080, 
    18081, 18082, 18083, 18084, 18085, 18086, 18087, 18088, 18089, 
    18090, 18091, 18092, 18093, 18094, 18095, 18096, 18097, 18098, 
    18099, 18100, 18101, 18102, 18103, 18104, 18105, 18106, 18107, 
    18108, 18109, 18110, 18111, 18112, 18113, 18114, 18115, 18116, 
    18117, 18118, 18119, 18120, 18121, 18122, 18123, 18124, 18125, 
    18126, 18127, 18128, 18129, 18130, 18131, 18132, 18133, 18134, 
    18135, 18136, 18137, 18138, 18139, 18140, 18141, 18142, 18143, 
    18144, 18145, 18146, 18147, 18148, 18149, 18150, 18151, 18152, 
    18153, 18154, 18155, 18156, 18157, 18158, 18159, 18160, 18161, 
    18162, 18163, 18164, 18165, 18166, 18167, 18168, 18169, 18170, 
    18171, 18172, 18173, 18174, 18175, 18176, 18177, 18178, 18179, 
    18180, 18181, 18182, 18183, 18184, 18185, 18186, 18187, 18188, 
    18189, 18190, 18191, 18192, 18193, 18194, 18195, 18196, 18197, 
    18198, 18199, 18200, 18201, 18202, 18203, 18204, 18205, 18206, 
    18207, 18208, 18209, 18210, 18211, 18212, 18213, 18214, 18215, 
    18216, 18217, 18218, 18219, 18220, 18221, 18222, 18223, 18224, 
    18225, 18226, 18227, 18228, 18229, 18230, 18231, 18232, 18233, 
    18234, 18235, 18236, 18237, 18238, 18239, 18240, 18241, 18242, 
    18243, 18244, 18245, 18246, 18247, 18248, 18249, 18250, 18251, 
    18252, 18253, 18254, 18255, 18256, 18257, 18258, 18259, 18260, 
    18261), class = "Date"), temperature = c(
      5.59791666666667, 5.18026041666667, 
      4.94130208333333, 4.94848958333333, 3.5025, 3.17791666666667, 
      4.07885416666667, 4.35494791666667, 5.25875, 6.30286458333333, 
      6.87723958333333, 6.81932291666667, 6.53270833333333, 6.4753125, 
      6.44494791666667, 7.24005208333333, 6.33625, 4.5540625, 2.5596875, 
      4.11390625, 4.339375, 4.42135416666667, 4.80494791666667, 4.96265625, 
      4.8984375, 4.88005208333333, 4.81177083333333, 5.0553125, 5.47380208333333, 
      5.15916666666667, 5.01171875, 5.1584375, 5.33546875, 6.01515625, 
      5.98041666666667, 5.6703125, 6.2259375, 6.51010416666667, 6.41302083333333, 
      7.00890625, 7.05979166666667, 7.27005208333333, 6.37307291666667, 
      6.88526041666667, 6.63473958333333, 6.25067708333333, 5.30692708333333, 
      4.45197916666667, 4.98484375, 5.96833333333333, 7.23666666666667, 
      6.6925, 6.47713541666667, 7.00317708333333, 7.12838541666667, 
      6.71817708333333, 7.06364583333333, 7.1790625, 7.51244791666667, 
      7.69734375, 8.01744791666667, 7.80963541666667, 7.46682291666667, 
      7.63020833333333, 8.13578125, 8.68916666666667, 8.63927083333333, 
      8.16390625, 7.9878125, 7.76880208333333, 7.66307291666667, 8.03057291666667, 
      8.00296875, 7.57854166666667, 7.17494791666667, 6.64, 7.64380208333333, 
      8.18744791666667, 8.380625, 8.87875, 8.65151041666667, 8.08572916666667, 
      8.03322916666667, 7.19734375, 6.69546875, 6.47572916666667, 7.55, 
      8.1953125, 7.85880208333333, 8.07421875, 8.585625, 8.42401041666667, 
      8.09052083333333, 8.27447916666667, 8.14291666666667, 8.03088541666667, 
      8.13328125, 8.14239583333333, 7.54125, 6.49588541666667, 6.42916666666667, 
      6.84885416666667, 6.71895833333333, 6.47182291666667, 6.88817708333333, 
      7.01041666666667, 6.483125, 5.22958333333333, 5.81322916666667, 
      6.01916666666667, 5.82635416666667, 5.96046875, 6.61723958333333, 
      6.10083333333333, 4.79421875, 5.02390625, 2.90666666666667, 0.471875, 
      0.0148958333333333, 0.376145833333333, 0.254635416666667, 0.480520833333333, 
      1.38984375, 1.72135416666667, 1.8228125, 1.72447916666667, 2.149375, 
      0.6659375, 0.02734375, -0.00338541666666667, 0.0117708333333333, 
      0.0115625, 0.048125, 0.128020833333333, 0.123125, 0.294375, 0.51078125, 
      0.473958333333333, 0.438697916666667, 0.0574479166666667, 0.105208333333333, 
      0.243333333333333, 0.10296875, -0.0783854166666667, 0.186822916666667, 
      -0.0784375, -0.0361979166666667, 0.00604166666666667, 0.000729166666666667, 
      -0.00458333333333333, 0.000208333333333333, 0.00244791666666667, 
      0.00354166666666667, 0.00427083333333333, 0.00614583333333333, 
      0.00411458333333333, 0.00114583333333333, -0.0915104166666667, 
      -0.165208333333333, -0.0886979166666667, -0.05328125, -0.259739583333333, 
      -0.318697916666667, -0.20265625, -0.134479166666667, -0.0990625, 
      -0.0604166666666667, -0.0386979166666667, -0.01921875, -0.0104166666666667, 
      -0.0169270833333333, -0.0971875, -0.238020833333333, -0.260989583333333, 
      -0.131041666666667, -0.18203125, -0.228854166666667, -0.3403125, 
      NA, NA, NA, NA, NA, NA, -0.281979166666667, -0.217395833333333, 
      -0.3309375, -0.218697916666667, -0.22046875, -0.293963293650794, 
      -0.367457837301587, -0.440952380952381, -0.402760416666667, -0.389791666666667, 
      -0.398333333333333, -0.431739130434783, NA, NA, NA, NA, NA, -0.148958333333333, 
      -0.0504166666666667, -0.0353645833333333, -0.0274479166666667, 
      -0.02625, -0.101979166666667, -0.185677083333333, -0.173229166666667, 
      -0.321458333333333, -0.395, -0.394791666666667)), 
    row.names = c(NA, -212L), class = c("tbl_df", "tbl", "data.frame"))
  
  skip()
  gss(data, min_length = 60)
  gss_plot(data, min_length = 60)
})
