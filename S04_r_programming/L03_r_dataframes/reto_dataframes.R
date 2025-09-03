# =====================================
# 1. Cargar librerías y dataset
# =====================================
library(dplyr)
library(tidyr)

# Cargar dataset mtcars (ya viene en R)
data(mtcars)
df <- as.data.frame(mtcars)

print("Dataset original mtcars:")
print(head(df))

# =====================================
# 2. Selección de columnas y filtrado
# =====================================
df_sel <- df %>%
  select(mpg, cyl, hp, gear) %>%
  filter(cyl > 4)

print("Selección de columnas y filtrado (cyl > 4):")
print(head(df_sel))

# =====================================
# 3. Ordenación y renombrado
# =====================================
df_ord <- df_sel %>%
  arrange(desc(hp)) %>%
  rename(consumo = mpg, potencia = hp)

print("Ordenado por potencia (descendente) y renombrado de columnas:")
print(head(df_ord))

# =====================================
# 4. Nueva columna y agregación
# =====================================
df_eff <- df_ord %>%
  mutate(eficiencia = consumo / potencia)

print("Dataframe con columna eficiencia:")
print(head(df_eff))

df_agregado <- df_eff %>%
  group_by(cyl) %>%
  summarise(
    consumo_medio = mean(consumo, na.rm = TRUE),
    potencia_max = max(potencia, na.rm = TRUE),
    .groups = "drop"
  )

print("Agregado por número de cilindros:")
print(df_agregado)

# =====================================
# 5. Segundo dataframe y unión con left_join
# =====================================
df_transmision <- data.frame(
  gear = c(3, 4, 5),
  tipo_transmision = c("Manual", "Automática", "Semiautomática")
)

df_join <- left_join(df_eff, df_transmision, by = "gear")

print("Dataframe tras left_join con tipos de transmisión:")
print(head(df_join))

# =====================================
# 6. Transformación de formatos
# =====================================
# Formato largo
df_long <- df_join %>%
  pivot_longer(
    cols = c(consumo, potencia, eficiencia),
    names_to = "medida",
    values_to = "valor"
  )

print("Formato largo:")
print(head(df_long))

# Identificar duplicados
df_dupes <- df_long %>%
  group_by(cyl, gear, tipo_transmision, medida) %>%
  summarise(n = n(), .groups = "drop") %>%
  filter(n > 1)

print("Posibles duplicados encontrados:")
print(df_dupes)

# Formato ancho con manejo de duplicados usando mean()
df_wide <- df_long %>%
  group_by(cyl, gear, tipo_transmision, medida) %>%
  summarise(valor = mean(valor, na.rm = TRUE), .groups = "drop") %>%
  pivot_wider(
    names_from = medida,
    values_from = valor
  )

print("Formato ancho final (con mean() para duplicados):")
print(head(df_wide))
