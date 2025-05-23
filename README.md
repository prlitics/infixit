
<!-- README.md is generated from README.Rmd. Please edit that file -->

# infixit <img src="man/figures/logo.png" align="right" height="138"/>

<!-- badges: start -->

[![R-CMD-check](https://github.com/prlitics/infixit/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/prlitics/infixit/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/prlitics/infixit/branch/main/graph/badge.svg)](https://app.codecov.io/gh/prlitics/infixit?branch=main)

<!-- badges: end -->

> Infix functions get their name from the fact the function name comes
> inbetween its arguments, and hence have two arguments.
>
> — Hadley Wickham, [Advanced
> R](https://adv-r.hadley.nz/functions.html#:~:text=Infix%20functions%20get%20their%20name,%2C%20%3C%3D%20%2C%20%3D%3D%20%2C%20!%3D)

`{infixit}` is an R package that looks to extend the available infix
operators in R with some that are helpful for programming and data
manipulation tasks. Additionally, the specific behaviors of many of
these operators are (to an extent) customizable using some of the
package’s `options()`.

It can be downloaded through the following:

``` r
library(remotes)
install_github("prlitics/infixit")
```

There are currently 12 infix functions packaged with `{infixit}`:

1.  `%+%`: Providing string concatenation.
2.  `%nin%`: Providing the inverse of the `%in%` function (e.g., whether
    an element of $X$ *is **not*** in $Y$).
3.  `%btwn%`: Lets users determine if numeric elements (including date
    objects) of $X$ are **b**e**tw**ee**n** values $Y_1$ and $Y_2$.
4.  Five augmented assignment operations which take the left-hand object
    and reassigns its value based off the right-hand value. For example,
    let’s say we have an object `apple` with a value of 12.
    `apple %+=% 1` takes the current value of `apple`, adds 1 to it
    (12 + 1 = 13), and then updates the value of `apple` to this sum.
    The five operations are:
    - `%+=%`: Updates left-hand object by *adding* it to the right-hand
      object.
    - `%-=%`: Updates left-hand object by *subtracting* it from the
      right-hand object.
    - `%/=%`: Updates left-hand object by *dividing* it by the
      right-hand object.
    - `%*=%`: Updates left-hand object by *multiplying* it by the
      right-hand object.
    - `%^=%`: Updates left-hand object by *exponentiating* it by the
      right-hand object.
5.  `%||%`: Null-default operator; if left-hand value is `NULL` will
    return the right-hand value (now in base starting in R 4.4, also
    found in `{rlang}`)
6.  `%|||%`: Extended-default operator: will return the right-hand value
    if left-hand value is any of the following:
    - A vector where all values are `FALSE`
    - A single `FALSE` value
    - An object of `length(0)` (e.g., `character(0)`)
    - `NULL`
    - A vector where all values are `NA` or single `NA` value
7.  Two extended logical comparisons:
    - `%nand%` implementing NAND.
    - `%xor%` implementing XOR.

While there are ways to achieve the end-behaviors of these functions,
the intent is to do so in a way that maximizes the ease of coders and
the readability of the code they produce.

## Code Examples

### `%+%` (String Concatenation)

Use `%+%` to paste strings together without wrapping it within `paste0`
or `paste`.

``` r
a <- "Hello "
b <- "world!"
c <- " Let's do our best!"

a %+% b %+% c
```

    ## [1] "Hello world! Let's do our best!"

However, it some instances, users might apprciate having a bit of extra
padding to their strings, such as pasting full sentences together. By
default `%+%` wraps around `paste0`, but`infixit` has the option for
users to specify `paste` as the concatenation method, which will add a
space between pasted objects.

``` r
options(infixit.paste = "paste") #default is paste0

a <- "Hello" #Notice no trailing space here to accommodate "world"
b <- "world!"
c <- "Let's do our best!" #No leading space here.

a %+% b %+% c
```

    ## [1] "Hello world! Let's do our best!"

In cases where the user wants to use a different separator when using
`"paste"` rather than the default `" "`, they can specify this using the
`infixit.paste_sep` option. In the example below, this is done to change
the delimiter to be a vertical pipe (“\|”):

``` r
options(infixit.paste_sep = "|") #default is paste0

a <- "Hello" 
b <- "world!"
c <- "Let's do our best!"

a %+% b %+% c
```

    ## [1] "Hello|world!|Let's do our best!"

### `%nin%` (Not in)

Normally, you can use `%in%` to check if your left-hand-side element is
**in** the set of elments on the right hand side.

``` r
fruits <- c("apple", "banana", "kiwi", "pears")

"apple" %in% fruits
```

    ## [1] TRUE

``` r
"tomato" %in% fruits
```

    ## [1] FALSE

Use `%nin%` when you want to select features that are **n**ot **in** a
set of values.

``` r
fruits <- c("apple", "banana", "kiwi", "pears")

"apple" %nin% fruits
```

    ## [1] FALSE

``` r
"tomato" %nin% fruits
```

    ## [1] TRUE

`%nin` can be useful when you’re filtering data. Let’s say, for example,
that you are working with the `penguins` data from the
[`{palmerpenguins}`](https://allisonhorst.github.io/palmerpenguins/)
package. You are only interested in penguins that are not from either
“Torgersen” nor “Biscoe” islands.

``` r
suppressPackageStartupMessages(library(palmerpenguins))
suppressPackageStartupMessages(library(dplyr))

penguins %>%
  filter(island %nin% c("Torgersen", "Biscoe")) %>%
  count(island)
```

    ## # A tibble: 1 × 2
    ##   island     n
    ##   <fct>  <int>
    ## 1 Dream    124

Now the data are only limited to “Dream” island. Though a relatively
simple example, this functionality can be especially useful if you have
a long list of things that a value could be `%in%`.

### `%btwn%` (Whether a numeric value is between two others)

Use `%btwn%` to determine whether values on the left-hand-side are
within the bounds defined on the right-hand-side. `%btwn%` can
accomodate integer, double numeric-types as well as strings that can be
coerced into a date or POSIXlt object: basically anything that, at the
end of the day, can be coerced to a numeric value.

``` r
c(1,2,3.5,4.2,5,6) %btwn% c(2,4)
```

    ## [1] FALSE  TRUE  TRUE FALSE FALSE FALSE

``` r
dates_seq <- seq(as.Date("2020-01-01"),as.Date("2021-03-31"), by = "month")

dates_seq %btwn% c("2019-12-31","2021-01-01")
```

    ##  [1]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
    ## [13]  TRUE FALSE FALSE

You can pass unique datetime formats for the comparison set via the
“infixit.btwn.datetimefmt” option.

``` r
options(infixit.btwn.datetimefmt = "%b %d, %Y")
dates_seq %btwn% c("Dec 31, 2019", "Jan 01, 2021")
```

    ##  [1]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
    ## [13]  TRUE FALSE FALSE

By default, the bounds on the right-hand-side are considered
***inclusive***, meaning that if a left-hand-side value matches one of
the two bounds, it will return as `TRUE`. In mathematics, inclusivity
can be denoted with square brackets “\[” or ”\]”. It is possible to
change the behavior such that the values are **exclusive**, meaning that
an exact match for the specified boundary value will return as `FALSE`.

The “infixit.btwn” option that is loaded with the package allows users
to define whether the lower boundary is (in/ex)clusive and/or whether
the upper boundary is (in/ex)clusive.

``` r
options(infixit.btwn = c("[","]")) #inclusive left and right, default
c(1,2,3,4,5) %btwn% c(2,4)
```

    ## [1] FALSE  TRUE  TRUE  TRUE FALSE

``` r
options(infixit.btwn = c("[",")")) #inclusive left, exclusive right
c(1,2,3,4,5) %btwn% c(2,4)
```

    ## [1] FALSE  TRUE  TRUE FALSE FALSE

``` r
options(infixit.btwn = c("(","]")) #exclusive left, inclusive right
c(1,2,3,4,5) %btwn% c(2,4)
```

    ## [1] FALSE FALSE  TRUE  TRUE FALSE

``` r
options(infixit.btwn = c("(",")")) #exclusive left and right
c(1,2,3,4,5) %btwn% c(2,4)
```

    ## [1] FALSE FALSE  TRUE FALSE FALSE

Additionally, users have the option to determine whether `NA` values are
considered to be `%btwn%` their lhs and rhs variables. By default, the
function returns `NA` but can be configured to return `FALSE`

``` r
c(NA, 1,2,3,4,5) %btwn% c(2,4) # Will return NA for the first item in the vector.
```

    ## [1]    NA FALSE FALSE  TRUE FALSE FALSE

``` r
options(infixit.btwn.ignore_na = FALSE)
c(NA, 1,2,3,4,5) %btwn% c(2,4) # Will return FALSE for the first item in the vector.
```

    ## [1] FALSE FALSE FALSE  TRUE FALSE FALSE

`%btwn%` can be especially helpful in the context of `{dplyr}`’s
`case_when` function. Let’s imagine that we are trying to group penguins
by body mass (chunk ’em by chonk, one might say). We want to put them
into quartiles; 0-24.99% of the sample, 25-49.99% of the sample,
50-74.99% of the sample, and 75% to the sample max. We can discover
these values using the `quantile` function.

``` r
quantile(penguins$body_mass_g, na.rm = TRUE)
```

    ##   0%  25%  50%  75% 100% 
    ## 2700 3550 4050 4750 6300

A normal way to do this with `case_when` would be:

``` r
penguins %>%
  mutate(chonk_level = case_when(
    
    body_mass_g < 3550 ~ 1,
    body_mass_g >= 3550 & body_mass_g < 4050 ~ 2,
    body_mass_g >= 4050 & body_mass_g < 4750 ~ 3,
    body_mass_g >= 4750 ~ 4
    
  )) %>% 
  select(body_mass_g, chonk_level) %>%
  head()
```

    ## # A tibble: 6 × 2
    ##   body_mass_g chonk_level
    ##         <int>       <dbl>
    ## 1        3750           2
    ## 2        3800           2
    ## 3        3250           1
    ## 4          NA          NA
    ## 5        3450           1
    ## 6        3650           2

With `%btwn%`:

``` r
options(infixit.btwn = c("[",")"))

penguins %>%
  mutate(chonk_level = case_when(
    
    body_mass_g < 3550 ~ 1,
    body_mass_g %btwn% c(3550, 4050) ~ 2,
    body_mass_g %btwn% c(4050, 4750) ~ 3,
    body_mass_g >= 4750 ~ 4
    
  )) %>% 
  select(body_mass_g, chonk_level) %>%
  head()
```

    ## # A tibble: 6 × 2
    ##   body_mass_g chonk_level
    ##         <int>       <dbl>
    ## 1        3750           2
    ## 2        3800           2
    ## 3        3250           1
    ## 4          NA          NA
    ## 5        3450           1
    ## 6        3650           2

### Augmented arithmetic reasignment (`%+=%` and kin)

In languages such as Python, it is possible to take an object with a
numeric value and update/reassign it with a single operation. So, for
example, if I had `test = 5`, I could do `test += 5` and then my new
value of `test` would be 10. This sort of behavior is called “augmented
assignment”, and it can be very useful when doing things in loops.

In R, you currently would have to reassign the value like this:
`test <- test + 5`. Some programmers find this to be more verbose than
it needs to be. So, for example:

``` r
v1 <- 0
v2 <- 0

for (i in 1:5) {
  
  v1 <- v1 + i
  v2 %+=% i
  
  print("v1 is " %+% v1 %+% " and v2 is " %+% v2)
  
}
```

    ## [1] "v1 is 1 and v2 is 1"
    ## [1] "v1 is 3 and v2 is 3"
    ## [1] "v1 is 6 and v2 is 6"
    ## [1] "v1 is 10 and v2 is 10"
    ## [1] "v1 is 15 and v2 is 15"

``` r
identical(v1, v2)
```

    ## [1] TRUE

This functionality offers some fun and interesting possibilities for
updating vectors as well:

``` r
v1 <- 1:5

v1 %*=% 2

print(v1)
```

    ## [1]  2  4  6  8 10

``` r
v1 %-=% 1:5

print(v1)
```

    ## [1] 1 2 3 4 5

### Default Operators

R 4.4 introduced the default `NULL` operator (`%||%`), which had
previously been a part of the `{rlang}` package. `%||%` checks the
left-hand side variable to check if it evaluates to `NULL` and, if so,
returns the value of the right-hand side. If not `NULL`, it will return
the left-hand side value. This can be helpful in programming when
dealing with operations that only happen situationally (i.e., if certain
parameters are passed, objects are of a particular class, etc). Infixit
now includes `%||%`, but defaults to the base function if users are on
4.4 or greater.

``` r
val1 <- NULL
val1 %||% "apple" #returns "apple"
```

    ## [1] "apple"

``` r
val2 <- "banana"
val2 %||% "apple" #returns "banana"
```

    ## [1] "banana"

However, `NULL` are not the only way that programmers may indicate the
absence of a value. Some may choose to do `NA`, `FALSE`, or an object of
length 0. (The latter is can happen often, for example, when comparing
sets of values to each other using set operations). To that end, infixit
also introduces an *extended* default operator `%|||%` which checks for
a larger array of possible “empty” values.

``` r
NULL %|||% "apple" #Null
```

    ## [1] "apple"

``` r
NA %|||% "apple" #Atomic NA
```

    ## [1] "apple"

``` r
c(NA, NA, NA, NA) %|||% "apple" #A vector solely comprised of NAs
```

    ## [1] "apple"

``` r
FALSE %|||% "apple" #Atomic False
```

    ## [1] "apple"

``` r
c(FALSE, FALSE, FALSE) %|||% "apple" #A vector solely comprised of False values
```

    ## [1] "apple"

``` r
character(0) %|||% "appple" #An object of length zero
```

    ## [1] "appple"

``` r
"banana" %|||% "apple"
```

    ## [1] "banana"

Under the hood, `%|||%` is running a series of tests based upon function
names. Some of these are provided by base R, others are provided by
infixit. You can extend these tests based upon your own needs though
`options("infixit.extended_default_tests")`

``` r
is_empty_string <- function(x) {ifelse(length(x) == 0 | x == "", TRUE, FALSE)}

tests <- options("infixit.extended_default_tests")[[1]]
tests <- c(tests, "is_empty_string")

options(infixit.extended_default_tests = tests)

"" %|||% "apple"
```

    ## [1] "apple"

By default, `%|||%` returns the right-hand side exactly once. But if you
have, say, a vector of `NA` or `FALSE` values, you may want it to return
the right-hand side but with the same length as your left-hand side.
This can be accomplished with
`options("infixit.extended_default_length")`. By default it is set to
`"one"` but can be set to `"match"` to match the length.

``` r
options(infixit.extended_default_length  = "match")

c(NA,NA,NA,NA) %|||% "apple"
```

    ## [1] "apple" "apple" "apple" "apple"

### Logical Operators

The elemental operations for Boolean algebra are AND, OR, and NOT, which
are all implemented in base R (and, really, in any sane programming
language). However, there are particular combinations of these elements
that are particularly prominent and useful. Chief among these are NAND
(Not AND) and XOR (eXclusive OR). Not AND, as its name implies, returns
the inverse of AND. Infixit supplies`%nand%` for this purpose as an
alias.

``` r
TRUE %nand% TRUE
```

    ## [1] FALSE

``` r
TRUE %nand% FALSE
```

    ## [1] TRUE

XOR returns `TRUE` only when *one* of the sides in an OR operation is
True. Whereas the standard OR would return `TRUE` if both sides are True
`%xor%` returns `FALSE`.

``` r
TRUE %xor% TRUE
```

    ## [1] FALSE

``` r
TRUE %xor% FALSE
```

    ## [1] TRUE

``` r
FALSE %xor% TRUE
```

    ## [1] TRUE

``` r
FALSE %xor% FALSE
```

    ## [1] FALSE

``` r
TRUE %xor% TRUE
```

    ## [1] FALSE
