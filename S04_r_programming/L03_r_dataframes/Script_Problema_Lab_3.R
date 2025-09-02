# a. Importar librerías necesarias
library(readr)      # Para leer CSVs
library(dplyr)      # Para manipulación de datos
library(tibble)     # Para trabajar con tibbles
library(lubridate)  # Para manejo de fechas
library(tidyr)      # Para transformar a formato long

# a. Leer los ficheros y convertirlos a tibble
df_venta <- read_csv("data_PremiumPizza.csv") %>% as_tibble()
df_calendario <- read_csv2("calendario_festivos.csv") %>% as_tibble()

# b. Ver tipado de las variables
str(df_venta)
str(df_calendario)

# Si las fechas no son tipo Date, las convertimos
df_venta <- df_venta %>%
  mutate(FECHA_SEMANA = as.Date(FECHA_SEMANA))

df_calendario <- df_calendario %>%
  mutate(FECHA_SEMANA_LUNES = as.Date(FECHA_SEMANA_LUNES))

# c. Unir tablas (left join para dar prioridad a df_venta)
df <- df_venta %>%
  left_join(df_calendario, by = c("FECHA_SEMANA" = "FECHA_SEMANA_LUNES"))

# Eliminar filas con NA en "unidades"
df <- df %>%
  filter(!is.na(UNIDADES))

# d. Agregado por año
df_anual <- df %>%
  mutate(anio = year(FECHA_SEMANA)) %>%
  group_by(anio) %>%
  summarise(
    n_obs = n(),
    suma_unidades = sum(UNIDADES, na.rm = TRUE),
    media_unidades = mean(UNIDADES, na.rm = TRUE),
    suma_grps = sum(GRPs, na.rm = TRUE),
    media_grps = mean(GRPs, na.rm = TRUE)
  )

# e. Agregado por FESTIVOS -> mediana de unidades
df_festivos <- df %>%
  group_by(FESTIVOS) %>%
  summarise(mediana_unidades = median(UNIDADES, na.rm = TRUE))

# f. Agregado mensual
df_mensual <- df %>%
  mutate(mes = floor_date(FECHA_SEMANA, "month")) %>%
  group_by(mes) %>%
  summarise(
    suma_tiendas = sum(TIENDAS.ABIERTAS, na.rm = TRUE),
    suma_grps = sum(GRPs, na.rm = TRUE),
    suma_unidades = sum(UNIDADES, na.rm = TRUE),
    suma_festivos = sum(FESTIVOS, na.rm = TRUE)
  )

# g. Correlación entre UNIDADES y GRPs
correlacion <- cor(df$UNIDADES, df$GRPs, use = "complete.obs")

# h. Selección de variables y transformación a formato long
df_long <- df %>%
  select(FECHA_SEMANA, UNIDADES, GRPs) %>%
  pivot_longer(
    cols = c(UNIDADES, GRPs),
    names_to = "variable",
    values_to = "valor"
  )
