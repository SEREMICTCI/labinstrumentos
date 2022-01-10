#' Obtener frecuencia de palabras
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' @param i vector de carácteres.
#' @param n_words Número de palabras combinadas.
#'
#' @export

obtener_frecuencias <- function(i, n_words = 1) {

  fun <- function(j) { fun_tokenizer(j, n_words) }

  i <- unique(i)

  m <- tm::VectorSource(x = i)
  m <- tm::VCorpus(x = m)
  m <- tm::DocumentTermMatrix(x = m, control = list(tokenize = fun))
  m <- as.matrix(m)
  m <- colSums(x = m)
  m <- sort(x = m, decreasing = TRUE)

  terms <- data.table(WORD = names(m), FREQ = m)

  return(terms)
}
