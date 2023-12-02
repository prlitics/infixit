test_that("Expected behavior", {
  
  test_1 <- "a" %nin% c("a", "b", "c")
  
  expect_false(test_1)
  
  expectation_2 <- c(FALSE, TRUE, TRUE)
  
  test_2 <- c("a", "f", "z") %nin% c("a", "b", "c")

  expect_equal(test_2, expectation_2)
  
  test_3 <- !(c("a", "f", "z") %in% c("a", "b", "c"))
  
  expect_equal(test_2, test_3)
  
  test_4 <- match(c("a", "f", "z"), c("a", "b", "c"), nomatch = 0) == 0
  
  expect_equal(test_2, test_4)
  
  })
