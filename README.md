
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pdftabler

<!-- badges: start -->
<!-- badges: end -->

The goal of pdftabler is to create arranged data frame extracted from
PDF file by R. It deals especially with time-series data. This package
is required pdftools.

## Installation

You can install the development version of pdftabler from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
# devtools::install_github("MTRBEKTCBT/pdftabler")

library(pdftabler)
```

## Example

The data extracted from a package `pdftools::pdf_text` is often dirty by
unnecessary spaces and is a vector rather than a dataframe. This is a
basic example which shows you how to get the data obtained from pdf to a
complete dataframe.

Suppose we already have vector data extracted by `pdftools::pdf_text`
that has just been extracted. We’ll use `conbini` data which records JFA
sales from 2005 to 2021 to show how each function works.

First of all, the data has to be split into each cell of table which
originally displayed in PDF. To process this task, use `pt_cell()` and
`pt_split()`.

``` r
conbini |>
  pt_cell() |>
  purrr::flatten_chr() |>
  pt_split(initial = 29, n_col = 15, dur_month = 2)
#> [[1]]
#>  [1] "1月"     "561,491" "1.6%"    "513,357" "-1.7%"   "38,861"  "2.1%"   
#>  [8] "908,165" "2.4%"    "838,523" "-0.6%"   "618.3"   "-0.8%"   "612.2"  
#> [15] "-1.1%\n"
#> 
#> [[2]]
#>  [1] "2月"     "523,385" "-1.4%"   "477,521" "-2.5%"   "39,257"  "2.2%"   
#>  [8] "861,472" "-1.5%"   "791,004" "-3.7%"   "607.5"   "0.1%"    "603.7"  
#> [15] "1.2%\n"
```

You will notice about those arguments in `pt_split()`, `initial` denotes
a initial cell for records. Note that it indicates a record for inner
data. Do not specify a raw of column names.

We will also wonder which number is to be `initial`? We can use
`pt_index` to resolve this task. It creates index dataframe that
indicates which place any word or symbol is in the vector.

``` r
key <- sprintf("%d月", 1:12)

idx <- 
  conbini |>
  pt_cell() |>
  purrr::flatten_chr() |>
  pt_index(keywords = key)

idx
#>       V1  V2  V3  V4  V5   V6   V7   V8   V9  V10  V11  V12  V13  V14  V15  V16
#> 1月   29 225 420 615 810 1005 1200 1396 1592 1788 1984 2180 2408 2605 2802 2999
#> 2月   44 240 435 630 825 1020 1215 1411 1607 1803 1999 2195 2423 2620 2817 3014
#> 3月   59 255 450 645 840 1035 1230 1426 1622 1818 2014 2210 2438 2635 2832 3029
#> 4月   74 270 465 660 855 1050 1245 1441 1637 1833 2029 2225 2453 2650 2847 3044
#> 5月   89 285 480 675 870 1065 1260 1456 1652 1848 2044 2240 2468 2665 2863 3060
#> 6月  104 300 495 690 885 1080 1275 1471 1667 1863 2059 2255 2484 2680 2879 3076
#> 7月  119 315 510 705 900 1095 1291 1487 1682 1878 2074 2271 2500 2696 2894 3091
#> 8月  135 330 525 720 915 1110 1306 1502 1698 1894 2090 2286 2515 2712 2909 3106
#> 9月  150 345 540 735 930 1125 1321 1517 1713 1909 2105 2301 2530 2727 2924 3121
#> 10月 165 360 555 750 945 1140 1336 1532 1728 1924 2120 2316 2545 2742 2939 3136
#> 11月 180 375 570 765 960 1155 1351 1547 1743 1939 2135 2331 2560 2757 2954 3151
#> 12月 195 390 585 780 975 1170 1366 1562 1758 1954 2150 2346 2575 2772 2969 3166
#>       V17
#> 1月  3196
#> 2月  3211
#> 3月  3226
#> 4月  3241
#> 5月  3257
#> 6月  3273
#> 7月  3288
#> 8月  3303
#> 9月  3318
#> 10月 3333
#> 11月 3348
#> 12月 3363
```

Now we can use another function `pt_split_multi` that can handle
dataframe as argument. It is a recursive version of function `pt_split`.

``` r
df <- 
conbini |>
  pt_cell() |>
  purrr::flatten_chr() |>
  pt_split_multi(index = idx)
