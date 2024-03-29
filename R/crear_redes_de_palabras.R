#' Crea redes usando algún vector de palabras u oraciones para ser analizadas
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' Utilizando la librería `tm` y `igraph`, opta por un 'wrapper' para generar
#' redes listas para ser utilizadas bajo el contexto de procesamiento de lenguaje
#' natural.
#'
#' @section Metodología usada:
#'
#'   Primero se creó una matriz de términos (i.e, corpus), usando las palabras únicas
#'   usando el paquete `tm`.
#'
#'   ```r
#'   m <- tm::Corpus(x = tm::VectorSource(x = unique(x)))
#'
#'   m <- tm::TermDocumentMatrix(x = m, control = list(minWordLength = c(1L, Inf)))
#'   ```
#'
#'   Se obtuvieron aquellos términos que tuvieran al menos dos términos que aparecieran de
#'   manera única, asignando el valor de 1 para decir si estos se encontraban presentes o no).
#'
#'   ```r
#'   m2 <- m[rowSums(m) > 1, ]
#'
#'   m2[m2 > 1] <- 1
#'   ```
#'
#'   Se calculó la co-ocurrencia de los términos calculando la multiplicación de la matriz de
#'   valores por su versión transpuesta, para así obtener nuestra matriz de adjacencia.
#'
#'   ```r
#'   m3 <- m2 %*% t(m2)
#'   ```
#'
#'   Posteriormente se crearon los nodos con sus respectivos vertices sobre nuestra matriz de
#'   adjacencia usando el paquete `igraph`, devolviendo el objeto para ser usado en técnicas
#'   de visualización o análisis de comunidades.
#'
#'   ```r
#'   g <- igraph::graph.adjacency(m3, weighted = TRUE, mode = 'undirected')
#'
#'   g <- igraph::simplify(g)
#'   ```
#'
#' @param x Un vector de carácteres.
#'
#' @export

crear_redes_de_palabras <- function(x) {

  if (missing(x)) stop("`x` DEBE ser especificado")
  if (!is.character(x)) stop("`x` DEBE ser de tipo caracter (i.e, texto)")

  x <- x[!is.na(x)]

  ## Creación de un corpus para posterior análisis
  m <- tm::Corpus(x = tm::VectorSource(x = unique(x)))

  m <- tm::TermDocumentMatrix(x = m, control = list(minWordLength = c(1L, Inf)))

  m <- as.matrix(m)

  ## Obtenemos aquellos términos que aparezcan almenos dos veces entre los problemas únicos
  m2 <- m[rowSums(m) > 1, ]

  ## Y a aquellos problemas les asignamos el valor de 1 (es decir, se encuentra presente o no)
  m2[m2 > 1] <- 1

  ## Calculamos la co-ocurrencia
  m3 <- m2 %*% t(m2)

  ## Creamos los nodos con sus respectivos vertices
  g <- igraph::graph.adjacency(m3, weighted = TRUE, mode = 'undirected')

  g <- igraph::simplify(g)

  ## Le asignamos etiquetas a los nodos para mejor visualización
  igraph::V(g)$label <- igraph::V(g)$name

  ## Le asignamos la propiedad degree (número de vertices adjacentes) al grafo
  igraph::V(g)$degree <- igraph::degree(g)

  return(g)
}
