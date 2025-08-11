# Definir vectores que representen el tipo de energía, el consumo diario (en kWh), y el costo por kWh.
# Vector de tipo de energía (10 de cada tipo)
energia <- c(rep("Renovable", 10), rep("No Renovable", 10))

# Vector de consumo en kWh (algunos NA)
consumo <- c(sample(100:200, 15, replace = TRUE), rep(NA, 5))
consumo <- sample(consumo)  # Mezclar para distribuir los NA aleatoriamente

# Vector de costo por kWh según el tipo de energía
# Asumimos: Renovable = 0.12, No Renovable = 0.20
costo_kwh <- ifelse(energia == "Renovable", 0.12, 0.20)

# Limpiar los datos de consumo, reemplazando los valores faltantes con la mediana del consumo diario.
consumo[which(is.na(consumo))] <- median(consumo[-which(is.na(consumo))])

# Crear un dataframe que contenga información sobre el tipo de energía, el consumo diario, y los costos.
df_consumo <- data.frame(tipo_energia = energia, consumo_diario = consumo, costos = costo_kwh)

# Calcular métricas clave como el total de consumo y el costo total.
df_consumo$costo_total <- df_consumo$consumo_diario * df_consumo$costos
consumo_total_por_energia <- tapply(consumo, energia, sum)
costo_total_por_energia <- tapply(costo_kwh, energia, sum)
consumo_medio_por_energia <- tapply(consumo, energia, mean)
df_consumo$ganancia <- df_consumo$costo_total * 1.1

# Crear un resumen
df_consumo <- df_consumo[order(df_consumo$costo_total, decreasing = TRUE),]
top_3_costos <- head(df_consumo, 3)
resumen_energia <- list(df_consumo, consumo_total_por_energia, costo_total_por_energia, top_3_costos)           
print(resumen_energia)