df
#> # A tibble: 204 × 15
#>    V1    V2    V3    V4    V5    V6    V7    V8    V9    V10   V11   V12   V13  
#>    <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr>
#>  1 1月   561,… 1.6%  513,… -1.7% 38,8… 2.1%  908,… 2.4%  838,… -0.6% 618.3 -0.8%
#>  2 2月   523,… -1.4% 477,… -2.5% 39,2… 2.2%  861,… -1.5% 791,… -3.7% 607.5 0.1% 
#>  3 3月   601,… 2.2%  549,… -1.4% 39,1… 2.3%  985,… 2.7%  905,… -0.5% 610.3 -0.4%
#>  4 4月   592,… 2.4%  541,… -0.9% 39,1… 2.4%  994,… 3.3%  930,… -0.1% 596.1 -0.9%
#>  5 5月   600,… 1.7%  548,… -1.9% 39,2… 2.5%  1,01… 3.6%  934,… 0.2%  590.7 -1.9%
#>  6 6月   601,… 2.5%  548,… -1.3% 39,3… 2.8%  1,03… 3.7%  964,… 0.01% 581.2 -1.2%
#>  7 7月   655,… -1.0% 597,… -4.7% 39,4… 2.8%  1,09… -1.4% 1,02… -4.8% 596.2 0.4% 
#>  8 8月   663,… 2.3%  605,… -1.3% 39,7… 2.8%  1,11… 3.9%  1,02… 0.03% 597.1 -1.6%
#>  9 9月   610,… 3.5%  559,… -0.3% 39,6… 2.7%  1,04… 4.1%  962,… 0.3%  585.0 -0.5%
#> 10 10月  602,… 0.7%  551,… -2.9% 39,7… 2.9%  1,04… 4.3%  961,… 0.7%  577.5 -3.5%
#> # … with 194 more rows, and 2 more variables: V14 <chr>, V15 <chr>
#> # ℹ Use `print(n = ...)` to see more rows, and `colnames()` to see all variable names
```

Then, we may also complain about data type, that all of columns in data
are character but we can easily modify this to use some methods already
exist. Since the example data is essentially numerical and limited in
time period, I packed a method for it that processes required task at
one step.

``` r
df |> pt_conbini()
#> # A tibble: 204 × 16
#>     year month     V2    V3     V4    V5    V6    V7      V8    V9     V10   V11
#>    <int> <dbl>  <dbl> <dbl>  <dbl> <dbl> <dbl> <dbl>   <dbl> <dbl>   <dbl> <dbl>
#>  1  2005     1 561491   1.6 513357  -1.7 38861   2.1  908165   2.4  838523 -0.6 
#>  2  2005     2 523385  -1.4 477521  -2.5 39257   2.2  861472  -1.5  791004 -3.7 
#>  3  2005     3 601531   2.2 549144  -1.4 39118   2.3  985632   2.7  905746 -0.5 
#>  4  2005     4 592949   2.4 541234  -0.9 39170   2.4  994731   3.3  930193 -0.1 
#>  5  2005     5 600660   1.7 548391  -1.9 39229   2.5 1016848   3.6  934089  0.2 
#>  6  2005     6 601371   2.5 548714  -1.3 39357   2.8 1034699   3.7  964136  0.01
#>  7  2005     7 655450  -1   597061  -4.7 39479   2.8 1099469  -1.4 1022282 -4.8 
#>  8  2005     8 663367   2.3 605931  -1.3 39749   2.8 1110943   3.9 1028161  0.03
#>  9  2005     9 610668   3.5 559647  -0.3 39673   2.7 1043858   4.1  962562  0.3 
#> 10  2005    10 602856   0.7 551812  -2.9 39726   2.9 1043864   4.3  961290  0.7 
#> # … with 194 more rows, and 4 more variables: V12 <dbl>, V13 <dbl>, V14 <dbl>,
#> #   V15 <dbl>
#> # ℹ Use `print(n = ...)` to see more rows, and `colnames()` to see all variable names
```
