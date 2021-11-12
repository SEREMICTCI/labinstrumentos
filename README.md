
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Datos y análisis del laboratorio de instrumentos

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/labinstrumentos)](https://CRAN.R-project.org/package=labinstrumentos)
[![R-CMD-check](https://github.com/SEREMICTCI/labinstrumentos/workflows/R-CMD-check/badge.svg)](https://github.com/SEREMICTCI/labinstrumentos/actions)
<!-- badges: end -->

Este es un paquete de <i class="fab fa-r-project"></i> que contiene los
datos procesados del laboratorio de intrumentos, así como herramientas
complementarias para su análisis y visualización.

## Instalación

Para instalar el paquete directamente a tu computadora, asegurate de
tener instalado <i class="fab fa-r-project"></i>, luego escribe en tu
consola de <i class="fab fa-r-project"></i> lo siguiente:

``` r
# install.packages("devtools")
devtools::install_github("SEREMICTCI/labinstrumentos")
```

## Dependencias

Este paquete, así como sus correspondientes análisis, dependen de los
siguientes paquetes:

``` r
# install.packages("deepdep")
dependencies <- deepdep::deepdep("labinstrumentos", local = TRUE, depth = 3)
deepdep::plot_dependencies(dependencies)
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

Para citar este paquete en publicaciones puedes correr la siguiente
función en tu consola de <i class="fab fa-r-project"></i>:

``` r
citation("labinstrumentos")
#> 
#> To cite package 'labinstrumentos' in publications use:
#> 
#>   Matías Castillo Aguilar and Carlos Morales Quiroz (2021).
#>   labinstrumentos: Datos del Laboratorio de Instrumentos. R package
#>   version 0.0.0.9000. https://github.com/SEREMICTCI/labinstrumentos
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {labinstrumentos: Datos del Laboratorio de Instrumentos},
#>     author = {Matías {Castillo Aguilar} and Carlos {Morales Quiroz}},
#>     year = {2021},
#>     note = {R package version 0.0.0.9000},
#>     url = {https://github.com/SEREMICTCI/labinstrumentos},
#>   }
```
