% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/red_comunidades.R
\name{red_comunidades_greedy}
\alias{red_comunidades_greedy}
\title{Análisis de comunidades usando algoritmo optimization 'Greedy'}
\usage{
red_comunidades_greedy(red, seed = 12345, output = "plot")
}
\arguments{
\item{red}{Un objeto de clase \code{igraph} resultante de la función \code{crear_redes_de_palabras()} o
de procesos similares usando el paquete \code{igraph}.}

\item{seed}{Semilla de reproducibilidad. Número entero usando para la generación de
resultados reproducibles usando \code{set.seed()} por debajo.}

\item{output}{Resultado final. Puede ser 'plot' (devuelve un gráfico de análisis de comunidades),
'groups' (un vector con los grupos) o 'raw' (el objeto sin procesar de clase 'communities').}
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}}

Utilizando un objeto resultante de la función \code{crear_redes_de_palabras()},
crea un análisis de comunidades usando el algoritmo de optimización 'greedy'.
Para esto, se usan bajo la capa la librería \code{igraph}.
}
