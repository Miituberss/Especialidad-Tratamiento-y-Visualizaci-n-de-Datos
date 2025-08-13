# Escribe una función personalizada llamada leer_numeros que tome como argumento el nombre del fichero (numeros.txt) y devuelva un vector de números enteros.
# Dentro de la función, verifica si el fichero existe utilizando una estructura condicional (if).
# Si el fichero no existe, muestra un mensaje de error y utiliza la función stop() para detener la ejecución.
# Si el fichero existe, lee los datos y conviértelos en un vector de enteros.

leer_numeros <- function(fichero) {
      if(!file.exists(fichero)){
        stop("Error: El fichero no existe.")
      } else {
        datos <- read.table(fichero, header = FALSE)
        resultado <- as.integer(datos[[1]])
        return(resultado)
      }
}

vector <- leer_numeros("C:/Users/alumno/Desktop/S4_Lab2_Reto_proy/numeros.txt")


# Utiliza funciones vectorizadas como mean(), median() y sd() para calcular la media, mediana y desviación estándar del vector obtenido.

media <- mean(vector)
mediana <- median(vector)
minimo <- min(vector)
maximo <- max(vector)
desviacion <- sd(vector)

# Utiliza una estructura condicional para verificar si la desviación estándar es mayor que 10.
# Si es así, muestra un mensaje indicando que hay alta variabilidad en los datos.

if (desviacion > 10) {
  print("Hay alta variabilidad en los datos.")
}

# Utiliza la función sapply() para obtener el cuadrado de cada número en el vector.
# Almacena los resultados en un nuevo vector.

v_cuadrados <- sapply(vector, function(x) x^2)

# Crea o sobrescribe un fichero llamado resultados.txt.
# Escribe en el fichero los estadísticos calculados y la lista de números al cuadrado.
# Asegúrate de que el formato del fichero sea legible y esté bien organizado.

sink("resultados.txt")
cat("=== Resultados del análisis ===\n\n")
cat("Estadísticos básicos:\n")
cat("Mínimo:", minimo, "\n")
cat("Máximo:", maximo, "\n")
cat("Media:", media, "\n")
cat("Mediana:", mediana, "\n")
cat("Desviacion estandar:", desviacion, "\n\n")
cat("Números originales:\n")
cat(paste(vector, collapse = ", "), "\n\n")
cat("Números al cuadrado:\n")
cat(paste(v_cuadrados, collapse = ", "), "\n")
sink()