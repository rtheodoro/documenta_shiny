# Pacote de Análise e Documentação de Projetos em R

O pacote `Pacote de Análise e Documentação de Projetos em R` é uma ferramenta poderosa para análise e documentação de projetos em R. Ele automatiza várias tarefas relacionadas à busca de pacotes e funções, criação de uma árvore do workflow do projeto, extração de informações do arquivo Description e geração de documentação para módulos específicos.

ATENÇÃO: Para coletar informações sobre as funções utilizadas, elas devem estar no formato inseridas nos scripts do projeto no formato `pacote::funcao()`.

## Instalação

Para instalar o pacote, você pode clonar o repositório do GitHub:
  
```R
devtools::install_github("rtheodoro/pacote-analise-projetos-r")
```
## Como Usar

Para utilizar as funcionalidades deste pacote, basta executar o script `0_main.R`. Este script chama todos os outros scripts na ordem correta e cria a documentação final do projeto.

## Funcionalidades

### Encontrando Pacotes e Funções

O script `1_encontrandopacotesefuncoes.R` busca por todos os arquivos .R em um diretório específico, identifica os pacotes e funções usadas e salva os resultados em um arquivo.

### Criando uma Árvore do Workflow

O script `2_arvoredeworkflow.R` gera uma árvore do workflow do projeto, mostrando a relação entre os arquivos e as funções usadas.

### Extração de Informações do Arquivo Description

O script `3_description.R` extrai informações do arquivo Description do projeto e cria um markdown com essas informações.

### Criando Documentação para Módulos Específicos

O script `4_modulos.R` busca por arquivos que começam com "mod_" e cria documentação para esses módulos, incluindo o texto entre os comentários #' e #' @importFrom.

### Criando o README Final

O script `5_criandomarkdown_readme.R` junta todas as informações coletadas nos scripts anteriores e adiciona ao final do README original do projeto, criando assim um documento abrangente com uma documentação mais detalhada do projeto.

## Contribuindo

Se você tiver sugestões de melhorias ou encontrar algum problema, por favor, abra uma issue ou envie um pull request.

## Licença

Este projeto está licenciado sob a Licença MIT. Consulte o arquivo LICENSE para obter mais detalhes.