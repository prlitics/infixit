test_that("Pastes strings", {
  options(infixit.paste = "paste0")

  expectation <- "Alexis Licari"

  test_1 <- "Alexis " %+% "Licari"

  test_2 <- "Alexis" %+% " " %+% "Licari"

  test_3 <- paste0("Alexis ", "Licari")

  expect_equal(test_1, expectation)

  expect_equal(test_2, expectation)

  options(infixit.paste = "paste")

  test_3 <- "Alexis" %+% "Licari"

  expect_equal(test_3, expectation)
})


test_that("Vectorized pasting works as expected", {
  options(infixit.paste = "paste0")

  expectation_1 <- c("Aa", "Bb", "Cc")

  test_1 <- LETTERS[1:3] %+% letters[1:3]

  test_2 <- LETTERS[1:3] %+% letters[1]

  expect_equal(test_1, expectation_1)

  expectation_2 <- c("Aa", "Ba", "Ca")

  expect_equal(test_2, expectation_2)
})



test_that("Dataframe pasting works", {
  expectation <- c("Aa", "Bb", "Cc")

  test_df <- data.frame(x = LETTERS[1:3], y = letters[1:3])

  test_1 <- test_df$x %+% test_df$y

  expect_equal(test_1, expectation)
})


test_that("Wrong option tosses error", {
  options(infixit.paste = "past")

  expect_error(
    "This should" %+% "fail",
    "can only use"
  )
})
