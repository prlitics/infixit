test_that("Errors run", {
  expect_error(
    3 %btwn% c("1", 5),
    "Comparison must only be made of numeric"
  )

  expect_error(
    3 %btwn% c(TRUE, FALSE),
    "Comparison must only be made of numeric"
  )

  expect_error(
    3 %btwn% c(1, 5, 6),
    "Comparison must only be made of numeric"
  )

  expect_error(
    3 %btwn% c(5, 1),
    "Elements of comparative range must be arranged"
  )


  expect_error(
    3 %btwn% c(NA, 1),
    "Comparative range must not include an NA"
  )

  options(infixit.btwn = c("|", "]"))

  expect_error(
    3 %btwn% c(1, 5),
    "Element 1 of options"
  )


  options(infixit.btwn = c("[", "|"))


  expect_error(
    3 %btwn% c(1, 5),
    "Element 2 of options"
  )


  options(infixit.btwn = c("[", "]"))
})



test_that("Inclusive behavior works", {
  options(infixit.btwn = c("[", "]"))

  expect_true(3 %btwn% c(1, 3))

  expect_true(3 %btwn% c(3, 4))

  options(infixit.btwn = c("(", "]"))

  expect_true(3 %btwn% c(1, 3))

  expect_false(3 %btwn% c(3, 4))

  options(infixit.btwn = c("[", ")"))

  expect_false(3 %btwn% c(1, 3))

  expect_true(3 %btwn% c(3, 4))

  options(infixit.btwn = c("(", ")"))

  expect_false(3 %btwn% c(1, 3))

  expect_false(3 %btwn% c(3, 4))

  options(infixit.btwn = c("[", "]"))
})


test_that("Different number types work", {
  val <- rnorm(1, 50)

  expect_true(val %btwn% c(floor(val) - 1, ceiling(val) + 1))

  expect_true(val %btwn% c(val - .1, val + 1))

  expect_true(val %btwn% c(val, val))


  val <- floor(runif(1, 1, 10))

  expect_true(val %btwn% c((val - 1), (val + 1)))

  expect_true(val %btwn% c((val - .5), (val + .5)))
})

test_that("Basic behavioral expectations", {
  val <- floor(runif(1, 1, 10))

  expect_false(val %btwn% c(val - 2, val - 1))

  expect_true(val %btwn% c(val - 2, val + 1))

  expect_true(val %btwn% c(val - 1000, val + 1))
  
  val <- 3
  
  expect_true(val %btwn% c(3, 3))
  
  expect_false(val %btwn% c(4, 4))
  
  options(infixit.btwn = c("(", ")"))
  
  expect_false(val %btwn% c(3, 3))
  
  options(infixit.btwn = c("[", ")"))
  
  expect_false(val %btwn% c(3, 3))
  
})



test_that("Multiple Lengths", {
  
  options(infixit.btwn = c("[", "]"))
  
  expectation <- c(rep(FALSE, 2), rep(TRUE, 5), rep(FALSE, 2))

  test_1 <- 1:9 %btwn% c(3, 7)

  expect_identical(test_1, expectation)
})
