#' Análisis de comunidades usando algoritmo Spinglass
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' Utilizando un objeto resultante de la función `crear_redes_de_palabras()`,
#' crea un análisis de comunidades usando el algoritmo de Spinglass.
#' Para esto, se usan bajo la capa la librería `igraph`.
#'
#' @param red Un objeto de clase `igraph` resultante de la función `crear_redes_de_palabras()` o
#' de procesos similares usando el paquete `igraph`.
#' @param seed Semilla de reproducibilidad. Número entero usando para la generación de
#' resultados reproducibles usando `set.seed()` por debajo.
#' @param output Resultado final. Puede ser 'plot' (devuelve un gráfico de análisis de comunidades),
#' 'groups' (un vector con los grupos) o 'raw' (el objeto sin procesar de clase 'communities').
#'
#' @importFrom igraph cluster_spinglass membership
#' @importFrom data.table data.table
#' @importFrom graphics plot
#' @export

red_comunidades_spinglass <- function(red, seed = 12345, output = "plot") {

  if (!"igraph" %in% class(red)) stop("`red` DEBE ser un objeto de clase `igraph`")

  set.seed(seed) # Semilla de reproducibilidad
  spinglass <- igraph::cluster_spinglass(red)

  if (output == "plot") {

    graphics::plot(spinglass, red, vertex.size = 8)

  } else if (output == "groups") {

    groups <- igraph::membership(spinglass)
    groups <- data.table(groups, words = names(groups), key = "groups")
    return(groups)

  } else if (output == "raw") {

    return(spinglass)

  } else stop("`output` DEBE ser uno de estos: 'plot', 'groups' o 'raw'")
}

#' Análisis de comunidades usando algoritmo optimization 'Greedy'
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' Utilizando un objeto resultante de la función `crear_redes_de_palabras()`,
#' crea un análisis de comunidades usando el algoritmo de optimización 'greedy'.
#' Para esto, se usan bajo la capa la librería `igraph`.
#'
#' @param red Un objeto de clase `igraph` resultante de la función `crear_redes_de_palabras()` o
#' de procesos similares usando el paquete `igraph`.
#' @param seed Semilla de reproducibilidad. Número entero usando para la generación de
#' resultados reproducibles usando `set.seed()` por debajo.
#' @param output Resultado final. Puede ser 'plot' (devuelve un gráfico de análisis de comunidades),
#' 'groups' (un vector con los grupos) o 'raw' (el objeto sin procesar de clase 'communities').
#'
#' @export

red_comunidades_greedy <- function(red, seed = 12345, output = "plot") {

  if (!"igraph" %in% class(red)) stop("`red` DEBE ser un objeto de clase `igraph`")

  set.seed(seed) # Semilla de reproducibilidad

  greedy <- igraph::cluster_fast_greedy(
    graph = igraph::as.undirected(red)
  )

  if (output == "plot") {

    graphics::plot(greedy, red, vertex.size = 8)

  } else if (output == "groups") {

    groups <- igraph::membership(greedy)
    groups <- data.table(groups, words = names(groups), key = "groups")

    return(groups)

  } else if (output == "raw") {

    return(greedy)

  } else stop("`output` DEBE ser uno de estos: 'plot', 'groups' o 'raw'")
}
