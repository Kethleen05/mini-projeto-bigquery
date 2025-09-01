# Mini Projeto: Pipeline de Dados e Análise com SQL no BigQuery

## Descrição
Este projeto cria um data warehouse simples no Google BigQuery para a Livraria DevSaber, uma livraria fictícia. O objetivo foi estruturar os dados em três tabelas (`Clientes`, `Produtos` e `Vendas`), inserir os dados fornecidos, realizar análises com consultas SQL e criar uma View (`v_relatorio_vendas_detalhado`) para facilitar relatórios. Durante o processo, os dados foram duplicados devido a múltiplas execuções do `INSERT` após a ativação do faturamento. Para corrigir, utilizei `TRUNCATE TABLE` em todas as tabelas e reinsirei os dados corretos, resultando em 4 clientes, 4 produtos e 6 vendas.

## Arquivos do Projeto
- `create_schema.sql`: Contém os comandos para criar as tabelas `Clientes`, `Produtos` e `Vendas`.
- `insert_data.sql`: Inclui os comandos `INSERT INTO` para popular as tabelas com os dados da livraria.
- `analysis_and_view.sql`: Contém as cinco consultas de análise e a criação da View `v_relatorio_vendas_detalhado`.
- `README.md`: Este arquivo, com a documentação do projeto e respostas às perguntas.

## Respostas às Perguntas do Conteúdo Guiado

### 1. Por que uma planilha não é ideal para uma empresa que quer analisar suas vendas a fundo?
Planilhas como Excel são limitadas para grandes volumes de dados, pois não escalam bem e podem travar ou apresentar erros. Elas também não suportam relacionamentos complexos entre tabelas e são propensas a duplicatas ou edições manuais incorretas. O BigQuery, por outro lado, permite análises rápidas em grandes conjuntos de dados, com consultas SQL eficientes e estrutura relacional.

### 2. Que tipo de perguntas vocês acham que o dono da livraria gostaria de responder com esses dados?
O dono da livraria poderia querer saber: Qual cliente comprou mais livros? Quais produtos são os mais vendidos? Qual o total de vendas por estado? Qual categoria (ex.: Ficção Científica) está performando melhor? Quais foram as vendas por mês?

### 3. Com base nos dados brutos, quais outras duas tabelas precisamos criar? Que colunas e tipos de dados elas teriam?
Além da tabela `Vendas`, precisamos criar:
- `Clientes` (ID_Cliente INT64, Nome_Cliente STRING, Email_Cliente STRING, Estado_Cliente STRING).
- `Produtos` (ID_Produto INT64, Nome_Produto STRING, Categoria_Produto STRING, Preco_Produto NUMERIC).

### 4. Se o BigQuery não tem chaves estrangeiras, como garantimos que um ID_Cliente na tabela de vendas realmente existe na tabela de clientes?
Garantimos isso manualmente ao inserir os dados, assegurando que os `ID_Cliente` em `Vendas` correspondam a valores existentes em `Clientes`. Nas consultas, usamos `JOIN` com condições (ex.: `ON V.ID_Cliente = C.ID_Cliente`), o que só retorna linhas válidas, descartando IDs que não existem.

### 5. Por que é uma boa prática inserir os clientes e produtos em suas próprias tabelas antes de inserir os dados de vendas?
Inserir `Clientes` e `Produtos` antes evita duplicatas (normalização) e mantém a consistência dos dados. Isso facilita atualizações (ex.: mudar o preço de um produto afeta todas as vendas) e garante que os IDs referenciados em `Vendas` já existam, evitando erros.

### 6. Em um cenário com milhões de vendas por dia, o INSERT seria a melhor abordagem?
Não, o `INSERT` é lento e impraticável para milhões de vendas por dia. Seria melhor usar `LOAD DATA` para carregar arquivos CSV/JSON ou integrações como Google Dataflow para ingestão em batch, otimizando o desempenho.

### 7. Qual é a principal vantagem de usar uma VIEW em vez de simplesmente salvar o código em um arquivo de texto?
A View é uma tabela virtual armazenada no BigQuery, atualizada automaticamente com mudanças nos dados base. Isso permite consultas como uma tabela real, facilita o reuso sem copiar código e simplifica análises futuras.

### 8. Se o preço de um produto mudar na tabela Produtos, o Valor_Total na View será atualizado automaticamente na próxima vez que a consultarmos?
Sim, porque a View recalcula dinamicamente o `Valor_Total` (Quantidade * Preco_Produto) a cada consulta, refletindo os preços atualizados na tabela `Produtos`.

## Conclusão

Projeto realizado pelo grupo 3_4. Este trabalho foi uma oportunidade de aprender a estruturar dados, realizar análises e corrigir problemas como duplicatas em um ambiente de Big Data.
