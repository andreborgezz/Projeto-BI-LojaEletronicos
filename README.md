# Projeto-BI-LojaEletronicos

# 📊 Loja Eletrônicos – Business Intelligence

Projeto de **Business Intelligence end-to-end** utilizando **MySQL**, **Python** e **Power BI**, com foco em prática real de mercado e construção de dashboards para análise de vendas.

O objetivo do projeto é simular um cenário real de uma loja de eletrônicos, desde a modelagem do banco de dados até a visualização final dos dados no Power BI.

---

## 🎯 Objetivo do Projeto

- Criar uma base de dados relacional realista
- Simular vendas, clientes, produtos, lojas e entregas
- Extrair dados do banco utilizando Python
- Consumir os dados no Power BI para análise e tomada de decisão
- Desenvolver dashboards claros, objetivos e profissionais

---

## 🧱 Arquitetura do Projeto


MySQL (OLTP)
↓
Python (extração dos dados)
↓
Arquivos CSV
↓
Power BI (modelagem e dashboards)


---

## 🗄️ Banco de Dados

O banco foi modelado em **MySQL**, com tabelas normalizadas e relacionamentos reais.

### Principais tabelas:
- `cliente`
- `produto`
- `categoria`
- `loja`
- `pedido`
- `item_pedido`
- `pagamento`
- `entrega`

Características:
- Relacionamentos com chaves estrangeiras
- Dados fictícios, porém coerentes
- Cada pedido possui exatamente um item (simplificação didática)
- Custos e valores de venda permitem cálculo de lucro

---

## 🐍 Python

O Python foi utilizado como camada intermediária para:

- Conectar ao banco MySQL
- Extrair os dados das tabelas
- Gerar arquivos CSV para consumo no Power BI

Essa abordagem facilita:
- Organização dos dados
- Independência de conexão direta do Power BI com o banco
- Clareza no pipeline de dados

---

## 📈 Power BI

No Power BI, os dados são utilizados para:

- Criar o modelo de dados com relacionamentos
- Desenvolver medidas de negócio (receita, pedidos, ticket médio, lucro)
- Construir dashboards analíticos

### Dashboards planejados:
- **Visão Geral** (KPIs e evolução de vendas)
- **Produtos** (ranking e desempenho)
- **Clientes** (análise de consumo)
- **Lojas** (performance por unidade)

---

## 🛠️ Tecnologias Utilizadas

- **MySQL** – Banco de dados relacional
- **Python** – Extração e organização dos dados
- **Pandas** – Manipulação de dados
- **SQLAlchemy** – Conexão com o banco
- **Power BI Desktop** – Visualização e análise
- **Git & GitHub** – Versionamento e portfólio

---

## 📁 Organização do Repositório (sugestão)


/sql
└── schema.sql
/python
└── extracao_csv.py
/csv
└── *.csv
/powerbi
└── loja-eletronicos.pbix
README.md


---

## 🚀 Próximos Passos

- Finalizar dashboards no Power BI
- Melhorar layout e storytelling visual
- Evoluir o projeto com camada analítica (fato e dimensões)
- Explorar novas métricas de negócio

---

## 📌 Observações

Este projeto tem foco em **aprendizado prático**, organização de dados e visualização, priorizando clareza e boas práticas de BI.

---

👤 Projeto desenvolvido por **André Borges**
