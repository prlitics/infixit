#' Not-In Infix Operator
#'
#' This tests whether the elements on the left-hand
#' side is *not* within the elements on the right-hand
#' side. In effect, it is a cleaner, parsimonious way of
#' articulating `!(lhs %in% rhs)`. See the help
#' for `match` for additional documentation on matching.
#'
#' Following the convention of `%in%`, which is actually
#' a call to `match`, `%nin%` is defined as:
#' `match(lhs, rhs, nomatch = 0) == 0`. (In the case of
#' `%in%`, the final comparison is `> 0`; as it is
#' looking for indices of the location of `lhs[i]` within
#' `rhs`, any positive match will be greater than 0 by
#' definition since 'R' is a 1-index language rather than
#' a 0-index language such as, e.g., Python).
#'
#'
#' @param lhs The left-hand side, element(s) to be sought
#' in the rhs.
#' @param rhs The right-hand side; element(s) to be
#' compared against the lhs for possible membership.
#'
#' @return Returns a Boolean vector the length of lhs
#' conveying whether each element is **un**represented
#' in the elements of rhs.
#' @export
#'
#' @examples {
#'  
#'  "apple" %nin% c("carrot", "kiwi" ,"pear")
#' 
#' }
`%nin%` <- function(lhs, rhs) {
  results <- match(lhs, rhs, nomatch = 0) == 0

  return(results)
}
