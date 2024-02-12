
<!-- README.md is generated from README.Rmd. Please edit that file -->

# recmetrics

<!-- badges: start -->
<!-- badges: end -->

The goal of recmetrics is to provide users with the ability to conduct
psychometric evaluation without relying on assumptions of the latent
variable structure following the work of VanderWeele and Padgett (2024).

VanderWeele, T. J., & Padgett, R. (2024). Novel Psychometric Indicator
Assessments: The Relative Excess Correlation and Associated Matrices.
Preprint PsyArXiv: <https://doi.org/10.31234/osf.io/rnbk5>

## Installation

``` r
install.packages("recmetrics")
```

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
mylist <- list(
     domain_goodrel = c("cwbcloserel", "cwbrespect", "cwbtrust", "cwbmutuality"),
     domain_prolead = c("cwbbeneficence", "cwbintegrity", "cwbcompetence", "cwbvision"),
     domain_healthyprac = c("cwbrelgrowth", "cwbfairness", "cwbsustenance", "cwbachieve"),
     domain_satcomm = c("cwbsatisf", "cwbvalue", "cwbbelonging", "cwbwelcome"),
     domain_strongmiss = c("cwbpurpose", "cwbcontrib", "cwbinterconn", "cwbsynergy")
   )
   
myvar <- c(unlist(mylist))

