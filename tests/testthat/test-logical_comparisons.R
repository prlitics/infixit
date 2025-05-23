

test_that("functions work", {
  expect_equal(TRUE %nand% TRUE, FALSE)
  expect_equal(TRUE %nand% FALSE, TRUE)
  expect_equal(FALSE %nand% TRUE, TRUE)
  expect_equal(FALSE %nand% FALSE, TRUE)
  
  expect_equal(c(FALSE,TRUE,TRUE) %nand% c(FALSE,FALSE,TRUE), c(TRUE,TRUE,FALSE))
  
  
  expect_equal(TRUE %xor% TRUE, FALSE)
  expect_equal(TRUE %xor% FALSE, TRUE)
  expect_equal(FALSE %xor% TRUE, TRUE)
  expect_equal(FALSE %xor% FALSE, FALSE)
  
  expect_equal(c(TRUE,FALSE,TRUE) %xor% c(TRUE,FALSE,FALSE), c(FALSE,FALSE,TRUE))
  
})