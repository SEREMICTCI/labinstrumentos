
#' Crea un gráfico sankey con uno o más términos
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' Apoyándose del paquete `highcharter`, crea un diagrama Sankey para visualizar
#' la relación entre términos de palabras
#'
#' @param datos Datos usados para la generación del gráfico.
#' @param n_words Número de palabras combinadas. Por defecto es 1.
#' @param freq_minima Frecuencia mínima de palabras para filtrar. Por defecto es 3.
#' @param vars Variables para visualizar. Por defecto son las variables `clean_problema`, `clean_causa` y `clean_consecuencia`.
#' @param height Altura en píxeles del gråfico.
#' @param output Carácter de longitud uno. Tipo de objeto resultante. Las opciones
#' son `"grafico"` (por defecto), `"df_largo"`, `"df_corto"`.
#'
#' @export

crear_sankey <- function(datos,
                         n_words = 1,
                         freq_minima = 3,
                         vars = c("clean_problema", "clean_causa", "clean_consecuencia"),
                         height = 1000,
                         output = "grafico") {

  if (missing(datos)) stop("`datos` DEBE estar presente", call. = FALSE)
  if (n_words < 0) stop("`n_words` DEBE ser mayor que cero", call. = FALSE)
  if (freq_minima < 0) stop("`freq_minima` DEBE ser mayor que cero", call. = FALSE)
  if (any(!vars %in% names(datos))) stop("`vars` DEBEN ser nombres de variables presentes en los datos", call. = FALSE)
  if (!output %in% c("df_corto", "df_largo", "grafico")) stop("`output` DEBE ser uno de los siguientes: \"df_corto\", \"df_largo\", o \"grafico\"", call. = FALSE)

  value <- variable <- grupo <- FREQ <- WORD <- NULL

  long_data <- data.table::melt(
    data = datos,
    measure.vars = vars
  )

  if (any(levels(long_data$variable) %like% "clean")) {
    long_data[, variable := as.factor(x = gsub(pattern = "clean_", replacement = "", x = variable))]
  }

  sankey_data <- long_data[, obtener_frecuencias(value, n_words), list(variable, grupo)]

  filtered_words <- sankey_data[, list(FREQ = sum(FREQ)), WORD][FREQ >= freq_minima, WORD]

  sankey_data <- sankey_data[WORD %in% filtered_words]

  if (isTRUE(output == "df_corto")) { return(sankey_data) }

  sankey_data <- sankey_data[, lapply(.SD, rep, FREQ), .SDcols = -4L]

  if (isTRUE(output == "df_largo")) { return(sankey_data) }

  p <- highcharter::highchart(
    height = height,
    theme = highcharter::hc_theme_google()
  )
  p <- highcharter::hc_chart(p, type = 'sankey')
  p <- highcharter::hc_add_series(
    hc = p,
    data = highcharter::data_to_sankey(
      data = sankey_data[, list(grupo, WORD, variable)]
    )
  )

  return(p)
}

