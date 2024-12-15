# Paso 1: Configuración inicial

# Crear los vectores
energia <- c(rep("Renovable", 10), rep("No Renovable", 10))
consumo <- c(10, 12, 15, 14, NA, 18, 17, 16, NA, 14, 
             20, 22, 21, 19, 23, 25, NA, 20, 24, 22)
costo_kwh <- c(rep(0.12, 10), rep(0.15, 10))

# Paso 2: Limpieza de datos
# Reemplazar los NA por la mediana de consumo para cada tipo de energía
consumo_renovable <- consumo[energia == "Renovable"]
consumo_no_renovable <- consumo[energia == "No Renovable"]

mediana_renovable <- median(consumo_renovable, na.rm = TRUE)
mediana_no_renovable <- median(consumo_no_renovable, na.rm = TRUE)

consumo[is.na(consumo) & energia == "Renovable"] <- mediana_renovable
consumo[is.na(consumo) & energia == "No Renovable"] <- mediana_no_renovable

# Paso 3: Creación del dataframe
df_consumo <- data.frame(energia = energia, consumo = consumo, costo_kwh = costo_kwh)

# Paso 4: Cálculos
# Agregar la columna de costo_total
df_consumo$costo_total <- df_consumo$consumo * df_consumo$costo_kwh

# Calcular el total de consumo y el costo total por tipo de energía
total_consumo <- tapply(df_consumo$consumo, df_consumo$energia, sum)
total_costo <- tapply(df_consumo$costo_total, df_consumo$energia, sum)

# Calcular la media del consumo diario para cada tipo de energía
media_consumo <- tapply(df_consumo$consumo, df_consumo$energia, mean)

# Agregar la columna de ganancia con un aumento del 10% en el costo_total
df_consumo$ganancia <- df_consumo$costo_total * 1.1

# Paso 5: Resumen
# Ordenar el dataframe por la columna costo_total en orden descendente
df_consumo_ordenado <- df_consumo[order(-df_consumo$costo_total), ]

# Calcular el total de consumo y costo total por tipo de energía
total_consumo_energia <- tapply(df_consumo_ordenado$consumo, df_consumo_ordenado$energia, sum)
total_costo_energia <- tapply(df_consumo_ordenado$costo_total, df_consumo_ordenado$energia, sum)

# Extraer las tres filas con el mayor costo_total
top_3_costos <- head(df_consumo_ordenado, 3)

# Crear la lista resumen_energia
resumen_energia <- list(
  dataframe_ordenado = df_consumo_ordenado,
  total_consumo_energia = total_consumo_energia,
  total_costo_energia = total_costo_energia,
  top_3_costos = top_3_costos
)

# Mostrar el resumen
print(resumen_energia)
