# Analisar dados abertos de viagens a serviço para subsidiar a tomada de medidas mais eficientes na redução dos gastos com os custos dessas viagens no setor público.

# Questões relevantes:
## Qual o valor gasto por órgão?
## Qual o valor gasto por cidade?
## Qual a quantidade de viagens por mês?


# CARREGAR DADOS
## Dados disponíveis em: http://portaldatransparencia.gov.br/download-de-dados/viagens . Basta escolher o exercício desejado clicar em "baixar"

viagens = read.csv(
    file = '2019_Viagem.csv',
    sep = ';',
    dec = ','
)

# Visualizar as 6 primeiras linhas da tabela
head(viagens)

# Verificar o número de linhas e de colunas
dim(viagens)

# Visualizar a síntese estatística dos valores da coluna "Valor.passagens"
summary(viagens['Valor.passagens'])

# Carregar pacote dplyr
library(dplyr)

# Verificar tipo de dados de cada coluna
glimpse(viagens)


# TRANSFORMAR DADOS
# Converter colunas que possuem datas para o tipo date
viagens$data_inicio = as.Date(viagens$Período...Data.de.início, "%d/%m/%Y")
viagens$data_fim = as.Date(viagens$Período...Data.de.fim, "%d/%m/%Y")
glimpse(viagens)

# Criar coluna data apenas com os dados de mês e ano das viagens
viagens$data_inicio_formatada = format(viagens$data_inicio, "%Y-%m")
viagens$data_fim_formatada = format(viagens$data_fim, "%Y-%m")


# EXPLORAR DADOS
# Visualizar histograma do valor das passagens
hist(viagens$Valor.passagens)

# Síntese estatística dos valores das passagens
summary(viagens$Valor.passagens)
## O valor máximo de passagem está muito distante da média, o que indica a presença de outliers.

# Visualizar em um boxplot o valor das passagens
boxplot(viagens$Valor.passagens)
## Os outliers ficam evideciados no gráfico gerado

# Calcular desvio padrão do valor das passagens
sd(viagens$Valor.passagens)

# Verificar se há dados faltantes no dataframe
colSums(is.na(viagens))

# Verificar a quantidade de ocorrências da coluna "Situação"
str(viagens$Situação)

# Verificar a quantidade de ocorrências da coluna "Situação" para cada classe
table(viagens$Situação)

# Verificar o percentual de ocorrências da coluna "Situação" para cada classe 
prop.table(table(viagens$Situação))*100


# VISUALIZAR RESULTADOS
## Verificar o valor gasto com viagens por órgão

# 1. Quais órgãos estão gastando mais com passagens aéreas?

# Criar dataframe com os 15 órgãos que mais gastam com passagens aéreas
p1 = viagens %>% # dataframe
     group_by(Nome.do.órgão.superior) %>% # agrupar por órgão
     summarise(n = sum(Valor.passagens)) %>% # trazer a soma do valor das passagens
     arrange(desc(n)) %>% # organizar valores em ordem decrescente
     top_n(15) # trazer os 15 primeiros resultados

names(p1) = c('orgao', 'valor')
p1

# Visualizar dados em um gráfico de barras
library(ggplot2)
options(scipen = 999)

ggplot(p1, aes(x=reorder(orgao, valor), y=valor)) + # Ordenar os valores no eixo x, neste caso, o gasto com passagens
           geom_bar(stat='identity', fill='#006400') + # Definir que o gráfico terá a forma geométrica de barras e estas serão verdes 
           ggtitle("Órgãos que mais gastam com passagens aéreas"    ) + # Mudar título do gráfico
           labs(x="Órgãos", y="Gasto com passagens") + # Modificar os valores dos rótulos de cada eixo
           theme(axis.text.x=element_text(angle=45, hjust=1)) # Rotacionar rótulos do eixo x 45º


# 2. Quais cidades estão mais gastando com passagens aéreas?

# Criar dataframe com as 15 cidades que mais gastam com passagens aéreas
p2 = viagens %>% # dataframe
     group_by(Destinos) %>% # agrupar por cidade
     summarise(n=sum(Valor.passagens)) %>% # trazer a soma do valor das passagens
     arrange(desc(n)) %>% # organizar valores em ordem decrescente
     top_n(15) # trazer os 15 primeiros resultados

names(p2) = c('destino', 'valor')
p2

# Visualizar dados em um gráfico de barras horizontal
ggplot(p2, aes(x=reorder(destino, valor), y=valor)) + # Ordenar os valores no eixo x, neste caso, o gasto com passagens
           geom_bar(stat='identity', fill='#B3B300') + # Definir que o gráfico terá a forma geométrica de barras e estas serão verdes
           geom_text(aes(label=valor), vjust=0.3, size=3) + # Ajustar tamanho do texto
           ggtitle("Cidades que mais gastam com passagens aéreas") + # Mudar título do gráfico
           coord_flip() + # Rotacionar gráfico para que fique na horizontal
           labs(x="Valor", y="Cidade")# Modificar os valores dos rótulos de cada eixo


# 2. Quantas viagens foram realizadas por mês?

# Criar dataframe com 
p3 = viagens %>% # dataframe
     group_by(data_inicio_formatada) %>% # agrupar por data de início da viagem
     summarise(qtd = n_distinct(Identificador.do.processo.de.viagem)) # contar a quantidade de viagens sem duplicidade
head(p3)

# Visualizar dados em um gráfico de barras horizontal
ggplot(p3, aes(x=data_inicio_formatada, y=qtd, group=1)) +
           geom_line() +
           geom_point()


# Apresentar as análises
# install.packages("rmarkdown")
# install.packages("tinytex")

## tinytex::install_tinytex()