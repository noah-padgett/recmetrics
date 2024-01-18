
<!-- README.md is generated from README.Rmd. Please edit that file -->

# recmetrics

<!-- badges: start -->
<!-- badges: end -->

The goal of recmetrics is to provide users with the ability to conduct
psychometric evaluation without relying on assumptions of the latent
variable structure following the work of VanderWeele and Padgett
(preprint).

## Installation

You can install the development version of recmetrics from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("noah-padgett/recmetrics")
```

## Example

This is a basic example which shows you how to provide an evaluation of
the interval structure of a set of items on a survey similar to
confirmatory factor analysis. Using the *a prior* groups of items on
each domain, we can construct a pattern matrix of the relative excess
correlations.

``` r
library(recmetrics)

# Use the SCWB data example
domain_goodrel <- c("cwbcloserel", "cwbrespect", "cwbtrust", "cwbmutuality")
domain_prolead <- c("cwbbeneficence", "cwbintegrity", "cwbcompetence", "cwbvision")
domain_healthyprac <- c("cwbrelgrowth", "cwbfairness", "cwbsustenance", "cwbachieve")
domain_satcomm <- c("cwbsatisf", "cwbvalue", "cwbbelonging", "cwbwelcome")
domain_strongmiss <- c("cwbpurpose", "cwbcontrib", "cwbinterconn", "cwbsynergy")
mylist <- list(
  domain_goodrel,
  domain_prolead,
  domain_healthyprac,
  domain_satcomm,
  domain_strongmiss
)
rec.pattern.matrix(SCWB, mylist)
#>              Item     Domain1     Domain2     Domain3      Domain4
#> 1     cwbcloserel  0.16350864 -0.06530359 -0.05772553  0.047124129
#> 2      cwbrespect  0.20341777 -0.06832657 -0.06991176  0.057950739
#> 3        cwbtrust  0.22372552 -0.07130038 -0.04274413  0.047865281
#> 4    cwbmutuality  0.17258900 -0.05945567 -0.05670289  0.026732625
#> 5  cwbbeneficence -0.05341869  0.17633337  0.03712734 -0.060675160
#> 6    cwbintegrity -0.05785968  0.18528117  0.02152480 -0.056452884
#> 7   cwbcompetence -0.08235693  0.17883536  0.03139963 -0.041153557
#> 8       cwbvision -0.07075092  0.16842651  0.05037093 -0.061091257
#> 9    cwbrelgrowth -0.05823066  0.04050846  0.08350449 -0.054257648
#> 10    cwbfairness -0.04045646  0.04233389  0.09669485 -0.013165893
#> 11  cwbsustenance -0.06047999  0.01734252  0.12713391 -0.033705653
#> 12     cwbachieve -0.06791720  0.04023782  0.12149053 -0.050223390
#> 13      cwbsatisf  0.09032956 -0.06816411 -0.02045509  0.095829392
#> 14       cwbvalue  0.01251991 -0.07083475 -0.03511407  0.073925015
#> 15   cwbbelonging  0.03250483 -0.02942976 -0.03862983  0.076485998
#> 16     cwbwelcome  0.04431847 -0.05094424 -0.05715359  0.103403657
#> 17     cwbpurpose -0.02315045 -0.05192892 -0.02970909  0.092440499
#> 18     cwbcontrib -0.06956462 -0.03002393  0.01166753  0.008818949
#> 19   cwbinterconn -0.05909613 -0.04530498 -0.02006557 -0.072725619
#> 20     cwbsynergy -0.10818321 -0.03377517 -0.01127452 -0.081058059
#>          Domain5
#> 1  -0.0552519881
#> 2  -0.0668988806
#> 3  -0.0990423663
#> 4  -0.0388011694
#> 5  -0.0475080610
#> 6  -0.0393667108
#> 7  -0.0329072571
#> 8  -0.0412509643
#> 9   0.0112924011
#> 10 -0.0498391659
#> 11 -0.0110588242
#> 12  0.0002239403
#> 13 -0.0702504693
#> 14  0.0355899295
#> 15 -0.0105548333
#> 16 -0.0073088567
#> 17  0.0265347085
#> 18  0.1095879704
#> 19  0.2120181880
#> 20  0.2413640001
```