# Generate ORC matrix
cor.orc( SCWB[,myvar] )
#>                cwbcloserel cwbrespect cwbtrust cwbmutuality cwbbeneficence
#> cwbcloserel           1.00       0.35     0.34         0.22          -0.13
#> cwbrespect            0.35       1.00     0.61         0.35          -0.23
#> cwbtrust              0.34       0.61     1.00         0.48          -0.20
#> cwbmutuality          0.22       0.35     0.48         1.00          -0.18
#> cwbbeneficence       -0.13      -0.23    -0.20        -0.18           1.00
#> cwbintegrity         -0.23      -0.19    -0.21        -0.13           0.55
#> cwbcompetence        -0.22      -0.22    -0.27        -0.31           0.40
#> cwbvision            -0.24      -0.26    -0.22        -0.18           0.32
#> cwbrelgrowth         -0.06      -0.34    -0.23        -0.20           0.11
#> cwbfairness          -0.24      -0.09    -0.07        -0.20           0.11
#> cwbsustenance        -0.21      -0.23    -0.16        -0.21          -0.02
#> cwbachieve           -0.25      -0.29    -0.19        -0.17           0.03
#> cwbsatisf             0.10       0.13     0.26         0.16          -0.21
#> cwbvalue              0.01      -0.02    -0.10        -0.03          -0.22
#> cwbbelonging          0.03       0.10     0.02        -0.02          -0.15
#> cwbwelcome            0.03       0.18     0.08        -0.06          -0.22
#> cwbpurpose           -0.16      -0.02    -0.14        -0.12          -0.26
#> cwbcontrib           -0.22      -0.22    -0.30        -0.15          -0.10
#> cwbinterconn         -0.11      -0.22    -0.28        -0.12          -0.13
#> cwbsynergy           -0.20      -0.34    -0.37        -0.18          -0.13
#>                cwbintegrity cwbcompetence cwbvision cwbrelgrowth cwbfairness
#> cwbcloserel           -0.23         -0.22    -0.237        -0.06      -0.241
#> cwbrespect            -0.19         -0.22    -0.255        -0.34      -0.089
#> cwbtrust              -0.21         -0.27    -0.217        -0.23      -0.067
#> cwbmutuality          -0.13         -0.31    -0.175        -0.20      -0.200
#> cwbbeneficence         0.55          0.40     0.325         0.11       0.115
#> cwbintegrity           1.00          0.42     0.367        -0.04       0.075
#> cwbcompetence          0.42          1.00     0.488        -0.01       0.025
#> cwbvision              0.37          0.49     1.000         0.14       0.106
#> cwbrelgrowth          -0.04         -0.01     0.138         1.00       0.208
#> cwbfairness            0.08          0.03     0.106         0.21       1.000
#> cwbsustenance         -0.02          0.07     0.001         0.14       0.246
#> cwbachieve             0.07          0.11     0.117         0.15       0.218
#> cwbsatisf             -0.20         -0.22    -0.217        -0.20      -0.054
#> cwbvalue              -0.24         -0.17    -0.240        -0.17      -0.146
#> cwbbelonging          -0.12         -0.10    -0.122        -0.15       0.003
#> cwbwelcome            -0.18         -0.10    -0.201        -0.25      -0.103
#> cwbpurpose            -0.11         -0.14    -0.205        -0.15      -0.150
#> cwbcontrib            -0.06         -0.13    -0.166         0.04      -0.098
#> cwbinterconn          -0.20         -0.11    -0.108         0.02      -0.156
#> cwbsynergy            -0.16         -0.12    -0.090         0.08      -0.212
#>                cwbsustenance cwbachieve cwbsatisf cwbvalue cwbbelonging
#> cwbcloserel           -0.208      -0.25      0.10    0.011        0.034
#> cwbrespect            -0.230      -0.29      0.13   -0.015        0.097
#> cwbtrust              -0.165      -0.19      0.26   -0.096        0.021
#> cwbmutuality          -0.209      -0.17      0.16   -0.034       -0.021
#> cwbbeneficence        -0.022       0.03     -0.21   -0.221       -0.153
#> cwbintegrity          -0.018       0.07     -0.20   -0.235       -0.117
#> cwbcompetence          0.070       0.11     -0.22   -0.169       -0.096
#> cwbvision              0.001       0.12     -0.22   -0.240       -0.122
#> cwbrelgrowth           0.143       0.15     -0.20   -0.175       -0.152
#> cwbfairness            0.246       0.22     -0.05   -0.146        0.003
#> cwbsustenance          1.000       0.54     -0.04   -0.074       -0.225
#> cwbachieve             0.537       1.00     -0.12   -0.125       -0.246
#> cwbsatisf             -0.035      -0.12      1.00    0.297        0.079
#> cwbvalue              -0.074      -0.13      0.30    1.000       -0.009
#> cwbbelonging          -0.225      -0.25      0.08   -0.009        1.000
#> cwbwelcome            -0.212      -0.23      0.18    0.077        0.410
#> cwbpurpose            -0.091      -0.10      0.09    0.088        0.235
#> cwbcontrib            -0.038       0.07     -0.11    0.073       -0.078
#> cwbinterconn          -0.064      -0.10     -0.37   -0.066       -0.131
#> cwbsynergy            -0.063      -0.03     -0.37   -0.001       -0.246
#>                cwbwelcome cwbpurpose cwbcontrib cwbinterconn cwbsynergy
#> cwbcloserel          0.03      -0.16      -0.22        -0.11     -0.197
#> cwbrespect           0.18      -0.02      -0.22        -0.22     -0.341
#> cwbtrust             0.08      -0.14      -0.30        -0.28     -0.366
#> cwbmutuality        -0.06      -0.12      -0.15        -0.12     -0.179
#> cwbbeneficence      -0.22      -0.26      -0.10        -0.13     -0.128
#> cwbintegrity        -0.18      -0.11      -0.06        -0.20     -0.157
#> cwbcompetence       -0.10      -0.14      -0.13        -0.11     -0.118
#> cwbvision           -0.20      -0.21      -0.17        -0.11     -0.090
#> cwbrelgrowth        -0.25      -0.15       0.04         0.02      0.078
#> cwbfairness         -0.10      -0.15      -0.10        -0.16     -0.212
#> cwbsustenance       -0.21      -0.09      -0.04        -0.06     -0.063
#> cwbachieve          -0.23      -0.10       0.07        -0.10     -0.030
#> cwbsatisf            0.18       0.09      -0.11        -0.37     -0.367
#> cwbvalue             0.08       0.09       0.07        -0.07     -0.001
#> cwbbelonging         0.41       0.24      -0.08        -0.13     -0.246
#> cwbwelcome           1.00       0.36      -0.01        -0.24     -0.273
#> cwbpurpose           0.36       1.00       0.13        -0.04     -0.035
#> cwbcontrib          -0.01       0.13       1.00         0.14      0.250
#> cwbinterconn        -0.24      -0.04       0.14         1.00      0.646
#> cwbsynergy          -0.27      -0.04       0.25         0.65      1.000

