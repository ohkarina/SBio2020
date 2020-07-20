#################################################
##                                             ##
##  1. EXPLORANDO E CORREGINDO UMA DATA FRAME  ##
##  Guillermo L. Fl�rez Montero                ##
##                                             ##
#################################################




# Primeiro carregamos o diret�rio de trabalho
# lembre de substituir o caminho da minha pasta

setwd("D:/Cursos/Semana da Bio 2020/datos")



# Vamos explorar um pouco os dados "a_lituratus.csv"
# est�o no Github, n�o esque�am de ler os metadados




# Usaremos esses pacotes para baix�-los diretamente do github

# caso n�o estejam descarregados use as linhas 28 e 29, tirando o jogo-da-velha

# install.packages("readr")
# install.packages("curl")

# o comando library permite carregar os pacotes no ambiente de trabalho

library(readr)
library(curl)





# Vamos aos dados

midata = read_csv("https://raw.githubusercontent.com/gflorezm/SBio2020/master/a_lituratus.csv")
View(midata)


# podemos explorar as primeiras seis e �ltimas seis linhas na consola

head(midata)
tail(midata)



# podemos ver um resumo tamb�m

str(midata)
summary(midata)


# muitas vezes as tabelas de dados podem ter erros que devem ser corregidos
# antes de iniciar uma an�lise.

# Vamos conferir valores faltantes (NA) na planilha (j� o summary disse que h� 17)
# para isso usamos um teste l�gico

is.na(midata)

# Eu perguintei. R... meus dados tem NA?
# o R respondeu com uma data frame igualzinha mas preenchida com valores l�gicos
# TRUE quando � um NA e FALSE quando n�o �.



# Vou pedir ao R somar os NA que est�o em cada uma das colunas do data frame

sum(is.na(midata$Habitat))
sum(is.na(midata$Forearm))
sum(is.na(midata$body_mass))
sum(is.na(midata$Diet_richness))
sum(is.na(midata$Sex))


# Percebam que os NA s� est�o na coluna Diet_richness
# podemos identificar exatamente quais dados s�o


midata[is.na(midata$Diet_richness),]


# Na linha 86 diz: R... Separa as linhas de midata
# quando o valor na coluna Diet_richness seja NA.




################################################################

# quando indexamos em  R, do lado do lado esquerdo da virgula
# s�o as linhas e do lado direito as colunas [linhas,Colunas]

# vejam o valor da linha 2, coluna 3

midata[2,3]

# vejam toda a linha 16

midata[16,]

################################################################




# Identificar NAs � importante pois muitas fun��es n�o lidam bem com eles
# por outro lado sabemos (ver os metadados) que n�o deveria ter NAs
# e caso existir devem asumir valor de 0, fa�amos isso... dar valor 0 para eles


midata$Diet_richness[is.na(midata$Diet_richness)] = 0

# pronto, conferimos que n�o tem mais NA

midata[is.na(midata$Diet_richness),]




# Agora vamos conferir que todo esteja bem com as vari�veis qualitativas

table(midata$Habitat)
table(midata$Sex)

# Percebam que no sexo h� um erro de digita��o que faz com que se crie uma
# uma nova categor�a, aparecem: Female, Male e male. Vamos arrumar o erro de digita��o

midata$Sex[midata$Sex == "male"] = "Male"
midata$Sex = factor(midata$Sex, levels = c("Male", "Female")) #convertir de novo em fator

#Pronto, conferir

table(midata$Sex)

summary(midata)



# PRONTO GENTEEEE
# Consertamos a tabela de dados, vamos salv�-la como CSV

write_csv(midata, "alituratus2.csv")




# FIM #