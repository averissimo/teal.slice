testthat::test_that("init_filtered_dataset returns a DataframeFilteredDataset when passed a data.frame", {
  testthat::expect_no_error(filtered_dataset <- init_filtered_dataset(
    dataset = head(iris), dataname = "iris"
  ))
  testthat::expect_true(is(filtered_dataset, "DataframeFilteredDataset"))
})

testthat::test_that("init_filtered_dataset returns an MAEFilteredDataset when passed an MAE", {
  utils::data("miniACC", package = "MultiAssayExperiment")

  testthat::expect_no_error(filtered_dataset <- init_filtered_dataset(
    dataset = miniACC, dataname = "MAE"
  ))
  testthat::expect_true(is(filtered_dataset, "MAEFilteredDataset"))
})
