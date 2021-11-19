# labinstrumentos 0.0.0.9012

* Arreglado error de comprobación de errores en `crear_sankey()`: Ahora el error con n_words < 0 entrega el mensaje de error apropiado.
* Cambio de dependencias: Se eliminó las dependencias de `RWeka`, usando `NLP` en cambio. Esto para mejorar la compatibilidad multiplataforma y solucionar el problema del R-CMD-check ocasionado por la subdependencia con `rJava`.
* Se eliminó el argumento `top` en `crear_sankey()` debido a que era un vestigio de funciones que usaban otros paquetes en versiones anteriores.
* Se incluye argumento `output` en `crear_sankey()` para obtener productos intermedios de la función, como los datos en formato largo (repetido) o corto (con columna de frecuencias) para otros procedimientos.
* Corrección de error en función `crear_sankey()`: Se corrigió un problema con el filtrado por frecuencias (más detalles [aquí](https://github.com/SEREMICTCI/labinstrumentos/commit/336d182a702deda227e78c32bb2fe0158bfb017e#commitcomment-60577502))

# labinstrumentos 0.0.0.9011

* Se crea función `obtener_datos()` para descargar los datos en su última versión desde el documento de hojas de Google, tratando los datos y devolviéndolos limpios. Eventualmente y cuando se tenga la versión definitiva de los datos, se procederá por una alternativa local en el paquete.
* En relación a este último punto, se eliminó los datos almacenados de manera local en el paquete, dado que con la función `obtener_datos()` se puede acceder a una versión actualizada de ellos, eventualmente se recuperarán este modalidad cuando se disponga de una base de datos final.

# labinstrumentos 0.0.0.9010

* Se agrega función `crear_sankey()`, que facilita la creación de diagramas Sankey.

# labinstrumentos 0.0.0.9001

* Se incluyó argumento `vertex.cex` en la función `grafico_red_circular()` para personalizar el tamaño de los nodos.
* Se eliminó el argumento `main` de la función `grafico_red_hubs()`.
* Se mejora el proceso de limpieza de los datos ([ver script](https://github.com/SEREMICTCI/labinstrumentos/blob/master/data-raw/lab_instrumentos.R)) utilizando funciones vectorizadas para mejorar los tiempos de computación. Del mismo modo se notan mejoras en el resultado final, eliminando stopWords que antes no se podían eliminar con facilidad.
* Corrección de documentación de las funciones de creación de análisis de comunidades.
* Uso de `lifecycle` para la declaración de funciones experimentales en la documentación de las funciones.

# labinstrumentos 0.0.0.9000

* Se mejora la estética del sitio web inicial.
* Se crean dos funciones para el análisis de comunidades basados en el algoritmo de optimización 'greedy': `red_comunidades_greedy()`; y el algoritmo Spinglass: `red_comunidades_spinglass()`.
* Se crean dos funciones para la visualización de redes usando un layout circular: `grafico_red_circular()`; y el score de *Hubs*: `grafico_red_hubs()`.
* se crea una función para la creación de redes: `crear_redes_de_palabras()`.
* Se añadió archivo `NEWS.md` para rastrear los cambios del paquete.
