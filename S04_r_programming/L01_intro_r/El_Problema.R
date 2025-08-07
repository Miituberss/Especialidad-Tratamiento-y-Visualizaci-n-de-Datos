### Introduccion ----------------------

#En el siguiente problema vamos a plantear un conjunto de tratamientos y transformaciones
#que tendreis que realizar de forma autonoma.

#Haciendo uso de los comentarios os indicare cual es la accion a realizar y tendreis que generar el codigo 
#que la lleve a cabo

#Consultar los videos del lab y los fastbooks os ayudara

#En caso de que surja cualquier duda o cuestion podeis contactar conmigo


### Enunciado ------------------------

#Supongamos que realizamos un test A/B, en el que comparamos la eficacia de dos anuncios en formato online.
#El primero de ellos es el clasico, el que ha sido usado por la empresa desde sus inicios. 
#El segundo de ellos es una version mejorada que se ha creado recientemente.

#Para llevar a cabo dicha comparativa tenemos los clicks diarios que han generado cada uno de los anuncios
#Todo ello en un intervalo temporal de catorce dias. Desde el 30 de noviembre hasta el 13 de diciembre de 2020

#A continuacion contruyo la informacion del experimento (son 3 vectores). Ejecutad sin hacer modificaciones
anuncio <- rep(c("anuncio antiguo","anuncio nuevo"),times=1,each=14)
clicks <- c(1924,1820,1724,2042,NA,2643,2801,1930,1837,1930,2190,2231,2790,2678,
            2345,1789,1980,2456,2556,2534,2902,2754,2490,2612,1923,2432,2942,2493)
fechas <- as.character(rep(seq(as.Date("2020-11-30"),as.Date("2020-12-13"),by="day"),2))

#Printeamos las variables para poder ver y entender su contenido
anuncio
clicks
fechas

### Ejercicios  ---------------------

#Ejercicio 1: Usa sobre cada uno de los vectores la funcion que devuelve sus longitudes
#(el numero de elementos que poseen)
length(anuncio)
length(clicks)
length(fechas)

#Ejercicio 2: El vector de clicks contiene un NA. Modifica ese dato para que pase a valer
#la mediana del vector clicks
clicks[which(is.na(clicks))] <- median(clicks, na.rm = TRUE)

#Ejercicio 3: Modifica aquellos valores de clicks iguales a 1924 y 1820 para que pasen a valer
#1926 y 1822 respectivamente
clicks[(clicks == 1924) | (clicks == 1820)] <- c(1926, 1822)


#Ejercicio 4: Aplica una funcion sobre el vector anuncio para que puedas saber cuantos valores distintos 
#contiene y cuantas veces aparece cada uno de ellos
table(anuncio)


#Ejercicio 5: Modifica el vector anuncio para que el termino "antiguo" pase a ser "clasico" y 
#el termino "nuevo" pase a ser "moderno"
anuncio <- gsub("nuevo", "moderno", anuncio)
anuncio <- gsub("antiguo", "clasico", anuncio)

#Ejercicio 6: Aplica una funcion sobre anuncio para que su contenido pase a estar en mayusculas
anuncio <- toupper(anuncio)


#Ejercicio 7: Convierte el vector anuncio a tipo factor
anuncio <- as.factor(anuncio)


#Ejercicio 8: Convierte el vector fechas a tipo Date y comprueba que ha surtido efecto con la funcion class
fechas <- as.Date(fechas)
class(fechas)

#Ejercicio 9: Calcula la fecha minima y maxima del vector fechas
min(fechas)
max(fechas)

#Ejercicio 10: Construye una matriz con 14 filas y 2 columnas a partir del vector clicks.
#Guardala con el nombre matriz
matriz <- matrix(clicks, 14, 2)
matriz

#Ejercicio 11: Construye un dataframe llamado df con 3 columnas. 
#La primera se debe llamar fecha y debe contener el vector fechas 
#La segunda se debe llamar anuncio y debe contener el vector anuncio
#La tercera se debe llamar clicks y debe contener el vector clicks
df <- data.frame(fecha = fechas, anuncio = anuncio, clicks = clicks)

#Ejercicio 12: Aplica sobre df$clicks la funcion que da informacion sobre la distribucion numerica de la variable
summary(df$clicks)

#Ejercicio 13: Calcula la suma de todos los clicks
sum(df$clicks)

#Ejercicio 14: Calcula la suma de todos los clicks para cada uno de los anuncios.
#Ademas de sum tendras que hacer uso de la funcion subset.
sum(subset(df, anuncio == "ANUNCIO CLASICO")$clicks)
sum(subset(df, anuncio == "ANUNCIO MODERNO")$clicks)

#Ejercicio 15: Asumiendo que por cada click generado nuestra empresa recibe 10 euros.
#Crea una columna dentro de df llamada ganancia que multiplique el numero de clicks por 10
df$ganancia <- df$clicks*10


#Ejercicio 16: Importa el paquete lubridate y crea en df una columna llamada semana a partir de redondear
#hacia abajo la columna fecha. Considera un inicio semanal de lunes.
library(lubridate)
df$semana <- floor_date(df$fecha, "week", 1)

#Ejercicio 17: Ordena el df en base al numero de clicks
df <- df[order(df$clicks),]


#Ejercicio 18: Crea una columna dentro de df llamada nombre que contega tu nombre en todas las filas.
#Para ello tienes que usar la funcion que te ayuda a repetir un determinado valor varias veces.
df$nombre <- rep("Marcos", length(df$clicks))


#Ejercicio 19: Parte en trozos la columna anuncio usando el espacio vacio (" ") como separador. 
#Antes tendras que aplicar la funcion as.character sobre dicha variable para que deje de ser factor
#El resultado te devolvera una lista. Guardala en una variable llamada lista_split
lista_split <- strsplit(as.character(df$anuncio), " ")


#Ejercicio 20: Para finalizar crea una lista llamada lista_final que contenga cuatro elementos
#En primer lugar, una variable basica tipo character con tu nombre
#En segunda lugar, la matriz que hemos creado en el ejercicio 10
#En tercer lugar, el dataframe que hemos llamado df
#Por ultimo, la lista_split que acabamos de crear el el ejericio 19
lista_final <- list("Marcos", matriz, df, lista_split)


