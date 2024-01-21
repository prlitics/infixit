#' Paste Infix Operator
#'
#' Many programming languages utilize `+` as a means of
#' concatenating strings. In standard R, however, `+` will
#' return an error when used with strings. `%+%` ports this
#' capability over. By default, it uses `paste0` under the
#' hood, but this can be shifted to `paste` by running
#' `options(infixit.paste = "paste0")`. By default (as with
#' `paste`), this will have the seperator be a single space 
#' (`" "`) between the pasted objects. This behavior can be
#' changed with the `infixit.paste_sep` option. E.g.,
#' `options(infixit.paste_sep = "|")`
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

  if (getOption("infixit.paste") == "paste0") {
    p <- paste0(lhs, rhs)
  } else {
    p <- paste(lhs, rhs, sep = getOption("infixit.paste_sep"))
  }

  return(p)
  
}
