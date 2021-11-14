
# Cargamos paquetes ---------------------------------------------------------------------------


library(googlesheets4) # Descargar datos de google sheets
library(data.table)    # Manipulación de variables
library(stringi)       # Reemplazo de stopWords (limpieza de texto)


# Importamos los datos ------------------------------------------------------------------------


## Cargamos los datos directamente de Google Sheets
lab_instrumentos <- googlesheets4::read_sheet(
  ss = "1ct6zRIDli4AHjk8QsF4CYSwZzzTVGK0ncCDBXtXhmqY",
  sheet = "Lista P-C-E",
)

## Cargamos stopWords usadas para el proceso de limpieza posterior
stopWords <- readLines("data-raw/stopwords.txt")

## Transformamos stopWords para identificación más precisa usando 'regex'
stopWords <- paste0("(?<!\\S)\\b", stopWords, "\\b(?!\\S)")


# Tratamiento previo --------------------------------------------------------------------------


## Transformamos a data.table para mejor manipulación (i.e., sintaxis más concisa)
lab_instrumentos <- data.table::as.data.table(lab_instrumentos)

## Cambiamos nombres de columnas a minúsculas (mayor compatibilidad multi-plataforma)
names(lab_instrumentos) <- c("laboratorio", "grupo", "problema", "cluster_problema_manual",
                            "clean_problema", "cluster_causa_manual", "causa",
                            "clean_causa", "consecuencia", "clean_consecuencia",
                            "region")

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
vars <- c("clean_problema", "clean_causa", "clean_consecuencia")

## Con esas variables, se eliminan las 'stopWords', sin incluir aquellas que esten precedidas o antecedidas por un guión, i.e. palabra compuesta (e.g., 'no-consideran')
lab_instrumentos[, (vars) := lapply(.SD, stringi::stri_replace_all_regex, pattern = stopWords, replacement = "", vectorize_all = FALSE), .SDcols = vars]


# Procedimientos complementarios y/o menores --------------------------------------------------


## Se eliminan espacios entre palabras
lab_instrumentos[, (col_names) := lapply(.SD, gsub, pattern = "\\s+", replacement = " ")]

## Y espacios en los extremos de las oraciones (i.e., debido a la eliminación de palabras)
lab_instrumentos[, (col_names) := lapply(.SD, trimws)][]


# Eliminación de objetos intermedios ----------------------------------------------------------


## Objetos ya usados, y que no cumplen otras funciones
remove(stopWords, vars, col_names)


# Exportamos los datos ------------------------------------------------------------------------


## Guardamos los datos en CSV (facilidad de importación en múltiples softwares)
data.table::fwrite(lab_instrumentos, file = "data-raw/lab_instrumentos.csv")

## Guardamos los datos en RDS (facilidad de importación en R, con todas sus propiedades)
usethis::use_data(lab_instrumentos, overwrite = TRUE)
