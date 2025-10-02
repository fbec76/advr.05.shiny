# advr.05.shiny
<!-- badges: start -->
[![R-CMD-check](https://github.com/fbec76/advr.05.shiny/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/fbec76/advr.05.shiny/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

STIMA 2025 Repository for the shiny application of Lab05 of 732A94 "Advanced Programming in R" Link to Course Information: https://www.ida.liu.se/~732A94/info/courseinfo.en.shtml

## Project Initialization

### Setup

```{r}
R 
> library(usethis)
> create_package(".")
> use_rstudio()
> use_mit_license()
> use_github_action("check-standard")
> use_testthat() 
```

### Update Authors

Add the following authors to `DESCRIPTION`:

```
person("Finn", "Beckmann", , "finbe486@student.liu.se", role = c("aut", "cre"))
person("Max", "Goldbeck-Löwe", , "maxgo900@student.liu.se", role = c("aut", "cre"))
```

### JetBrains IDE Setup

Add the following:

- `^.idea$` to `.Rbuildignore`
- `.idea/` to `.gitignore`

### GitHub Actions Badge

Add the following badge to `README.md`:

```
[![R-CMD-check](
<!-- badges: start -->
[![R-CMD-check](https://github.com/fbec76/advr.<lab-nr>.shiny/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/fbec76/advr.<lab-nr>.shiny/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->
```
Make sure to replace `<lab-nr>` with the respective lab number.
