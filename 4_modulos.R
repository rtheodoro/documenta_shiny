#--------------------------------------------------------------------------#
#
# Nome do Script: modulos
#
# Objetivo: Procurar por informações importantes sobre cada módulo do projeto
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

# Definir o diretório raiz e o arquivo de saída

arquivo_saida <- "md_4_modulos.md"

# Funcoes -----------------------------------------------------------------
# Função para buscar arquivos e coletar texto
coletar_texto_modulos <- function(diretorio_raiz) {
  # Encontrar arquivos que começam com "mod_"
  arquivos_modulos <- list.files(diretorio_raiz, pattern = "^mod_.*\\.R$", recursive = TRUE, full.names = TRUE)
  
  # Inicializar lista para armazenar nomes dos módulos e textos
  nomes_modulos <- vector("character", length(arquivos_modulos))
  textos_modulos <- vector("character", length(arquivos_modulos))
  
  # Iterar sobre os arquivos para coletar nomes e textos
  for (i in seq_along(arquivos_modulos)) {
    # Ler conteúdo do arquivo
    conteudo <- readLines(arquivos_modulos[i])
    
    # Extrair nome do módulo (removendo diretório e extensão)
    nomes_modulos[i] <- basename(arquivos_modulos[i])
    
    # Extrair texto até a linha contendo @importFrom (inclusive)
    indice_fim <- grep("@importFrom", conteudo)
    texto_modulo <- conteudo[1:indice_fim]
    
    # Armazenar texto do módulo
    textos_modulos[i] <- paste(texto_modulo, collapse = "\n")
  }
  
  # Retornar lista de nomes e textos dos módulos
  list(nomes_modulos = nomes_modulos, textos_modulos = textos_modulos)
}

# Função para criar arquivo Markdown com nome e texto dos módulos
criar_markdown_modulos <- function(diretorio_raiz, arquivo_saida) {
  # Coletar nomes e textos dos módulos
  modulos <- coletar_texto_modulos(diretorio_raiz)
  
  # Criar texto Markdown
  markdown_texto <- ""
  for (i in seq_along(modulos$nomes_modulos)) {
    markdown_texto <- paste0(markdown_texto, "# ", modulos$nomes_modulos[i], "\n\n")
    markdown_texto <- paste0(markdown_texto, modulos$textos_modulos[i], "\n\n")
  }
  
  # Escrever texto Markdown em arquivo
  writeLines(markdown_texto, arquivo_saida)
  cat("O arquivo Markdown foi criado com sucesso e salvo em:", arquivo_saida, "\n")
}

# Aplicacao ---------------------------------------------------------------

# Chamar a função para criar o arquivo Markdown
criar_markdown_modulos(diretorio, arquivo_saida)
