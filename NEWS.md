
<!-- NEWS.md is generated from NEWS.rmd Please edit that file -->

# infixit

## Version 0.2.0

### Major changes
* `%btwn%` can now test whether one date is within two other comparison dates. This does not introduce any breaking changes to the previous functionality but was a pain in the ass to refactor everything, I don't mind telling you. New documentation to the README added.

### Minor changes
* Added option to generalize the pasting behavior of `%+%` so that people can specify the `sep` argument (should `infixit.paste` option be set to `"paste"`). Defaults to `" "`.
* Deleted NEWS.Rmd file, opting instead to just have NEWS.md rather than knit it.
* Added .Rbuildignore file to ignore README.Rmd file on build. Should hopefully silence current build warnings.

## Version 0.1.0

Hello world! Let’s do our best!

### Major changes.

- Everything, I guess.
