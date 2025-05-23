.onLoad <- function(libname, pkgname) {
  op <- options()
  op.infixit <- list(infixit.btwn = c("[", "]"),
                     infixit.btwn.ignore_na = TRUE,
                     infixit.paste = "paste0",
                     infixit.paste_sep = " ",
                     infixit.btwn.datetimefmt = c("%Y-%m-%d %H:%M:%OS",
                                                  "%Y/%m/%d %H:%M:%OS",
                                                  "%Y/%m/%d %H:%M",
                                                  "%Y-%m-%d",
                                                  "%Y/%m/%d"),
                     infixit.extended_default_tests = c('.is_allNA','is.null','.is_length_zero','isFALSE', '.is_allFalse'),
                     infixit.extended_default_length = c('one'))
  toset <- !(names(op.infixit) %in% names(op))
  if (any(toset))
    options(op.infixit[toset])
}
