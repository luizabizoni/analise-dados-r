# Instalar pacote ggplot2
install.packages('ggplot2')

# Carregar pacote instalado
library(ggplot2)

# Atribuir a string 'Hello World!' à variável mensagem
mensagem = 'Hello World!'

# Imprimir a string atribuída à variável mensagem
print(mensagem)


# Vetores
cidade = c('Brasília',
           'São Paulo',
           'Rio de Janeiro',
           'Porto Alegre')

cidade

temperatura = c(32, 22, 35, 17)

regiao = c(1, 2, 2, 3)

# Acessando o primeiro elemento
## ATENÇÃO: a indexação em R começa por 1 e não por 0 como em outras linguagens
cidade[1]

# Acessando um intervalo de elementos
temperatura[1:3]

# Copiando um vetor
cidade2 = cidade
cidade2

#Excluindo o segundo elemento da consulta
cidade2 = cidade2[-4]
cidade2

# Alterando um vetor
cidade2[1] = 'Belo Horizonte'
cidade2

# Adicionando um novo elemento
cidade2[4] = 'Curitiba'
cidade2

# Deletando um vetor
cidade2 = NULL
cidade2


# Fatores (armazena variáveis categóricas)
uf = factor(c('DF', 'SP', 'RJ', 'RS'))
uf

# Criar fatores ordenados
## São necessários dois parâmetros:
    # - levels: para definir a ordem de importância. Deve-se listar os níveis em ordem crescente.
    # - ordered: para ordenar os levels
grau_instrucao = factor(c('Nível Médio',
                          'Superior',
                          'Nível Médio',
                          'Fundamental'),
                          levels = c('Fundamental',
                                     'Nível Médio',
                                     'Superior'),
                          ordered = TRUE)
grau_instrucao


# Listas
## Aceita valores de diferentes tipos
pessoa = list(sexo = 'M', cidade = 'Brasilia', idade = 20)
pessoa

# Acessar o primeiro elemento da lista (retorna o atributo e o valor)
pessoa[1]

# Acessar o valor do primeiro elemento da lista (retorna apenas o valor)
pessoa[[1]]

# Editar valor de um elemento da lista
pessoa[['idade']] = 22
pessoa

# Deletando elemento da lista
pessoa[['idade']] = NULL
pessoa

# Filtrar elementos da lista
pessoa[c('cidade', 'sexo')]

# Lista de listas
cidades = list(cidade=cidade,
               temperatura=temperatura,
               regiao=regiao)
cidades


# Data frame (as variáveis criadas são utilizadas como parâmetros)
# Criando data frame com vetores
df = data.frame(cidade, temperatura)
df

# Criando data frame com listas
df2 = data.frame(cidades)
df2

# Filtrar valores do data frame
# Recuperar o valor da linha 1, coluna 2
df[1, 2]

# Recuperar todas as linhas da primera coluna
df[, 1]

# Recuperar a primeira linha e todas as colunas
df[1,]

# Selecionar as 3 primeiras linhas da primeira e última coluna
df2[c(1:3), c(1, 3)]

# Verificar nome das colunas
names(df)

# Verificar número de linhas e colunas
dim(df)

# Verificar os tipos de dados
str(df)

# Acessar uma coluna do data frame
df$cidade
df['cidade']


# Matrizes
## Diferente de um data frame, uma matriz só aceita um tipo de dado
m = matrix(seq(1:9), nrow=3)
m

m2 = matrix(seq(1:25), ncol = 5, byrow = TRUE, dimnames = list(c(seq(1:5)), c('A', 'B', 'C', 'D', 'E')))
m2

# Filtrando dados na matriz
m2[c(1:2), c('B', 'C')]