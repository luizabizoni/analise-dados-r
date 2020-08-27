# JOIN
df1 = data.frame(produto = c(1, 2, 3, 5), preco = c(15, 10, 25, 20))
head(df1)

df2 = data.frame(produto = c(1, 2, 3, 4), nome = c('A', 'B', 'C', 'D'))
head(df2)

# Carregar pacote dplyr
install.packages('dplyr')
library(dplyr)

# Unir 
## Left join une os dataframes com base na coluna passada como parâmentro.
## Mantém todos os dados da tabela da esquerda e apenas aqueles que tiverem valor correspondente na tabela da direita. Caso não encontre correspondente, o valor <NA> é atribuído.
df3 = left_join(df1, df2, 'produto')
head(df3)

## Right join une os dataframes com base na coluna passada como parâmentro.
## Mantém todos os dados da tabela da direita e apenas aqueles que tiverem valor correspondente na tabela da esquerda. Caso não encontre correspondente, o valor <NA> é atribuído.
df4 = right_join(df1, df2, 'produto')
head(df4)

## Inner join une os dataframes com base na coluna passada como parâmentro.
## Mantém apenas os dados que tiverem valor correspondente nas duas tabelas.
df5 = inner_join(df1, df2, 'produto')
head(df5)


# SELECIONAR DADOS
# Usar dataset iris, conjunto de dados que vem por padrão na linguagem R.
## Possuí o comprimento e largura em cm da pétala e da sépala de uma flor. As flores estão classificadas como "setosa", "virgínica" ou "versicolor" 
head(iris)

# glimpse para ter informações sobre número de observações, variáveis, tipo e valores das colunas.
glimpse(iris)

# Filtrar apenas as flores clasificadas (coluna Species) como "versicolor"
versicolor = filter(iris, Species == 'versicolor')
dim(versicolor)[1] # 50 flores das 150

# Selecionar linhas 5 a 10
slice(iris, 5:10)

# Selecionar colunas 2 a 4
select(iris, 2:4)

# Selecionar todas as colunas exceto "Sepal.Width"
select(iris, -Sepal.Width)

# Criar uma nova coluna com base em colunas existentes
iris2 = mutate(iris, nova_coluna = Sepal.Length + Sepal.Width)
iris2[,c("Sepal.Length", "Sepal.Width", "nova_coluna")]

# Ordenar dados (use "%>%" para executar mais de uma operação )
select(iris, Sepal.Length) %>% arrange(Sepal.Length)

# Agrupar dados por uma coluna
## Trazer a média do comprimento das sépalas de cada espécie
iris %>% group_by(Species) %>% summarise(mean(Sepal.Length))


# TRANSFORMAR DADOS
# Carregar pacote tidyr
install.packages('tidyr')
library(tidyr)

# Criar dataframe com quantidades de vendas de produtos por ano
dfDate = data.frame(produto = c('A', 'B', 'C'), a_2015 = c(10, 12, 20), a_2016 = c(20, 25, 35), a_2017 = c(15, 20, 30))
head(dfDate)

# Transformar colunas em linhas
## Parâmetros: dataframe base, nome da coluna que irá receber os atributos (colunas), nome da coluna que irá receber os valores (linhas), índice das colunas do dataframe base a serem transformadas
dfDate2 = gather(dfDate, "ano", "quantidade", 2:4)
head(dfDate2)

# Separar texto com base em uma condição
## Parâmetros: dataframe, coluna onde estão os valores que deseja separar, nome das novas colunas que irão receber o resultado da separação
dfDate3 = separate(dfDate2, ano, c('A', 'ano'))
dfDate3

# Deletar coluna 'A'
dfDate3 = dfDate3[-2]
dfDate3

# Acrescentar coluna mês
dfDate3['mes'] = c('01', '02', '03')
dfDate3

# Unir dados de diferentes colunas
## Unir na coluna data os dados das colunas mes e ano separando-os por "/"
dfDate4 = dfDate3 %>% unite(data, mes, ano, sep='/')
head(dfDate4)

