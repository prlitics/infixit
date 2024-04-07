




#' Addition variable reassignment
#'
#' Updates the left-hand, numeric type object by adding
#' the right-hand value to it, reassigning the sum to
#' the left-hand object.
#'
#' Currently in R, if you want to update the value
#' of a numeric object to be the outcome of some
#' arithmetic operation, you have to initialize the
#' object and then reassign it. For example:
#' `apple <- 1` and then `apple <- apple + 1`. This
#' sort of thing is generally referred to as
#' augmented variable assignment. This function allows
#' users to update the value of an object through
#' adding the value on the right-hand side.
#'
#' @param lhs An numeric object existing in the global/
#' parent environment.
#' @param rhs A numeric value to add to the sum
#'
#' @return Returns the arithmetically-updated left-hand
#' object into the environment the operation was performed in.
#' @export
#'
#' @examples {
#'
#' example <- 5
#' example %+=% 8
#' example # returns 13
#'
#' }


`%+=%` <- function(lhs, rhs) {
  nm <- deparse(substitute(lhs))
  
  .infixit_arith("%+=%", nm, rhs)
  
  
}

#' Subtraction variable reassignment
#'
#' Updates the left-hand, numeric type object by subtracting
#' the right-hand value from it, reassigning the difference to
#' the left-hand object.
#'
#' Currently in R, if you want to update the value
#' of a numeric object to be the outcome of some
#' arithmetic operation, you have to initialize the
#' object and then reassign it. For example:
#' `apple <- 1` and then `apple <- apple - 1`. This
#' sort of thing is generally referred to as
#' augmented variable assignment. This function allows
#' users to update the value of an object through
#' subtracting the value on the right-hand side.
#'
#' @param lhs An numeric object existing in the global/
#' parent environment.
#' @param rhs A numeric value to subtract from the lhs
#'
#' @return Returns the arithmetically-updated left-hand
#' object into the environment the operation was performed in.
#' @export
#'
#' @examples {
#'
#' example <- 10
#' example %-=% 3
#' example # returns 7
#'
#' }

`%-=%` <- function(lhs, rhs) {
  nm <- deparse(substitute(lhs))
  
  .infixit_arith("%-=%", nm, rhs)
  
  
}


#' Division variable reassignment
#'
#' Updates the left-hand, numeric type object by dividing
#' it by the right-hand value, reassigning the quotient to
#' the left-hand object.
#'
#' Currently in R, if you want to update the value
#' of a numeric object to be the outcome of some
#' arithmetic operation, you have to initialize the
#' object and then reassign it. For example:
#' `apple <- 10` and then `apple <- apple / 2`. This
#' sort of thing is generally referred to as
#' augmented variable assignment. This function allows
#' users to update the value of an object through
#' dividing the value on the right-hand side.
#'
#' @param lhs An numeric object existing in the global/
#' parent environment.
#' @param rhs A numeric value to divide the lhs by
#'
#' @return Returns the arithmetically-updated left-hand
#' object into the environment the operation was performed in.
#' @export
#'
#' @examples {
#'
#' example <- 10
#' example %/=% 2
#' example # returns 5
#'
#' }

`%/=%` <- function(lhs, rhs) {
  nm <- deparse(substitute(lhs))
  
  .infixit_arith("%/=%", nm, rhs)
  
  
}

#' Exponentiation variable reassignment
#'
#' Updates the left-hand, numeric type object by raising
#' it to the power of the right-hand value, reassigning
#' the result to the left-hand object.
#'
#' Currently in R, if you want to update the value
#' of a numeric object to be the outcome of some
#' arithmetic operation, you have to initialize the
#' object and then reassign it. For example:
#' `apple <- 2` and then `apple <- apple ^ 3`. This
#' sort of thing is generally referred to as
#' augmented variable assignment. This function allows
#' users to update the value of an object through
#' raising it to the power of the value on the right-hand side.
#'
#' @param lhs An numeric object existing in the global/
#' parent environment.
#' @param rhs A numeric value to raise the lhs by
#'
#' @return Returns the arithmetically-updated left-hand
#' object into the environment the operation was performed in.
#' @export
#'
#' @examples {
#'
#' example <- 2
#' example %^=% 3
#' example # returns 8
#'
#' }

`%^=%` <- function(lhs, rhs) {
  nm <- deparse(substitute(lhs))
  
  .infixit_arith("%^=%", nm, rhs)
  
  
}

#' Multiplication variable reassignment
#'
#' Updates the left-hand, numeric type object by multiplying
#' it by the right-hand value, reassigning the product to
#' the left-hand object.
#'
#' Currently in R, if you want to update the value
#' of a numeric object to be the outcome of some
#' arithmetic operation, you have to initialize the
#' object and then reassign it. For example:
#' `apple <- 2` and then `apple <- apple * 3`. This
#' sort of thing is generally referred to as
#' augmented variable assignment. This function allows
#' users to update the value of an object through
#' multiplying it by the value on the right-hand side.
#'
#' @param lhs An numeric object existing in the global/
#' parent environment.
#' @param rhs A numeric value to multiply the lhs by
#'
#' @return Returns the arithmetically-updated left-hand
#' object into the environment the operation was performed in.
#' @export
#'
#' @examples {
#'
#' example <- 3
#' example %*=% 4
#' example # returns 12
#'
#' }

`%*=%` <- function(lhs, rhs) {
  nm <- deparse(substitute(lhs))
  
  .infixit_arith("%*=%", nm, rhs)
  
  
}


.infixit_arith <- function(type, lhs_name, rhs) {
  if (!(is.numeric(rhs))) {
    stop(paste0("rhs of \`", type, "\` must be of type numeric."))
    
  }
  
  
  old_val <- get(lhs_name, parent.frame(2))
  
  new_val <- .infixit_arith_execute(type, old_val, rhs)
  
  if ((length(old_val) !=  length(new_val))  &&
      ((length(old_val) %% length(new_val)) != 0)) {
    stop('if not the same length, length of rhs must be a multiple of l
         ength of lhs')
    
  }
  
  
  assign(lhs_name, new_val, parent.frame(2))
  
}




.infixit_arith_execute <- function(operation, orig_value, rhs) {
  arith_fun <- switch (
    operation,
    "%+=%" = `+`,
    "%-=%" = `-`,
    "%^=%" = `^`,
    "%*=%" = `*`,
    "%/=%" = `/`
  )
  
  
  if (is.null(arith_fun)) {
    stop(paste(
      "Operation \`",
      operation,
      "\` is not currently supported in infixit."
    ))
    
  } else {
    return(do.call(arith_fun, list(orig_value, rhs)))
    
  }
  
  
  
  
}
