


test_that("addition works", {
  tmp1 <- 0
  
  tmp1 %+=% 4
  
  expect_equal(tmp1, 4)
  
})


test_that("subtraction works", {
  tmp1 <- 0
  
  tmp1 %-=% 4
  
  expect_equal(tmp1, -4)
  
})


test_that("exponentiation works", {
  tmp1 <- 2
  
  tmp1 %^=% 3
  
  expect_equal(tmp1, 8)
  
})

test_that("division works", {
  tmp1 <- 6
  
  tmp1 %/=% 3
  
  expect_equal(tmp1, 2)
  
})

test_that("multiplication works", {
  tmp1 <- 6
  
  tmp1 %*=% 3
  
  expect_equal(tmp1, 18)
  
})



test_that("math operations are vectorized", {
  tmp1 <- 1:3
  
  tmp1 %+=% 1
  
  expect_equal(tmp1, 2:4)
  
  tmp1 %-=% c(1,2,3)
  
  expect_equal(tmp1, c(1,1,1))
  
  
})



test_that("Operations work in a loop", {
  
  tmp1 <- 0
  
  for (i in 1:5){
    
    tmp1 %+=% i
    
  }

  expect_equal(tmp1, 15)
  
})


test_that("Operations require numeric",{
  
  tmp <- 0
  expect_error(tmp %+=% "pear", "must be of type numeric")
  expect_error(tmp %+=% as.factor("pear"), "must be of type numeric")

})





test_that("Operations work in functional scope", {
  
  
  tmp_function<- function(x){
    
    tmp <- 5
    
    tmp %^=% x
    
    return(tmp)
    
    
  }
  
  expect_equal(tmp_function(2),25)
  
  expect_equal(tmp_function(3),125)
  
})

test_that("Assignment is not global",{
  
  tmp_val <- 0
  
  tmp_function <- function(x){
    
    for (i in seq.int(x)) {
      
      tmp_val %+=% 1
      
      
    }

  }
  
  tmp_function(5)
  
  expect_false(identical(5,tmp_val))
  expect_equal(0,tmp_val)

  
})

