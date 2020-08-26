# Criar função
par_impar = function(num) {
    if ((num%%2)==0) {
       return('Par')
    } else {
       return('Impar')
    }
}

# Usar função
num = 3
par_impar(num)



# Apply
x = seq(1, 9)
matriz = matrix(x, ncol = 3)

result1 = apply(matriz, 1, sum)
result1

# List
numeros_pares = c(2, 4, 6, 8, 10)
numeros_impares = c(1, 3, 5, 7, 9)

numeros = list(numeros_pares, numeros_impares)

numeros

## lapply
lapply(numeros, mean)

## sapply
sapply(numeros, mean)