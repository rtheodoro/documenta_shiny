#--------------------------------------------------------------------------#
#
# Nome do Script: encontrandopacotesefuncoes
#
# Objetivo: Irá encontrar todos os pacotes e funções utilizadas em todas 
#           as pastas do projeto
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
arquivo_markdown <- "md_1_documentacao_pacotes_funcoes.md"

# Funcoes -----------------------------------------------------------------

# Função para buscar pacotes e funções em arquivos .R
buscar_pacotes_funcoes <- function(diretorio) {
  # Listar todos os arquivos .R no diretório e subdiretórios
  arquivos_r <- list.files(path = diretorio, pattern = "\\.R$", recursive = TRUE, full.names = TRUE)
  
  # Inicializar uma lista para armazenar os resultados
  resultados <- list()
  
  # Expressão regular para encontrar pacotes e funções no formato pacote::funcao()
  padrao <- "\\b([a-zA-Z0-9\\.]+)::([a-zA-Z0-9_\\.]+)\\b"
  
  # Loop sobre cada arquivo .R
  purrr::walk(arquivos_r, function(arquivo) {
    # Ler o conteúdo do arquivo
    conteudo <- readLines(arquivo, warn = FALSE)
    
    # Concatenar todas as linhas em uma única string
    conteudo_str <- paste(conteudo, collapse = "\n")
    
    # Encontrar todas as correspondências do padrão
    matches <- stringr::str_match_all(conteudo_str, padrao)[[1]]
    
    # Se houver correspondências, adicionar aos resultados
    if (nrow(matches) > 0) {
      purrr::walk(seq_len(nrow(matches)), function(i) {
        resultados <<- append(resultados, list(dplyr::tibble(
          arquivo = arquivo,
          pacote = matches[i, 2],
          funcao = matches[i, 3]
        )))
      })
    }
  })
  
  # Combinar todos os data.frames em um único
  resultados_df <- dplyr::bind_rows(resultados)
  
  # Retornar os resultados únicos
  return(dplyr::distinct(resultados_df))
}

# Função para processar os resultados: remover duplicados e adicionar links de documentação
processar_resultados <- function(resultados_df) {
  resultados_df |>
    # Remover a coluna 'arquivo'
    dplyr::select(-arquivo) |>
    # Remover duplicados
    dplyr::distinct() |>
    # Adicionar a coluna de links
    dplyr::mutate(link = glue::glue("https://www.rdocumentation.org/packages/{pacote}/topics/{funcao}")) |>
    # Ordenar por pacote e função
    dplyr::arrange(pacote, funcao) -> resultados_processados
  
  return(resultados_processados)
  
  return(resultados_processados)
}

# Função para gerar um documento em Markdown
gerar_documento_markdown <- function(resultados_processados, arquivo_markdown) {
  # Adicionar a coluna com links clicáveis
  resultados_processados <- resultados_processados |>
    dplyr::mutate(Documentacao = glue::glue("[Documentação]({link})")) |>
    dplyr::select(-link) # Remover a coluna link original
  
  # Converter o data frame para formato markdown
  tabela_markdown <- resultados_processados |>
    dplyr::rename(Pacote = pacote, Funcao = funcao) |>
    knitr::kable(format = "markdown")
  
  # Escrever o conteúdo em um arquivo Markdown
  readr::write_lines(c(
    "# Documentação de Pacotes e Funções",
    "",
    "Esta tabela lista todos os pacotes e funções encontrados no projeto, com links para a documentação correspondente:",
    "",
    tabela_markdown
  ), arquivo_markdown)
  
  cat("Documento Markdown gerado com sucesso em:", arquivo_markdown, "\n")
}


# Aplicacoes --------------------------------------------------------------

# Buscar pacotes e funções
resultados <- buscar_pacotes_funcoes(diretorio)

# Exibir os resultados
print(resultados)

# Processar os resultados
resultados_processados <- processar_resultados(resultados)

# Exibir os resultados processados
print(resultados_processados)

# Chamar a função para gerar o documento
gerar_documento_markdown(resultados_processados, arquivo_markdown)