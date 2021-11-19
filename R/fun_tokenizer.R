#' Función interna tokenizadora para la extracción de palabras
#'
#' Esta función es usada de manera interna por `obtener_terminos()`
#'
#' @param j Vector de carácteres.
#' @param n_words Número de palabras conjuntas.
#'
#' @importFrom NLP words ngrams

fun_tokenizer <- function(j, n_words) {
  j <- NLP::words(j)
  n_grams <- NLP::ngrams(j, n = n_words)
  n_grams <- lapply(n_grams, paste, collapse = " ")
  unlist(n_grams, use.names = FALSE)
}