# Generate REC matrix
cor.rec( SCWB[,myvar] )
#>                cwbcloserel cwbrespect cwbtrust cwbmutuality cwbbeneficence
#> cwbcloserel             NA       0.18    0.181        0.129         -0.034
#> cwbrespect           0.181         NA    0.265        0.164         -0.069
#> cwbtrust             0.181       0.27       NA        0.225         -0.061
#> cwbmutuality         0.129       0.16    0.225           NA         -0.050
#> cwbbeneficence      -0.034      -0.07   -0.061       -0.050             NA
#> cwbintegrity        -0.076      -0.06   -0.068       -0.032          0.224
#> cwbcompetence       -0.070      -0.07   -0.089       -0.104          0.162
#> cwbvision           -0.081      -0.08   -0.068       -0.052          0.142
#> cwbrelgrowth        -0.003      -0.11   -0.063       -0.060          0.064
#> cwbfairness         -0.078      -0.02   -0.008       -0.059          0.055
#> cwbsustenance       -0.067      -0.07   -0.044       -0.063          0.007
#> cwbachieve          -0.083      -0.09   -0.055       -0.045          0.023
#> cwbsatisf            0.075       0.07    0.128        0.088         -0.066
#> cwbvalue             0.035       0.02   -0.015        0.011         -0.071
#> cwbbelonging         0.037       0.05    0.027        0.012         -0.039
#> cwbwelcome           0.041       0.09    0.052       -0.004         -0.066
#> cwbpurpose          -0.045       0.01   -0.032       -0.027         -0.081
#> cwbcontrib          -0.074      -0.06   -0.100       -0.041         -0.023
#> cwbinterconn        -0.024      -0.08   -0.107       -0.029         -0.045
#> cwbsynergy          -0.078      -0.14   -0.157       -0.058         -0.041
#>                cwbintegrity cwbcompetence cwbvision cwbrelgrowth cwbfairness
#> cwbcloserel          -0.076         -0.07     -0.08       -0.003      -0.078
#> cwbrespect           -0.056         -0.07     -0.08       -0.107      -0.016
#> cwbtrust             -0.068         -0.09     -0.07       -0.063      -0.008
#> cwbmutuality         -0.032         -0.10     -0.05       -0.060      -0.059
#> cwbbeneficence        0.224          0.16      0.14        0.064       0.055
#> cwbintegrity             NA          0.17      0.16        0.005       0.040
#> cwbcompetence         0.171            NA      0.20        0.016       0.021
#> cwbvision             0.160          0.20        NA        0.077       0.054
#> cwbrelgrowth          0.005          0.02      0.08           NA       0.101
#> cwbfairness           0.040          0.02      0.05        0.101          NA
#> cwbsustenance         0.007          0.04      0.02        0.075       0.103
#> cwbachieve            0.034          0.05      0.06        0.075       0.086
#> cwbsatisf            -0.064         -0.07     -0.07       -0.051      -0.005
#> cwbvalue             -0.079         -0.05     -0.08       -0.055      -0.040
#> cwbbelonging         -0.029         -0.02     -0.03       -0.035       0.015
#> cwbwelcome           -0.055         -0.02     -0.06       -0.076      -0.023
#> cwbpurpose           -0.027         -0.04     -0.06       -0.041      -0.039
#> cwbcontrib           -0.009         -0.04     -0.05        0.029      -0.022
#> cwbinterconn         -0.074         -0.03     -0.03        0.018      -0.055
#> cwbsynergy           -0.048         -0.03     -0.02        0.039      -0.084
#>                cwbsustenance cwbachieve cwbsatisf cwbvalue cwbbelonging
#> cwbcloserel          -0.0666      -0.08     0.075    0.035         0.04
#> cwbrespect           -0.0681      -0.09     0.071    0.019         0.05
#> cwbtrust             -0.0442      -0.06     0.128   -0.015         0.03
#> cwbmutuality         -0.0630      -0.05     0.088    0.011         0.01
#> cwbbeneficence        0.0066       0.02    -0.066   -0.071        -0.04
#> cwbintegrity          0.0074       0.03    -0.064   -0.079        -0.03
#> cwbcompetence         0.0400       0.05    -0.072   -0.051        -0.02
#> cwbvision             0.0153       0.06    -0.070   -0.083        -0.03
#> cwbrelgrowth          0.0745       0.08    -0.051   -0.055        -0.03
#> cwbfairness           0.1033       0.09    -0.005   -0.040         0.02
#> cwbsustenance             NA       0.20     0.005   -0.012        -0.07
#> cwbachieve            0.2036         NA    -0.030   -0.033        -0.07
#> cwbsatisf             0.0051      -0.03        NA    0.151         0.05
#> cwbvalue             -0.0118      -0.03     0.151       NA         0.02
#> cwbbelonging         -0.0650      -0.07     0.047    0.017           NA
#> cwbwelcome           -0.0630      -0.07     0.090    0.054         0.17
#> cwbpurpose           -0.0183      -0.02     0.057    0.056         0.10
#> cwbcontrib           -0.0008       0.04    -0.021    0.051        -0.01
#> cwbinterconn         -0.0135      -0.03    -0.159   -0.005        -0.04
#> cwbsynergy           -0.0117       0.01    -0.158    0.040        -0.10
#>                cwbwelcome cwbpurpose cwbcontrib cwbinterconn cwbsynergy
#> cwbcloserel         0.041     -0.045    -0.0740       -0.024      -0.08
#> cwbrespect          0.089      0.012    -0.0631       -0.076      -0.14
#> cwbtrust            0.052     -0.032    -0.1000       -0.107      -0.16
#> cwbmutuality       -0.004     -0.027    -0.0413       -0.029      -0.06
#> cwbbeneficence     -0.066     -0.081    -0.0230       -0.045      -0.04
#> cwbintegrity       -0.055     -0.027    -0.0090       -0.074      -0.05
#> cwbcompetence      -0.022     -0.036    -0.0358       -0.032      -0.03
#> cwbvision          -0.062     -0.064    -0.0522       -0.031      -0.02
#> cwbrelgrowth       -0.076     -0.041     0.0292        0.018       0.04
#> cwbfairness        -0.023     -0.039    -0.0221       -0.055      -0.08
#> cwbsustenance      -0.063     -0.018    -0.0008       -0.013      -0.01
#> cwbachieve         -0.067     -0.021     0.0403       -0.030       0.01
#> cwbsatisf           0.090      0.057    -0.0207       -0.159      -0.16
#> cwbvalue            0.054      0.056     0.0508       -0.005       0.04
#> cwbbelonging        0.166      0.103    -0.0113       -0.037      -0.10
#> cwbwelcome             NA      0.154     0.0165       -0.090      -0.11
#> cwbpurpose          0.154         NA     0.0676        0.001       0.01
#> cwbcontrib          0.016      0.068         NA        0.092       0.17
#> cwbinterconn       -0.090      0.001     0.0916           NA       0.54
#> cwbsynergy         -0.110      0.011     0.1696        0.543         NA

