#' Between Infix Operator
#'
#' Currently in R, if you want to test if a value is
#' between two others, you have to set it up in a
#' cumbersome manner: `X > Y & X < Z`. `%btwn%` simplifies
#' the operation into a single call: `X %btwn% c(Y, Z)`.
#'
#' By default, `%btwn%` evaluates *inclusively*. That is,
#' if the right-hand side is `c(1, 5)` and the left-hand
#' side is `c(1,5)`, it will evaluate as `TRUE TRUE`. If
#' one wants to adjust this default behavior, they can
#' adjust the "infix.btwn" option to be either *inclusive*
#' for the lower-bound ("\["), *exclusive* for the lower-
#' bound ("("), *inclusive* for the upper-bound ("\]"),
#' or *exclusive* for the upper-bound (")"). To set an
#' inclusive lower-bound but exclusive upper-bound, for
#' example, you would do as follows:
#' `options(infixit.btwn = c("[", ")"))`. This can be
#' helpful behavior in the `case_when()` function from the
#' `dplyr` package.
#'
#' @param lhs The left-hand side, the value(s) to be compared.
#' @param rhs The right-hand side, the comparative range. Must
#' be a numeric vector of length 2 with the smaller value prior
#' to the larger value. Identical values can be passed.
#'
#' @return A Boolean vector the same length as the left-hand
#' side input.
#' @export
#'
#' @examples {
#'   13 %btwn% c(12.5, 15)
#' }
#'
`%btwn%` <- function(lhs, rhs) {
  
  if ((length(rhs) != 2)) {
    
    stop("Comparison must only be made of a numeric or datetime vector of length 2.")
    
  }
  

  if (any(is.na(rhs))) {
    stop("Comparative range must not include an NA.")
  }


  same_types <- .check_btwn_lhs_rhs_same_accepted_type(lhs, rhs)
  lhs <- .btwn_convert(lhs, same_types)
  rhs <- .btwn_convert(rhs, same_types)
  
  
  if (rhs[[1]] > rhs[[2]]) {
    stop("Elements of comparative range must be arranged c(lower_number, larger_number)")
  }

  ops <- options("infixit.btwn")[[1]]

  if (ops[1] == "[") {
    lcomp <- `>=`
  } else if (ops[1] == "(") {
    lcomp <- `>`
  } else {
    stop("Element 1 of options(infixit.btwn) must either be \"[\" or \"(\"")
  }

  if (ops[2] == "]") {
    rcomp <- `<=`
  } else if (ops[2] == ")") {
    rcomp <- `<`
  } else {
    stop("Element 2 of options(infixit.btwn) must either be \"]\" or \")\"")
  }


  result <- unlist(lapply(lhs, \(x){
    lcomp(x, rhs[[1]]) && rcomp(x, rhs[[2]])
  }))

  return(result)
}



# Converts vectors into a numeric type. Returns 
# original vector when it's numeric but converts to
# numeric so as to perform a between operation

.btwn_convert <- function(vec, type) {
  ret_vec <- switch (
    type,
    datetime = as.numeric(as.POSIXlt(
      vec, tryFormats = c(getOption("infixit.btwn.datefmt"), 
                          getOption("infixit.btwn.datetimefmt"))
    )),
    number = vec
  )
  
  if (!is.null(ret_vec)) {
    return(ret_vec)
    
  } else{
    stop(
      "Error in parsing vector types. Must be a numeric or a date matching the formats in getOption(\"infixit.btwn.datefmt\") or getOption(\"infixit.btwn.datetimefmt\")"
    )
    
  }
  
  
  
}



.check_btwn_lhs_rhs_same_accepted_type <- function(lhs, rhs) {
  
  lhs_numeric <- is.numeric(lhs)
  rhs_numeric <- is.numeric(rhs)
  
  if (lhs_numeric && rhs_numeric) {
    return("number")
    
  } else {
    lhs_datetype <-
      .check_btwn_vec_is_date(lhs, c(
        getOption("infixit.btwn.datetimefmt")
      ))
    
    
    rhs_datetype <-
      .check_btwn_vec_is_date(rhs, c(
        getOption("infixit.btwn.datetimefmt")
      ))
    
    if ( (isFALSE(lhs_numeric) & isFALSE(lhs_datetype)) | (isFALSE(rhs_numeric) & isFALSE(rhs_datetype))){
      
      
      stop("Invalid types for %btwn% comparisons! left-hand-side and right-hand-side must either be numeric or date strings matching the formats in  getOption(\"infixit.btwn.datefmt\") or getOption(\"infixit.btwn.datetimefmt\")")
      
      
    }
    
    
    
    if ((lhs_datetype == rhs_datetype) && !isFALSE(lhs_datetype)) {
      
      return(lhs_datetype)
      
      
    } else if ((lhs_datetype != rhs_datetype) | (lhs_numeric != rhs_numeric) )  {
      
      stop(
        "left-hand-side and right-hand-side are not of the same type! Ensure they are of the same type before using %btwn%. \nAccepted types are numeric and date strings matching the formats in  getOption(\"infixit.btwn.datefmt\") or getOption(\"infixit.btwn.datetimefmt\")"
      )
      
      
    } else {
      
      stop(
        "Invalid types for %btwn% comparisons! left-hand-side and right-hand-side must either be numeric or date strings matching the formats in  getOption(\"infixit.btwn.datefmt\") or getOption(\"infixit.btwn.datetimefmt\")"
      )
      
      
    }
    
    
    
  }
  
  
}



.check_btwn_vec_is_date <- function(vec, formats){
  

  try_datetime <- tryCatch(
    as.POSIXlt(vec, tryFormats = formats),
    error = function(e) {
      return(NA)
    })
  
  if (all(is.na(try_datetime))){
    
    return(FALSE)
    
  } else {
      
      return("datetime")
      
    }
    
  
}

