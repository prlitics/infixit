test_that("Null operator returns on only NULL", {
  expect_equal( NULL %||% "Song Hunter", "Song Hunter") #What, I was reading Solo leveling OK?!
  expect_equal( "S Rank" %||% "Song Hunter", "S Rank" )
})


test_that("Expanded operator returns on extended set", {
  expect_equal( NULL %|||% "Song Hunter", "Song Hunter")
  expect_equal( NA %|||% "Song Hunter", "Song Hunter")
  expect_equal(c(NA,NA) %|||% "Song Hunter", "Song Hunter")
  expect_equal(c(FALSE) %|||% "Song Hunter", "Song Hunter")
  expect_equal(c(FALSE,FALSE) %|||% "Song Hunter", "Song Hunter")
  expect_equal(integer(0) %|||% "Song Hunter", "Song Hunter")
  expect_equal(logical(0) %|||% "Song Hunter", "Song Hunter")
  expect_equal(character(0) %|||% "Song Hunter", "Song Hunter")
  expect_equal( "S Rank" %||% "Song Hunter", "S Rank" )
})


test_that("Expanded match option matches length for multiple", {
  
  options(infixit.extended_default_length = "match")
  
  expect_equal( NULL %|||% "Song Hunter", "Song Hunter")
  expect_equal( NA %|||% "Song Hunter", "Song Hunter")
  expect_equal(c(NA,NA) %|||% "Song Hunter", c("Song Hunter","Song Hunter"))
  expect_equal(c(FALSE) %|||% "Song Hunter", "Song Hunter")
  expect_equal(c(FALSE,FALSE) %|||% "Song Hunter", c("Song Hunter","Song Hunter"))
  expect_equal(integer(0) %|||% "Song Hunter", "Song Hunter")
  expect_equal(logical(0) %|||% "Song Hunter", "Song Hunter")
  expect_equal(character(0) %|||% "Song Hunter", "Song Hunter")
  expect_equal("S Rank" %||% "Song Hunter", "S Rank" )
  
  options(infixit.extended_default_length = "one")
})

test_that("Expanded match option errors work length for multiple", {
  
  options(infixit.extended_default_length = "equal")
  
  expect_error(
    NULL %|||% "Song Hunter",
    "can only use"
  )
  
  options(infixit.extended_default_length = "one")
})


test_that("Expanded match option matches allows for new tests", {
  
  options(infixit.extended_default_tests = "is_zero")
  
  is_zero <- function(x){
    
    if(length(x) >0) {
      
      if(x == 0) {return(TRUE)} else {return(FALSE)}
      
      
    } else {
      return(FALSE)
    }
    
  }
  
  assign("is_zero", is_zero, globalenv())

  expect_equal( NULL %|||% "Song Hunter", NULL)
  expect_equal( 0 %|||% "Song Hunter", "Song Hunter")
  expect_equal("S Rank" %||% "Song Hunter", "S Rank" )
  
  options(infixit.extended_default_tests = "is_OP") #Should return T for S2
  
  expect_error(
    NULL %|||% "Song Hunter",
    "could not find function"
  )
  
  rm("is_zero", envir = globalenv())
  

})

