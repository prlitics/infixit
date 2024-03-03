.onLoad <- function(libname, pkgname) {
  op <- options()
  op.infixit <- list(infixit.btwn = c("[", "]"),
                     infixit.paste = "paste0",
                     infixit.paste_sep = " ",
                     infixit.btwn.datetimefmt = c("%Y-%m-%d %H:%M:%OS",
                                                  "%Y/%m/%d %H:%M:%OS",
                                                  "%Y/%m/%d %H:%M",
                                                  "%Y-%m-%d",
                                                  "%Y/%m/%d"))
  toset <- !(names(op.infixit) %in% names(op))
  if (any(toset))
    options(op.infixit[toset])
}
