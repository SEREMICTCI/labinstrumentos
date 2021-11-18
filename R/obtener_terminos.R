#' Obtener frecuencia de palabras
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' @param i vector de carácteres.
#' @param n_words Número de palabras combinadas.
#'
#' @importFrom RWeka NGramTokenizer Weka_control
#' @importFrom tm VCorpus VectorSource DocumentTermMatrix
#' @importFrom data.table data.table
#'
#' @export

get_terms <- function(i, n_words = 1) {
  fun_tokenizer <- function(x) {
    RWeka::NGramTokenizer(x = x, control = RWeka::Weka_control(min = n_words,
                                                               max = n_words))
  }
  m <- tm::VCorpus(x = tm::VectorSource(x = unique(i)))
  m <- tm::DocumentTermMatrix(x = m, control = list(tokenize = fun_tokenizer))
  m <- sort(x = colSums(x = as.matrix(m)), decreasing = TRUE)
  terms <- data.table::data.table(WORD = names(m), FREQ = m)
  return(terms)
}
