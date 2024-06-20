#--------------------------------------------------------------------------#
#
# Nome do Script: main
#
# Objetivo: irá rodar todos os scripts do projeto
#
# Autor: Ricardo Theodoro
# Email: rtheodoro@usp.br
# Data da criação: 2024-06-06
# 
#--------------------------------------------------------------------------#
#
# Notas: 
#   
#--------------------------------------------------------------------------#
options(scipen = 6, digits = 4)
#--------------------------------------------------------------------------#

# Definir o diretório a ser buscado
diretorio <- ""

# Rodar o script encontrandopacotesefuncoes
source("1_encontrandopacotesefuncoes.R")

# Rodar o script arvoredeworkflow
source("2_arvoredeworkflow.R")

# Rodar o script description
source("3_description.R")

# Rodar o script modulos
source("4_modulos.R")

# Juntar tudo em um arquivo README.md, junto ao que está na pasta original
source("5_criandomarkdown_readme.R")


# Após gerar o arquivo final, é nessário passar um pente fino nas informações e ajustar o que for necessário



