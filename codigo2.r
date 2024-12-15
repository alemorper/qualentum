# Función para leer el archivo de números
leer_numeros <- function(nombre_archivo) {
  if (!file.exists(nombre_archivo)) {
    stop("Error: El archivo no existe.")
  }
  
  # Leer los números desde el archivo
  numeros <- as.integer(readLines(nombre_archivo))
  return(numeros)
}

# Función para calcular los estadísticos: media, mediana y desviación estándar
calcular_estadisticos <- function(numeros) {
  media <- mean(numeros)
  mediana <- median(numeros)
  desviacion_estandar <- sd(numeros)
  
  # Imprimir mensaje si la desviación estándar es mayor que 10
  if (desviacion_estandar > 10) {
    message("Alta variabilidad en los datos: desviación estándar mayor que 10.")
  }
  
  return(list(media = media, mediana = mediana, desviacion_estandar = desviacion_estandar))
}

# Función para calcular el cuadrado de cada número usando sapply
calcular_cuadrados <- function(numeros) {
  cuadrados <- sapply(numeros, function(x) x^2)
  return(cuadrados)
}

# Función para escribir los resultados en el archivo resultados.txt
escribir_resultados <- function(estados, cuadrados, nombre_archivo_salida) {
  sink(nombre_archivo_salida)
  cat("Estadísticos calculados:\n")
  cat("Media: ", estados$media, "\n")
  cat("Mediana: ", estados$mediana, "\n")
  cat("Desviación estándar: ", estados$desviacion_estandar, "\n\n")
  
  cat("Cuadrados de los números:\n")
  cat(paste(cuadrados, collapse = ", "), "\n")
  sink()
}

# Función principal para coordinar todo el proceso
procesar_numeros <- function(nombre_archivo_entrada, nombre_archivo_salida) {
  # Leer los números desde el archivo
  numeros <- leer_numeros(nombre_archivo_entrada)
  
  # Calcular los estadísticos
  estadisticos <- calcular_estadisticos(numeros)
  
  # Calcular los cuadrados de los números
  cuadrados <- calcular_cuadrados(numeros)
  
  # Escribir los resultados en el archivo de salida
  escribir_resultados(estadisticos, cuadrados, nombre_archivo_salida)
}

# Llamada a la función principal para procesar los números
procesar_numeros("numeros.txt", "resultados.txt")