# Generate within-between mean REC
rec.avg.wb.domains(SCWB, mylist)
#>     Domain Avg_Rec_Within_Domain Avg_REC_Between_Domains
#> 1 Domain 1                  0.19                   -0.04
#> 2 Domain 2                  0.18                   -0.03
#> 3 Domain 3                  0.11                   -0.02
#> 4 Domain 4                  0.09                   -0.02
#> 5 Domain 5                  0.15                   -0.03

# Generate pattern matrix of REC of an item within domain
rec.pattern.matrix(SCWB, mylist)
#>              Item Domain1 Domain2 Domain3 Domain4 Domain5
#> 1     cwbcloserel    0.16   -0.07   -0.06   0.047 -0.0553
#> 2      cwbrespect    0.20   -0.07   -0.07   0.058 -0.0669
#> 3        cwbtrust    0.22   -0.07   -0.04   0.048 -0.0990
#> 4    cwbmutuality    0.17   -0.06   -0.06   0.027 -0.0388
#> 5  cwbbeneficence   -0.05    0.18    0.04  -0.061 -0.0475
#> 6    cwbintegrity   -0.06    0.19    0.02  -0.056 -0.0394
#> 7   cwbcompetence   -0.08    0.18    0.03  -0.041 -0.0329
#> 8       cwbvision   -0.07    0.17    0.05  -0.061 -0.0413
#> 9    cwbrelgrowth   -0.06    0.04    0.08  -0.054  0.0113
#> 10    cwbfairness   -0.04    0.04    0.10  -0.013 -0.0498
#> 11  cwbsustenance   -0.06    0.02    0.13  -0.034 -0.0111
#> 12     cwbachieve   -0.07    0.04    0.12  -0.050  0.0002
#> 13      cwbsatisf    0.09   -0.07   -0.02   0.096 -0.0703
#> 14       cwbvalue    0.01   -0.07   -0.04   0.074  0.0356
#> 15   cwbbelonging    0.03   -0.03   -0.04   0.076 -0.0106
#> 16     cwbwelcome    0.04   -0.05   -0.06   0.103 -0.0073
#> 17     cwbpurpose   -0.02   -0.05   -0.03   0.092  0.0265
#> 18     cwbcontrib   -0.07   -0.03    0.01   0.009  0.1096
#> 19   cwbinterconn   -0.06   -0.05   -0.02  -0.073  0.2120
#> 20     cwbsynergy   -0.11   -0.03   -0.01  -0.081  0.2414
```
