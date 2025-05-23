#' NAND infix operator
#'
#' This is a logical operator that implements NAND (NOT AND). 
#'@details
#' The NAND truth table is the inverse of the AND table:
#'
#'
#' |LHS|RHS|Value|
#' |---|---|-----|
#' |TRUE|TRUE|FALSE|
#' |TRUE|FALSE|TRUE|
#' |FALSE|TRUE|TRUE|
#' |FALSE|FALSE|TRUE|
#' 
#' @param lhs The left-hand side(s).
#' @param rhs The right-hand side value(s).
#'
#' @return An atomic value or vector the same length as the left-hand
#' side input.
#' @export
#' @examples {
#'   TRUE %!&% TRUE # Evaluates to FALSE
#'   FALSE %!&% TRUE # Evaluates to TRUE
#'   FALSE %!&% FALSE # Evaluates to TRUE
#' }

`%!&%` <- function(lhs, rhs) {
  return(!(rhs & lhs))
}


#' XOR infix operator
#'
#' This is a logical operator that implements XOR. (Exclusive or). 
#' 
#'@details
#' The XOR truth-table is as follows:
#'
#' |LHS|RHS|Value|
#' |---|---|-----|
#' |TRUE|TRUE|FALSE|
#' |TRUE|FALSE|TRUE|
#' |FALSE|TRUE|TRUE|
#' |FALSE|FALSE|FALSE|
#' 
#' In contrast with the standard OR, XOR evaluates to FAlSE if both
#' arguments are TRUE.
#'
#' @param lhs The left-hand side(s).
#' @param rhs The right-hand side value(s).
#'
#' @return An atomic value or vector the same length as the left-hand
#' side input.
#' @export
#' @examples {
#'   TRUE %x|% TRUE # Evaluates to FALSE
#'   FALSE %x|% TRUE # Evaluates to TRUE
#' }
#'
#'

`%x|%`  <- function(lhs, rhs) {
  return((lhs | rhs) & !(lhs & rhs))

  
  
}


#' @rdname grapes-x-or-grapes
#' @aliases %x|%
#' @export
`%xor%` <- `%x|%`

#' @rdname grapes-not-and-grapes
#' @aliases %!&%
#' @export
`%nand%` <- `%!&%`