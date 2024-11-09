# Análise de Dados Eleitorais - Banco de Dados Relacional e Multidimensional

## Descrição do Projeto

Este repositório contém um projeto desenvolvido como atividade avaliativa da disciplina de **Modelagem de Dados** do curso **MBA em Engenharia de Dados** pela **Sirius/Comunidade Estatística**. O objetivo do projeto é criar uma estrutura de banco de dados relacional e um modelo multidimensional para análise de dados eleitorais referentes ao estado de Minas Gerais. Este modelo permitirá a realização de consultas e análises, facilitando a obtenção de insights sobre a participação dos candidatos e partidos nas eleições, com foco nos dados de votação por município.

## Estrutura do Projeto

O projeto inclui:

- **Modelo de Banco de Dados Relacional**: Estrutura projetada para armazenar informações detalhadas sobre candidatos, eleições, cargos, partidos, coligações, municípios, redes sociais dos candidatos, bens dos candidatos, e dados de votação.
- **Modelo Multidimensional (Star Schema)**: Estrutura de data warehouse para análise de dados eleitorais, projetada para permitir consultas analíticas rápidas e eficazes.
- **Estudo de Volumetria**: Análise do volume de dados esperado em cada tabela, considerando o armazenamento necessário para processar e armazenar os dados de votação de todos os municípios de Minas Gerais.

## Estruturas de Dados

### Banco de Dados Relacional

A estrutura relacional do banco de dados inclui as seguintes tabelas principais:

1. **Candidato**: Informações dos candidatos.
2. **Rede Social**: Perfis de redes sociais dos candidatos.
3. **Bem do Candidato**: Bens declarados pelos candidatos.
4. **Eleição**: Informações sobre as eleições.
5. **Cargo**: Cargos aos quais os candidatos concorrem.
6. **Partido**: Informações dos partidos políticos.
7. **Coligação/Federação**: Coligações ou federações de partidos.
8. **Votação**: Detalhes das votações dos candidatos.
9. **Município**: Dados dos municípios.
10. **Motivo Cassação**: Motivos de cassação dos candidatos, se houver.

### Modelo Multidimensional (Star Schema)

Para o modelo de data warehouse, os dados estão organizados em uma estrutura de esquema estrela, composta por:

- **Fato Votação**: Armazena as métricas de votação, como quantidade de votos nominais e quantidade de votos válidos.
- **Dimensões**:
  - **Dimensão Candidato**: Informações detalhadas sobre o candidato.
  - **Dimensão Eleição**: Dados da eleição (ano, tipo, abrangência).
  - **Dimensão Cargo**: Informações sobre o cargo.
  - **Dimensão Partido**: Dados sobre o partido.
  - **Dimensão Município**: Dados geográficos dos municípios de Minas Gerais.
  - **Dimensão Coligação**: Informações sobre as coligações.

### Volumetria

O estudo de volumetria foi realizado para prever o tamanho e a distribuição dos dados, com base nos registros esperados e no tamanho médio de cada registro.

## Scripts e Arquivos

O repositório contém:

- `schema_relacional.sql`: Script de criação do banco de dados relacional com as tabelas, chaves primárias e estrangeiras, índices, e restrições de integridade.
- `schema_multidimensional.sql`: Script de criação do modelo multidimensional (Star Schema), incluindo as tabelas de fato e dimensões.
- `README.md` (este arquivo): Documentação do projeto e estrutura do repositório.

## Configuração do Banco de Dados

Este projeto foi projetado para o **SQL Server**. Abaixo estão os passos de configuração:

1. **Criação do Banco de Dados**: Execute o comando `CREATE DATABASE` com charset e collation apropriados para português-brasileiro.
2. **Execução dos Scripts**: Carregue e execute `schema_relacional.sql` para criar o banco de dados relacional e `schema_multidimensional.sql` para o modelo multidimensional.
3. **Verificação de Índices e Restrições**: Certifique-se de que as chaves, índices e restrições foram aplicados corretamente após a execução dos scripts.

## Como Contribuir

Este projeto é uma atividade de avaliação e, portanto, contribuições externas não são aceitas no momento. No entanto, feedbacks e sugestões podem ser enviadas por meio de **Issues** neste repositório.

## Licença

Este projeto foi desenvolvido exclusivamente para fins educacionais e avaliativos e não possui uma licença específica para uso comercial.

---

**Autor:** Flávia Maria Dugulin Castrp  
**Curso:** MBA em Engenharia de Dados  
**Instituição:** Sirius/Comunidade Estatística  
**Disciplina:** Modelagem de Dados
