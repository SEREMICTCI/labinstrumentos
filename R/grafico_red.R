#' Grafica una red con un layout circular
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' Utilizando un objeto resultante de la función `crear_redes_de_palabras()`,
#' crea un gráfico de redes con una distribución espacial circular. Para esto,
#' se usan bajo la capa la librería `igraph`.
#'
#' @param red Un objeto de clase `igraph` resultante de la función `crear_redes_de_palabras()` o
#' de procesos similares usando el paquete `igraph`.
#' @param vertex.cex multiplicador de tamaño de los nodos. Por defecto es 2.
#'
#' @export

grafico_red_circular <- function(red, vertex.cex = 2L) {

  if (!"igraph" %in% class(red)) stop("`red` DEBE ser un objeto de clase `igraph`")

  graphics::plot(x = red,
       vertex.size = igraph::V(red)$degree * vertex.cex,
       edge.arrow.size = 0.1,
       layout = igraph::layout.circle)
}

#' Grafica una red usando score de Hubs
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' Utilizando un objeto resultante de la función `crear_redes_de_palabras()`,
#' crea un gráfico de redes usando el score de Hubs. Para esto,
#' se usan bajo la capa la librería `igraph`.
#'
#' @param red Un objeto de clase `igraph` resultante de la función `crear_redes_de_palabras()` o
#' de procesos similares usando el paquete `igraph`.
#'
#' @export

grafico_red_hubs <- function(red) {

  if (!"igraph" %in% class(red)) stop("`red` DEBE ser un objeto de clase `igraph`")

  hs <- igraph::hub_score(red, weights = NA)$vector

  graphics::plot(red,
       vertex.size = hs * 20L,
       vertex.color = grDevices::rainbow(50))
}
