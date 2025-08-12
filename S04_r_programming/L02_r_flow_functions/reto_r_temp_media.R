# Función para leer el archivo CSV
leer_datos <- function(ruta) {
  datos <- read.csv(ruta, stringsAsFactors = FALSE)
}

# Función para calcular la temperatura media diaria por ciudad y día
calcular_temp_media <- function(datos) {
  # Añadir columna temperatura_media
  datos$temperatura_media <- (datos$temperatura_maxima + datos$temperatura_minima) / 2
  return(datos)
}

# Función para obtener ciudad con temperatura media mensual más alta
ciudad_mas_calida <- function(datos) {
  # Calcular media mensual por ciudad
  medias_ciudad <- tapply(datos$temperatura_media, datos$ciudad, mean)
  ciudad_max <- names(which.max(medias_ciudad))
  return(list(medias_ciudad = medias_ciudad, ciudad_max = ciudad_max))
}

# Función para generar archivo resumen
generar_resumen <- function(medias_ciudad, ciudad_max, ruta_salida) {
  # Abrir conexión al archivo
  con <- file(ruta_salida, open = "wt")
  
  cat("Temperaturas medias diarias por ciudad:\n", file = con)
  
  # Por cada ciudad, obtener lista de medias diarias y escribirlas
  for(ciudad in names(medias_ciudad)) {
    # Convertir las medias de la ciudad a vector numérico
    # En medias_ciudad solo está la media mensual, necesitamos las medias diarias originales
    # Por lo tanto esta función debe recibir también el dataframe original con medias diarias
    # Vamos a modificar para pasar también el dataframe completo
    
    # Esto requiere ajustar, así que mejor la función recibirá el dataframe completo con medias diarias
    
    # Por ahora dejo esta función simple, y la explicaré mejor en el código general.
  }
  
  cat("\nCiudad con la temperatura media más alta del mes:", ciudad_max, "\n", file = con)
  
  close(con)
}

# Código principal
main <- function() {
  ruta_entrada <- "temperaturas.csv"
  ruta_salida <- "resumen_temperaturas.txt"
  
  datos <- leer_datos(ruta_entrada)
  datos <- calcular_temp_media(datos)
  
  # Obtener ciudad con mayor temperatura media mensual
  resultado <- ciudad_mas_calida(datos)
  
  medias_ciudad <- resultado$medias_ciudad
  ciudad_max <- resultado$ciudad_max
  
  # Abrir archivo para escribir con temperaturas medias diarias por ciudad
  con <- file(ruta_salida, open = "wt")
  cat("Temperaturas medias diarias por ciudad:\n", file = con)
  
  # Listar temperaturas medias diarias para cada ciudad
  ciudades <- unique(datos$ciudad)
  for(ciudad in ciudades) {
    medias_diarias <- datos$temperatura_media[datos$ciudad == ciudad]
    # Formatear lista de temperaturas con dos decimales
    lista_str <- paste(round(medias_diarias, 2), collapse = ", ")
    cat(ciudad, ": [", lista_str, "]\n", sep = "", file = con)
  }
  
  cat("\nCiudad con la temperatura media más alta del mes: ", ciudad_max, "\n", sep = "", file = con)
  close(con)
  
  cat("Resumen generado en", ruta_salida, "\n")
}

# Ejecutar programa
main()