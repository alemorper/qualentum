# 1. Cargar las librerías y los datos
if (!require("dplyr")) install.packages("dplyr")
if (!require("tidyr")) install.packages("tidyr")
library(dplyr)
library(tidyr)

# Cargar el dataset mtcars y convertirlo en dataframe
data(mtcars)
df <- as.data.frame(mtcars)

# 2. Selección de columnas y filtrado de filas
df_filtered <- df %>%
  select(mpg, cyl, hp, gear) %>%
  filter(cyl > 4)

cat("\nDataframe filtrado por columnas y filas:\n")
print(df_filtered)

# 3. Ordenación y renombrado de columnas
df_ordered <- df_filtered %>%
  arrange(desc(hp)) %>%
  rename(consumo = mpg, potencia = hp)

cat("\nDataframe ordenado y renombrado:\n")
print(df_ordered)

# 4. Creación de nuevas columnas y agregación de datos
df_with_efficiency <- df_ordered %>%
  mutate(eficiencia = consumo / potencia)

cat("\nDataframe con la nueva columna eficiencia:\n")
print(df_with_efficiency)

df_grouped <- df_with_efficiency %>%
  group_by(cyl) %>%
  summarise(consumo_medio = mean(consumo, na.rm = TRUE),
            potencia_maxima = max(potencia, na.rm = TRUE))

cat("\nResumen agrupado por cilindros:\n")
print(df_grouped)

# 5. Creación del segundo dataframe y unión de dataframes
tipo_transmision_df <- data.frame(
  gear = c(3, 4, 5),
  tipo_transmision = c("Manual", "Automática", "Semiautomática")
)

df_joined <- df_with_efficiency %>%
  left_join(tipo_transmision_df, by = "gear")

cat("\nDataframe combinado con tipo de transmisión:\n")
print(df_joined)

# 6. Transformación de formatos
# Transformar a formato largo
df_long <- df_joined %>%
  pivot_longer(cols = c(consumo, potencia, eficiencia),
               names_to = "medida",
               values_to = "valor")

cat("\nDataframe en formato largo:\n")
print(df_long)

# Identificar duplicados
df_long_grouped <- df_long %>%
  group_by(cyl, gear, tipo_transmision, medida) %>%
  summarise(valor = mean(valor, na.rm = TRUE), .groups = "drop")

cat("\nDataframe en formato largo con duplicados manejados:\n")
print(df_long_grouped)

# Transformar nuevamente a formato ancho
df_wide <- df_long_grouped %>%
  pivot_wider(names_from = medida, values_from = valor)

cat("\nDataframe en formato ancho:\n")
print(df_wide)
