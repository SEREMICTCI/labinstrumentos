
# Cargamos paquete de datos -----------------------------------------------

library(labinstrumentos)
library(data.table)
library(googlesheets4)

# Cargamos los datos ------------------------------------------------------

datos <- obtener_datos()

# Generamos las frecuencias de palabras -----------------------------------

# Crear frecuencias una palabra
una_palabra <- list(
  Problema = obtener_frecuencias(datos$clean_problema, n_words = 1),
  Consecuencia = obtener_frecuencias(datos$clean_consecuencia, n_words = 1),
  Causa = obtener_frecuencias(datos$clean_causa, n_words = 1)
) |> rbindlist(idcol = "P-C-C")

# Crear frecuencias dos palabras
dos_palabra <- list(
  Problema = obtener_frecuencias(datos$clean_problema, n_words = 2),
  Consecuencia = obtener_frecuencias(datos$clean_consecuencia, n_words = 2),
  Causa = obtener_frecuencias(datos$clean_causa, n_words = 2)
) |> rbindlist(idcol = "P-C-C")

# Crear frecuencias tres palabras
tres_palabra <- list(
  Problema = obtener_frecuencias(datos$clean_problema, n_words = 3),
  Consecuencia = obtener_frecuencias(datos$clean_consecuencia, n_words = 3),
  Causa = obtener_frecuencias(datos$clean_causa, n_words = 3)
) |> rbindlist(idcol = "P-C-C")


# Subimos los datos para el Data Studio -----------------------------------

googlesheets4::gs4_auth()

# Subimos el de una palabra
googlesheets4::sheet_write(data = una_palabra,
                           ss = "1IUm5Y4Ytywwy_nvbORCYn9TkKNr5mSyyMGZ2yRKhmrE",
                           sheet = "una_palabra")

# Subimos el de dos palabras
googlesheets4::sheet_write(data = dos_palabra,
                           ss = "1IUm5Y4Ytywwy_nvbORCYn9TkKNr5mSyyMGZ2yRKhmrE",
                           sheet = "dos_palabra")

# Subimos el de tres palabras
googlesheets4::sheet_write(data = tres_palabra,
                           ss = "1IUm5Y4Ytywwy_nvbORCYn9TkKNr5mSyyMGZ2yRKhmrE",
                           sheet = "tres_palabra")
