# Usar dataset pré-configurado
## Colunas mpg, cyl e am da base mtcars
carros = mtcars[, c(1, 2, 9)]

head(carros)

# Histograma da coluna mpg
hist(carros$mpg)

# Gráfico de dispersão de mpg X cyl
plot(carros$mpg, carros$cyl)

# Instalar e carregar ggplot2
install.packages('ggplot2')
library(ggplot2)

ggplot(carros, aes(am))+geom_bar()