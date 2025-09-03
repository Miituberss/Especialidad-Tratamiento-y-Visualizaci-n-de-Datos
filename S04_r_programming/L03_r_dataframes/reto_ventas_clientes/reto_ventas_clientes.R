# =====================================
# 1. Importo las librerías
# =====================================
library(dplyr)
library(tidyr)
library(lubridate)

# =====================================
# 2. Crear los dataframes de ventas y clientes
# =====================================
df_clientes <- read.csv("Clientes.csv")
df_ventas <- read.csv("Ventas.csv")

# =====================================
# 3. Convertir la columna fecha de ventas en tipo Date
# =====================================
df_ventas$fecha <- as.Date(df_ventas$fecha)

# =====================================
# 4. Unimos los df mediante la columna id_cliente
# =====================================
df <- inner_join(df_ventas, df_clientes, by = "id_cliente")

# =====================================
# 5. Análisis de ventas por ciudad
# =====================================
ventas_ciudad_producto <- df %>%
  group_by(ciudad, producto) %>%
  summarise(total_ventas = sum(cantidad, na.rm = TRUE), .groups = "drop")

# Pasar a formato wide
ventas_wide <- ventas_ciudad_producto %>%
  pivot_wider(
    names_from = producto,
    values_from = total_ventas,
    values_fill = list(total_ventas = 0) # rellenar con 0 si no hay ventas
  )

# =====================================
# 6. Análisis de los clientes con mayores compras
# =====================================
clientes_top5 <- df %>%
  group_by(id_cliente, nombre, edad) %>%
  summarise(total_compras = sum(cantidad, na.rm = TRUE), .groups = "drop") %>%
  arrange(desc(total_compras)) %>%
  slice_head(n = 5)

# =====================================
# 7. Análisis temporal de las ventas
# =====================================
ventas_mes_producto <- df %>%
  mutate(mes = month(fecha, label = TRUE, abbr = TRUE)) %>%  # extrae el mes
  group_by(mes, producto) %>%
  summarise(total_ventas = sum(cantidad, na.rm = TRUE), .groups = "drop") %>%
  arrange(desc(total_ventas))

# =====================================
# 8. Visualización de los resultados
# =====================================
print("Dataframe de ventas y clientes")
print(df)

print("Total de ventas por ciudad y producto")
print(ventas_ciudad_producto)

print("Ventas por ciudad en formato wide")
print(ventas_wide)

print("Top 5 clientes con mayores compras")
print(clientes_top5)

print("Ventas totales por mes y producto")
print(ventas_mes_producto)
