#' Obtener los datos actualizados y limpios
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' Llamar a los datos alojados en el Google sheets con los datos crudos
#'
#' @importFrom gsheet gsheet2tbl
#' @importFrom data.table as.data.table
#' @importFrom stringi stri_replace_all_regex
#'
#' @export

obtener_datos <- function() {

  message("Obteniendo los datos desde Google Sheets")

  url <- "https://docs.google.com/spreadsheets/d/1ct6zRIDli4AHjk8QsF4CYSwZzzTVGK0ncCDBXtXhmqY/edit#gid=34243368"

  lab_instrumentos <- gsheet::gsheet2tbl(url)

  message("Datos descargados, comenzando proceso de limpieza")

  ## Transformamos a data.table para mejor manipulación (i.e., sintaxis más concisa)
  lab_instrumentos <- data.table::as.data.table(lab_instrumentos)

  ## Cambiamos nombres de columnas a minúsculas (mayor compatibilidad multi-plataforma)
  names(lab_instrumentos) <- c("laboratorio", "grupo", "problema", "cluster_problema_manual",
                               "clean_problema", "cluster_causa_manual", "causa",
                               "clean_causa", "consecuencia", "clean_consecuencia",
                               "clean_soluciones", "region")



  ## Creamos un objeto intermedio para asistirnos en el proceso de limpieza
  col_names <- names(lab_instrumentos)


  # Estandarización de texto --------------------------------------------------------------------


  ## Texto a minuscula - estandarización
  lab_instrumentos[, (col_names) := lapply(.SD, tolower)]

  ## Se eliminan puntos
  lab_instrumentos[, (col_names) := lapply(.SD, gsub, pattern = "\\.", replacement = "")]

  ## Se eliminan comas
  lab_instrumentos[, (col_names) := lapply(.SD, gsub, pattern = "\\,", replacement = "")]


  # Variables selecionadas para mayor limpieza (i.e., para análisis) ----------------------------


  ## Se seleccionan variables para procesamiento adicional
  vars <- c("clean_problema", "clean_causa", "clean_consecuencia", "clean_soluciones")

  ## Con esas variables, se eliminan las 'stopWords', sin incluir aquellas que esten precedidas o antecedidas por un guión, i.e. palabra compuesta (e.g., 'no-consideran')
  lab_instrumentos[, (vars) := lapply(.SD, stringi::stri_replace_all_regex, pattern = stopWords, replacement = "", vectorize_all = FALSE), .SDcols = vars]


  # Procedimientos complementarios y/o menores --------------------------------------------------


  ## Se eliminan espacios entre palabras
  lab_instrumentos[, (col_names) := lapply(.SD, gsub, pattern = "\\s+", replacement = " ")]

  ## Y espacios en los extremos de las oraciones (i.e., debido a la eliminación de palabras)
  lab_instrumentos[, (col_names) := lapply(.SD, trimws)][]

  message("Datos limpiados")

  return(lab_instrumentos)

}
