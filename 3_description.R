#--------------------------------------------------------------------------#
#
# Nome do Script: 
#
# Objetivo:
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

# Definir o caminho do arquivo markdown de saída

arquivo_saida <- "md_3_description.md"

# Funcoes -----------------------------------------------------------------

# Função para encontrar e transformar o arquivo Description em Markdown
transformar_description <- function(diretorio_raiz, arquivo_saida) {
  # Encontrar o arquivo Description
  caminho_description <- fs::dir_ls(diretorio_raiz, regexp = "DESCRIPTION$", recursive = TRUE)
  
  # Verificar se o arquivo Description foi encontrado
  if (length(caminho_description) == 0) {
    cat("O arquivo Description não foi encontrado no diretório especificado.\n")
    return()
  }
  
  # Ler o conteúdo do arquivo Description
  descricao <- readr::read_lines(caminho_description)
  
  # Escrever a descrição em um arquivo Markdown
  readr::write_lines(c("# Resumo da descrição do pacote \n",descricao), arquivo_saida)
  
  cat("O arquivo Description foi transformado em Markdown com sucesso e salvo em:", arquivo_saida, "\n")
}

# Aplicacao ---------------------------------------------------------------

# Chamar a função para transformar o arquivo Description em Markdown
transformar_description(diretorio, arquivo_saida)
