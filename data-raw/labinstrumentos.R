
# Cargamos paquetes ---------------------------------------------------------------------------

library(data.table)
library(googlesheets4)

# Importamos los datos ------------------------------------------------------------------------

labinstrumentos <- googlesheets4::read_sheet(
  ss = "1ct6zRIDli4AHjk8QsF4CYSwZzzTVGK0ncCDBXtXhmqY",
  sheet = "Lista P-C-E"
)

stopWords <- readLines("data-raw/stopwords.txt")

# Tratamiento previo --------------------------------------------------------------------------

labinstrumentos <- data.table::as.data.table(labinstrumentos)

names(labinstrumentos) <- c("laboratorio", "grupo", "problema", "cluster_problema_manual",
                            "clean_problema", "cluster_causa_manual", "causa",
                            "clean_causa", "consecuencia", "clean_consecuencia",
                            "region")

# Tratamiento principal -----------------------------------------------------------------------

labinstrumentos[, names(labinstrumentos) := lapply(.SD, tolower)]

labinstrumentos[, names(labinstrumentos) := lapply(.SD, gsub, pattern = "\\.", replacement = "")]

labinstrumentos[, names(labinstrumentos) := lapply(.SD, gsub, pattern = "\\,", replacement = "")]

for (i in stopWords) {
  i_bound <- paste0("\\b", i, "\\b(?!-)")
  labinstrumentos[, names(labinstrumentos) := lapply(.SD, gsub, pattern = i_bound, replacement = "", perl = T)]
}

labinstrumentos[, names(labinstrumentos) := lapply(.SD, gsub, pattern = "\\s+", replacement = " ")]

labinstrumentos[, names(labinstrumentos) := lapply(.SD, trimws)][]

# Tratamiento final (detalles) ----------------------------------------------------------------

## No necesario

# Exportamos los datos ------------------------------------------------------------------------

data.table::fwrite(labinstrumentos, file = "data-raw/labinstrumentos.csv")
usethis::use_data(labinstrumentos, overwrite = TRUE)
