#--------------------------------------------------------------------------#
#
# Nome do Script: arvoredeworkflow
#
# Objetivo: Irá encontrar todas as pastas e arquivos do projeto e gerar uma árvore de diretórios
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

# Definir arquivo de saida
arquivo_saida <- "md_2_workflow_arvore.md"

# Funções -----------------------------------------------------------------
# Função para gerar a árvore do workflow
gerar_arvore_workflow <- function(diretorio_raiz, arquivo_saida) {
  # Função recursiva para construir a árvore
  construir_arvore <- function(diretorio, nivel = 0) {
    conteudo <- fs::dir_ls(diretorio, all = TRUE)
    arvore <- character()
    
    for (item in conteudo) {
      nome <- fs::path_file(item)
      indentacao <- strrep("  ", nivel)
      if (fs::is_dir(item)) {
        arvore <- c(arvore, glue::glue("{indentacao}- {nome}/"))
        arvore <- c(arvore, construir_arvore(item, nivel + 1))
      } else {
        arvore <- c(arvore, glue::glue("{indentacao}- {nome}"))
      }
    }
    
    return(arvore)
  }
  
  # Construir a árvore a partir do diretório raiz
  arvore_workflow <- construir_arvore(diretorio_raiz)
  
  # Escrever a árvore em um arquivo Markdown
  readr::write_lines(c("# Workflow \n\n Esta árvore do workflow mostra a estrutura dos diretórios e arquivos em todo o projeto.\n\n", arvore_workflow), arquivo_saida)
  
  cat("Árvore do workflow gerada com sucesso em:", arquivo_saida, "\n")
}

# Aplicação ----------------------------------------------------------------

# Chamar a função para gerar a árvore do workflow
gerar_arvore_workflow(diretorio, arquivo_saida)
