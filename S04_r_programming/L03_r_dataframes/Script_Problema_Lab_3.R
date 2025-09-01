# a. Importa las librerías necesarias (las puedes ir añadiendo conforme surja su necesidad).
#     o Lee ambos ficheros como dos dataframes. Al ‘data_PremiumPizza.csv’ llámalo df_venta y al ‘calendario_festivos.csv’, df_calendario. También debes convertir los dataframes a tibble.
# b. Visualiza el tipado (la clase) de las variables del dataframe. En caso de que las columnas de fecha no sean tipo Date, debes convertirlas a Date.
# c. Une ambas tablas cruzando las columnas ‘FECHA_SEMANA’ (df_venta) y ‘FECHA_SEMANA_LUNES’ (df_calendario), dando prioridad al dataframe df_venta. Al dataframe resultante debes llamarlo df.
# o Por medio de la función filter de Dplyr, elimina las filas de df que contienen NAs en la variable unidades. Ayúdate del carácter exclamación (!).
# d. Construye un agregado por año que calcule:
#     o Número de observaciones.
#     o Suma de unidades vendidas.
#     o Media de unidades vendidas.
#     o Suma de GRPs.
#     o Media de GRPs.
# e. Construye un agregado por la variable ‘FESTIVOS’ que calcule la mediana de unidades.
# f. Construye un agregado mensual que calcule:
#     o Suma de tiendas abiertas.
#     o Suma de GRPs.
#     o Suma de unidades.
#     o Suma de festivos.
# g. Calcula la correlación entre la variable de ‘UNIDADES’ y ‘GRPs’.
# h. Haciendo uso de la función select de Dplyr, quédate con las variables ‘FECHA_SEMANA’, ‘UNIDADES’ y ‘GRPs’. El dataframe resultante debes transformarlo a formato long por medio del paquete Tidyr.