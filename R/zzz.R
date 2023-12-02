.onLoad <- function(libname, pkgname) {
  op <- options()
  op.infixit <- list(infixit.btwn = c("[", "]"),
                     infixit.paste = "paste0")
  toset <- !(names(op.infixit) %in% names(op))
  if (any(toset))
    options(op.infixit[toset])
}
