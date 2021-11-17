# Usamos stopWords para el proceso de limpieza

## Cargamos stopWords usadas para el proceso de limpieza posterior
stopWords <- readLines("data-raw/stopwords.txt")

## Transformamos stopWords para identificación más precisa usando 'regex'
stopWords <- paste0("(?<!\\S)\\b", stopWords, "\\b(?!\\S)")

## Guardamos los datos en RDS para uso interno
usethis::use_data(stopWords, internal = TRUE, overwrite = TRUE)
