# Identificar pacientes com alta probabilidade de serem diagnosticados com diabetes, tendo, no mínimo, 75% de acurácia.

# CARREGAR DADOS
diabetes = read.csv(
    file = "diabetes.csv"
)

head(diabetes)

# PREPARAR DADOS
str(diabetes)
diabetes$Outcome = as.factor(diabetes$Outcome)

colSums(is.na(diabetes))

# EXPLORAR DADOS
boxplot(diabetes)

hist(diabetes$Pregnancies)
hist(diabetes$Age)
hist(diabetes$BMI)

library(dplyr)

diabetes2 = diabetes %>% filter(Insulin <= 250)
boxplot(diabetes2)

# Construção do modelo preditivo

# Dividir dados de treino e de teste
## install.packages("caTools")
library(caTools)

set.seed(123)
index = sample.split(diabetes2$Pregnancies, SplitRatio = .7)
index

train = subset(diabetes2, index=TRUE)
test = subset(diabetes2, index=FALSE)

# Criar modelo
# install.packages("caret")
# install.packages("e1071")

library(caret)
library(e1071)

modelo = train(Outcome ~., data = train, method = "knn")
modelo$results
modelo$bestTune

modelo2 = train(Outcome ~., data = train, method = "knn", tuneGrid = expand.grid(k = c(1:20)))
modelo2$bestTune
plot(modelo2)

modelo3 = train(Outcome ~., data = train, method = "naive_bayes")
modelo3$results
modelo3$bestTune

set.seed(42)
modelo4 = train(Outcome ~., data = train, method = "svmRadialSigma", preProcess=c("center"))
modelo4$results
modelo4$bestTune
# retornou a melhor acurácioa: 77.81%

# Avaliar modelo
predicoes = predict(modelo4, test)
predicoes

confusionMatrix(predicoes, test$Outcome)

# Testando em paciente "real"
novos_dados = data.frame( Pregnancies = c(3), Glucose = c(111.5), BloodPressure = c(70), SkinThickness = c(20), Insulin = c(47.49), BMI = c(30.8), DiabetesPedigreeFunction = c(0.34), Age = c(28))
previsao = predict(modelo4, novos_dados)
previsao