# labinstrumentos 0.0.0.9001

* Se incluyó argumento `vertex.cex` en la función `grafico_red_circular()` para personalizar el tamaño de los nodos.
* Se eliminó el argumento `main` de la función `grafico_red_hubs()`.
* Se mejora el proceso de limpieza de los datos ([ver script](https://github.com/SEREMICTCI/labinstrumentos/blob/master/data-raw/lab_instrumentos.R)) utilizando funciones vectorizadas para mejorar los tiempos de computación. Del mismo modo se notan mejoras en el resultado final, eliminando stopWords que antes no se podían eliminar con facilidad.
* Corrección de documentación de las funciones de creación de análisis de comunidades.

# labinstrumentos 0.0.0.9000

* Se mejora la estética del sitio web inicial.
* Se crean dos funciones para el análisis de comunidades basados en el algoritmo de optimización 'greedy': `red_comunidades_greedy()`; y el algoritmo Spinglass: `red_comunidades_spinglass()`.
* Se crean dos funciones para la visualización de redes usando un layout circular: `grafico_red_circular()`; y el score de *Hubs*: `grafico_red_hubs()`.
* se crea una función para la creación de redes: `crear_redes_de_palabras()`.
* Se añadió archivo `NEWS.md` para rastrear los cambios del paquete.
