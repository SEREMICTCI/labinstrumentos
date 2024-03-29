% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/grafico_red.R
\name{grafico_red_circular}
\alias{grafico_red_circular}
\title{Grafica una red con un layout circular}
\usage{
grafico_red_circular(red, vertex.cex = 2L)
}
\arguments{
\item{red}{Un objeto de clase \code{igraph} resultante de la función \code{crear_redes_de_palabras()} o
de procesos similares usando el paquete \code{igraph}.}

\item{vertex.cex}{multiplicador de tamaño de los nodos. Por defecto es 2.}
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}}

Utilizando un objeto resultante de la función \code{crear_redes_de_palabras()},
crea un gráfico de redes con una distribución espacial circular. Para esto,
se usan bajo la capa la librería \code{igraph}.
}
