
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

There are currently 3 infix functions packaged with `{infixit}`:

1.  `%+%`: Providing string concatenation.
2.  `%nin%`: Providing the inverse of the `%in%` function (e.g., whether
    an element of $X$ *is **not*** in $Y$).
3.  `%btwn%`: Lets users determine if numeric elements of $X$ are
    **b**e**tw**ee**n** values $Y_1$ and $Y_2$.

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
```

    ## Warning: package 'palmerpenguins' was built under R version 4.2.3

``` r
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
