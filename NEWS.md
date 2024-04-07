# infixit

## Version 0.2.0

### Major changes
* `%btwn%` can now test whether one date is within two other comparison dates. This does not introduce any breaking changes to the previous functionality but was a pain in the ass to refactor everything to ensure that, I don't mind telling you. New documentation to the README added.
* Added 5 augmented assignment operations: `%+=%`, `%-=%`,`%*=%`,`%/=%`, and `%^=%`---which all mimic their cousins in Python. Documentation added into the package as well as the README.

### Minor changes
* Added option to generalize the pasting behavior of `%+%` so that people can specify the `sep` argument (should `infixit.paste` option be set to `"paste"`). Defaults to `" "`.
* Deleted NEWS.Rmd file, opting instead to just have NEWS.md rather than knit it.
* Added .Rbuildignore file to ignore README.Rmd file on build. Should hopefully silence current build warnings.
* Minor adjustments to the DESCRIPTION file in anticipation of a submission to CRAN.

## Version 0.1.0

Hello world! Let’s do our best!

### Major changes.

- Everything, I guess.
