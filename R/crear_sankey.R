
#' Crea un gráfico sankey con uno o más términos
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' Apoyándose del paquete `highcharter`, crea un diagrama Sankey para visualizar
#' la relación entre términos de palabras
#'
#' @param datos Datos usados para la generación del gráfico.
#' @param n_words Del total de palabras, escoger las primeras `top` de mayor a menor. Por defecto es 15.
#' @param top Del total de palabras, escoger las primeras `top` de mayor a menor. Por defecto es 15.
#' @param freq_minima Frecuencia mínima de palabras para filtrar. Por defecto es 8.
#' @param vars Variables para visualizar. Por defecto son las variables `clean_problema`, `clean_causa` y `clean_consecuencia`.
#' @param height Altura en píxeles del gråfico.
#'
#' @importFrom data.table melt.data.table data.table .SD := %like%
#' @importFrom RWeka NGramTokenizer Weka_control
#' @importFrom tm VCorpus VectorSource DocumentTermMatrix
#' @importFrom highcharter highchart hc_theme_google hc_chart hc_add_series data_to_sankey
#'
#' @export

crear_sankey <- function(datos,
                         n_words = 1,
                         top = Inf,
                         freq_minima = 3,
                         vars = c("clean_problema", "clean_causa", "clean_consecuencia"),
                         height = 1000) {

  if (missing(datos)) stop("`datos` DEBE estar presente", call. = FALSE)
  if (n_words < 0) stop("`top` DEBE ser mayor que cero", call. = FALSE)
  if (top < 0) stop("`top` DEBE ser mayor que cero", call. = FALSE)
  if (freq_minima < 0) stop("`freq_minima` DEBE ser mayor que cero", call. = FALSE)
  if (any(!vars %in% names(datos))) stop("`vars` DEBEN ser nombres de variables presentes en los datos", call. = FALSE)

  ## Definimos variables globales
  value <- variable <- grupo <- FREQ <- WORD <- NULL

  # Funciones auxiliares ----

  ## fun: Obtener términos (versión vectorizada)
  get_terms <- function(i) {

    ## Función para estimar tokens
    fun_tokenizer <- function(x) {
      RWeka::NGramTokenizer(
        x = x,
        control = RWeka::Weka_control(
          min = n_words,
          max = n_words
        )
      )
    }

    # Creamos un corpus
    m <- tm::VCorpus(
      x = tm::VectorSource(
        x = unique(i)
      )
    )

    ## Matriz de documentos con n_words términos
    m <- tm::DocumentTermMatrix(
      x = m,
      control = list(tokenize = fun_tokenizer)
    )

    ## Creamos el conteo de palabras por n_words términos
    m <- sort(
      x = colSums(x = as.matrix(m)),
      decreasing = TRUE
    )

    terms <- data.table::data.table(WORD = names(m), FREQ = m)
  }

  # -------------------------

  ## Transformamos los datos a formato largo
  long_data <- data.table::melt.data.table(
    data = datos,
    measure.vars = vars
  )

  ## Si los nombres contienen los prefijos 'clean_' los removemos
  if (any(levels(long_data$variable) %like% "clean")) {
    long_data[, variable := as.factor(x = gsub(pattern = "clean_", replacement = "", x = variable))]
  }

  ## Evaluamos los términos frecuentes de cada grupo y de cada variable (i.e., problema, causa y consecuencia)
  sankey_data <- long_data[j = get_terms(value), keyby = list(variable, grupo)]

  ## Filtramos por la frecuencia mínima de palabras
  sankey_data <- sankey_data[i = FREQ >= freq_minima,
                             j = lapply(.SD, rep, FREQ),
                             .SDcols = -4L]

  ## Creamos un lienzo (i.e., donde haremos el sankey)
  p <- highcharter::highchart(
    height = height,
    theme = highcharter::hc_theme_google()
  )

  ## Definimos el tipo de gráfico que haremos
  p <- highcharter::hc_chart(p, type = 'sankey')

  ## Añadimos las series (los datos)
  p <- highcharter::hc_add_series(
    hc = p,
    data = highcharter::data_to_sankey(
      data = sankey_data[, list(grupo, WORD, variable)]
    )
  )

  ## Devolvemos el gráfico
  return(p)
}

