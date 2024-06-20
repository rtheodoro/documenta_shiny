#--------------------------------------------------------------------------#
#
# Nome do Script: criandomarkdown_readme
#
# Objetivo: Buscar pelo Readme original do projeto e adicionar informações de todos os scripts
#
# Autor: Ricardo Theodoro
# Email: rtheodoro@usp.br
# Data da criação: 2024-06-07
# 
#--------------------------------------------------------------------------#
#
# Notas:
#   
#--------------------------------------------------------------------------#
options(scipen = 6, digits = 4)
#--------------------------------------------------------------------------#

# Definir o diretório do projeto
arquivo_readme_original <- "README.md"
arquivos_md <- list.files(here::here(), pattern = "\\.md$", full.names = TRUE)
arquivo_readme_final <- "md_5_README_FINAL.md"

# Funcao ------------------------------------------------------------------

# Função para adicionar conteúdo ao README
adicionar_conteudo_readme_final <- function(diretorio_projeto, arquivo_readme, arquivos_md, arquivo_readme_final) {
  # Ler conteúdo do README original
  conteudo_readme_original <- readLines(file.path(diretorio_projeto, arquivo_readme))
  
  # Criar lista para armazenar conteúdo dos arquivos .md
  conteudo_md <- list()
  
  # Ler conteúdo dos arquivos .md e armazenar na lista
  for (arquivo_md in arquivos_md) {
    conteudo <- readLines(arquivo_md)
    conteudo_md[[basename(arquivo_md)]] <- conteudo
  }
  
  # Ordenar os arquivos .md por ordem alfabética
  arquivos_md_ordem <- sort(names(conteudo_md))
  
  # Adicionar conteúdo dos arquivos .md ao README final
  novo_conteudo_readme <- c(conteudo_readme_original, "")
  for (arquivo_md in arquivos_md_ordem) {
    novo_conteudo_readme <- c(novo_conteudo_readme, conteudo_md[[arquivo_md]], "")
  }
  
  # Escrever novo conteúdo no arquivo README final
  writeLines(novo_conteudo_readme, file.path(arquivo_readme_final))
  cat("O conteúdo foi adicionado ao README final com sucesso!\n")
}

# Aplicacao ---------------------------------------------------------------

# Chamar a função para adicionar conteúdo ao README
adicionar_conteudo_readme_final(diretorio, arquivo_readme_original, arquivos_md, arquivo_readme_final)
