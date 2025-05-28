#' Default NULL operator
#'
#' This operator is seen in `{rlang}` and has been included
#' in base R since version 4.4.0. If the left-hand side
#' is NULL, it will automatically return the value of
#' the right-hand side. This is useful for programming
#' to ensure a function or process returns a non-null
#' default.
#' 
#' @name null-default
#' @param x The left-hand side, the value(s) to be evaluated
#' as either NULL or not.
#' @param y The right-hand side, the value(s) to be returned
#' if `lhs` evaluates to NULL.
#'
#' @return An atomic value or vector the same length as the left-hand
#' side input.
#' @export
#'
#' @examples {
#'   NULL %||% 'fizzbuzz' #returns fizzbuzz
#'   'test' %||% 'fizzbuzz'#returns 'test'
#' }
#'
#'
`%||%` <- function(x, y) {
  if (is.null(x)) {
    return(y)
    
  } else {
    return(x)
  }
  
}


#' Expanded default operator
#'
#' The `%||%` operator will return a default value,
#' defined by the right-hand object, if the left-hand value
#' resolves as `NULL`. However, there may be times when users
#' want more than just `NULL` values to return the default but,
#' also, values that are `NA`, `FALSE`, and those that are
#' length 0 (such as `character(0)` or `integer(0)`). 
#'@details 
#' The expanded default operator covers the following cases:
#'
#' * `NULL`
#' * An atomic `FALSE`
#' * A vector where all values are `FALSE`
#' * An atomic `NA`
#' * A vector where all values are `NA`
#' * An object of length 0.
#'
#'  Users have the ability to add additional tests via
#'  `options(infixit.extended_default_tests)`. Users can change
#'  the current list---including by adding the name of a testing
#'  function (i.e., one that returns a Boolean value) that is
#'  currently defined in an environment accessible to the function
#'  (e.g., in the global environment).
#'
#' @name extended-null-default
#' @param lhs The left-hand side, the value(s) to be evaluated
#' as.
#' @param rhs The right-hand side, the value(s) to be returned
#' if `lhs` evaluates as one of the covered values.
#'
#' @return An atomic value or vector the same length as the left-hand
#' side input.
#' @export
#'
#' @examples {
#'   NULL %|||% 'fizzbuzz' #returns fizzbuzz
#'   FALSE %|||% 'fizzbuzz' #also returns fizzbuzz
#'   NA %|||% 'fizzbuzz' #still returns fizzbuzz
#'   'test' %|||% 'fizzbuzz'#returns 'test'
#' }
#'
#'
`%|||%` <- function(lhs, rhs) {
  tmp_call <- function(x, y) {
    return(call(x, y))
  }
  
  match_option <- tolower(options("infixit.extended_default_length"))
  if ((match_option %nin% c("match", "one"))) {
    stop("options(\"infixit.extended_default_length\") can only use \"match\" or \"one\".")
  }
  
  if (match_option == 'match'){
    
    rep_value = length(lhs)
    
    if (rep_value == 0){
      
      rep_value <- 1
      
    }
    
  } else {
    
    rep_value <- 1
    
  } 
  
  tests <- lapply(options("infixit.extended_default_tests")[[1]], tmp_call, lhs)
  
  evaluated <- unlist(lapply(tests, eval))
  
  if (any(evaluated)) {
    
    return(rep(rhs, rep_value))
    
  } else {
    return(lhs)
  }
}

## Taking a page from Rlang to avoid conflict messages for newer versions of R
## where %||% comes prepackaged

if (exists("%||%", envir = baseenv())) {
  `%||%` <- get("%||%", envir = baseenv())
}



#' Tests if a vector is entirely comprised of NAs
#'
#' This function tests if a passed object is entirely comprised
#' of `NA` values.
#' 
#' @details
#' This function is exported in order to provide one of the default
#' tests for the `%|||%` function and is not really intended for 
#' use outside of that context.
#' 
#' 
#' @name .is_allNA
#' @param x The object to test if is entirely comprised of `NA` values
#'
#' @return A boolean (`TRUE` or `FALSE`)
#' @export
#'
#' @examples {
#'   .is_allNA(c(NA,NA,"NA")) # Will return FALSE
#' }
.is_allNA <- function(x) {
  if (all(is.na(x)))
    TRUE
  else
    FALSE
  
}


#' Tests if an object is entirely comprised of `FALSE`s
#'
#' This function tests if a passed object is entirely comprised
#' of `FALSE` values.
#' 
#' @details
#' This function is exported in order to provide one of the default
#' tests for the `%|||%` function and is not really intended for 
#' use outside of that context.
#' 
#' 
#' @name .is_allFalse
#' @param x The object to test if is entirely comprised of `FALSE` values
#'
#' @return A boolean (`TRUE` or `FALSE`)
#' @export
#'
#' @examples {
#'   .is_allFalse(c(FALSE,FALSE,TRUE)) # Will return FALSE
#' }
#' 
#' @export
.is_allFalse <- function(x) {
  if (all(unlist(lapply(x, isFALSE))))
    TRUE
  else
    FALSE
  
}

#' Tests if an object is of length 0
#'
#' This function tests if a passed object is of length 0.
#' 
#' @details
#' This function is exported in order to provide one of the default
#' tests for the `%|||%` function and is not really intended for 
#' use outside of that context.
#' 
#' 
#' @name .is_length_zero
#' @param x The object to test if is length(0)
#'
#' @return A boolean (`TRUE` or `FALSE`)
#' @export
#'
#' @examples {
#'   .is_allFalse(c(FALSE,FALSE,TRUE)) # Will return FALSE
#' }
#' 
#' @export
.is_length_zero <- function(x) {
  if (!length(x))
    TRUE
  else
    FALSE
  
}
