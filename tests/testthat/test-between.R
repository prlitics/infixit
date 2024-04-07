test_that("Errors run", {
  expect_error(
    3 %btwn% c("2012-02-01", "2023-02-01")
  )
  
  expect_error(
    "3" %btwn% c("1", "5"),
    "Invalid types for %btwn% comparisons"
  )
  

  expect_error(
    3 %btwn% c(TRUE, FALSE),
    "Invalid types for %btwn% comparisons!"
  )

  expect_error(
    3 %btwn% c(1, 5, 6),
    "Comparison must only be made of a numeric"
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

test_that("Date and Datetime errors catch",{
  
  expect_error("Apr151994" %btwn% c("1951-05-28","2024-01-01") ,
               "Invalid types for %btwn% comparisons!")
  
  
  expect_error("1994-05-11" %btwn% c("1951-05-28","Jan 1 2024") ,
               "Invalid types for %btwn% comparisons!")
  
  
  
  expect_error("1994-05-11" %btwn% c("May 28 1951","Jan 1 2024") ,
               "Invalid types for %btwn% comparisons!")
  
  
})


test_that("Date and Datetime works",{
  
  expect_true("1994-05-11" %btwn% c("1994-04-15","2024-04-15"))

  expect_true(all(c("1994-05-11","2020-03-13") %btwn% c("1994-04-15","2024-04-15")))
  
  test_vec1 <- c("1994-05-11","2020-03-13", "1966-10-30") %btwn% c("1994-04-15","2024-04-15")
  expect_vec1 <- c(TRUE,TRUE,FALSE)
  
  expect_equal(test_vec1, expect_vec1)
  
  expect_true(all(c("1994-05-11 23:59","2020-03-13") %btwn% c("1994-04-15","2024-04-15")))

  options(infixit.btwn.datetimefmt = "%b %d, %Y")
  
  expect_true(all(c("May 11, 1994","Mar 13, 2020") %btwn% c("Apr 15, 1994","Apr 15, 2024")))
  
  
  
  test_vec2 <- c("May 11, 1994","Mar 13, 2020", "Oct 30, 1966") %btwn% c("Apr 15, 1994","Apr 15, 2024")
  expect_vec2 <- c(TRUE,TRUE,FALSE)
  expect_equal(test_vec2, expect_vec2)
  
  
  
  options(infixit.btwn.datetimefmt = c("%b %d, %Y", "%Y-%m-%d"))
  
  expect_true(all(c("May 11, 1994","Mar 13, 2020") %btwn% c("1994-04-15","2024-04-15")))
  
  test_vec3 <- c("May 11, 1994","Mar 13, 2020", "Oct 30, 1966") %btwn% c("1994-04-15","2024-04-15")
  expect_vec3 <- c(TRUE,TRUE,FALSE)
  expect_equal(test_vec3, expect_vec3)
  
  
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
