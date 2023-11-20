#' Paste Infix Operator
#'
#' Many programming languages utilize `+` as a means of
#' concatenating strings. In standard R, however, `+` will
#' return an error when used with strings. `%+%` ports this
#' capability over. By default, it uses `paste0` under the
#' hood, but this can be shifted to `paste` by running
#' `options(infixit.paste = "paste0")`.
#'
#' @param lhs The left-hand side.
#' @param rhs The right-hand side.
#'
#' @return A string pasting the rhs to the lhs.
#' @export
#'
#' @examples {
#'
#' b <- "An additional sentence."
#'
#' "This is a sentence. " %+% b
#' }
`%+%` <- function(lhs, rhs) {
  if (!(options("infixit.paste") %in% c("paste", "paste0"))) {
    stop("options(\"infixit.paste\") can only use \"paste\" or \"paste0\".")
  }

  if (options("infixit.paste") == "paste0") {
    p <- paste0
  } else {
    p <- paste
  }


  p(lhs, rhs)
}
