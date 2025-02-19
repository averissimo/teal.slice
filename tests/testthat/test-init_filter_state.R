# argument checks ----
testthat::test_that("init_filter_state checks arguments", {
  testthat::expect_error(init_filter_state(), "argument \"slice\" is missing")

  testthat::expect_error(
    init_filter_state(x = 7, x_reactive = NULL, slice = teal_slice(dataname = "data", varname = "var")),
    "Assertion on 'x_reactive' failed"
  )

  testthat::expect_error(
    init_filter_state(x = 7, slice = teal_slice(dataname = "data", varname = "variable"), extract_type = "other"),
    "Assertion on 'extract_type' failed"
  )
})

# return type ----
testthat::test_that("init_filter_state returns an EmptyFilterState if all values provided are NA", {
  testthat::expect_s3_class(
    init_filter_state(NA, slice = teal_slice(dataname = "data", varname = "var")),
    "EmptyFilterState"
  )
})

testthat::test_that("init_filter_state returns a ChoicesFilterState if passed a numeric of length 1", {
  numbers <- 1
  testthat::expect_s3_class(
    init_filter_state(numbers, slice = teal_slice(dataname = "data", varname = "var")), "ChoicesFilterState"
  )
})

testthat::test_that("init_filter_state returns a RangeFilterState if passed a longer numeric", {
  numbers <- seq(1, length.out = getOption("teal.threshold_slider_vs_checkboxgroup") + 1)
  testthat::expect_s3_class(
    init_filter_state(numbers, slice = teal_slice(dataname = "data", varname = "var")), "RangeFilterState"
  )
})

testthat::test_that("init_filter_state returns a ChoicesFilterState object if passed a Date object of length 1", {
  dates <- seq(as.Date("1990/01/01"), by = 1, length.out = 1)
  testthat::expect_s3_class(
    init_filter_state(dates, slice = teal_slice(dataname = "data", varname = "var")), "ChoicesFilterState"
  )
})

testthat::test_that("init_filter_state returns a DateFilterState object if passed longer a Date object", {
  dates <- seq(as.Date("1990/01/01"), by = 1, length.out = getOption("teal.threshold_slider_vs_checkboxgroup") + 1)
  testthat::expect_s3_class(
    init_filter_state(dates, slice = teal_slice(dataname = "data", varname = "var")), "DateFilterState"
  )
})

testthat::test_that("init_filter_state returns a ChoicesFilterState object if passed
  a POSIXct or POSIXlt of length 1", {
  dates <- seq(as.Date("1990/01/01"), by = 1, length.out = 1)
  testthat::expect_s3_class(
    init_filter_state(as.POSIXct(dates), slice = teal_slice(dataname = "data", varname = "var")), "ChoicesFilterState"
  )
  testthat::expect_s3_class(
    init_filter_state(as.POSIXlt(dates), slice = teal_slice(dataname = "data", varname = "var")), "ChoicesFilterState"
  )
})

testthat::test_that("init_filter_state returns a DatetimeFilterState object if passed
  a longer POSIXct or POSIXlt", {
  dates <- seq(as.Date("1990/01/01"), by = 1, length.out = getOption("teal.threshold_slider_vs_checkboxgroup") + 1)
  testthat::expect_s3_class(
    init_filter_state(as.POSIXct(dates), slice = teal_slice(dataname = "data", varname = "var")), "DatetimeFilterState"
  )
  testthat::expect_s3_class(
    init_filter_state(as.POSIXlt(dates), slice = teal_slice(dataname = "data", varname = "var")), "DatetimeFilterState"
  )
})

testthat::test_that("init_filter_state returns a RangeFilterState if passed a numeric vector containing Inf", {
  testthat::expect_s3_class(
    init_filter_state(c(1, 2, 3, 4, Inf), slice = teal_slice(dataname = "data", varname = "var")), "RangeFilterState"
  )
})

testthat::test_that("init_filter_state returns a ChoicesFilterState if passed fewer than five non-NA elements", {
  testthat::expect_s3_class(
    init_filter_state(c(1, 2, 3, 4, NA), slice = teal_slice(dataname = "data", varname = "var")), "ChoicesFilterState"
  )
})

testthat::test_that("init_filter_state returns a ChoicesFilterState, if passed a character vector of any length", {
  chars <- replicate(
    n = getOption("teal.threshold_slider_vs_checkboxgroup") + 1,
    paste(sample(letters, size = 10, replace = TRUE), collapse = "")
  )
  testthat::expect_s3_class(
    init_filter_state("a", slice = teal_slice(dataname = "data", varname = "var")), "ChoicesFilterState"
  )
})

testthat::test_that("init_filter_state returns a ChoicesFilterState, if passed a factor of any length", {
  chars <- factor(
    replicate(
      n = getOption("teal.threshold_slider_vs_checkboxgroup") + 1,
      paste(sample(letters, size = 10, replace = TRUE), collapse = "")
    )
  )
  testthat::expect_s3_class(
    init_filter_state("a", slice = teal_slice(dataname = "data", varname = "var")),
    "ChoicesFilterState"
  )
})

testthat::test_that("init_filter_state return a LogicalFilterState, if passed a logical vector", {
  testthat::expect_s3_class(
    init_filter_state(c(TRUE), slice = teal_slice(dataname = "data", varname = "var")), "LogicalFilterState"
  )
})

testthat::test_that("init_filter_state default accepts a list", {
  fs <- init_filter_state(list(1, 2, 3), slice = teal_slice(dataname = "data", varname = "var"))
  testthat::expect_s3_class(fs, "FilterState")
})
