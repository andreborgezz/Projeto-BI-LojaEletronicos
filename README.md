# 📊 Projeto BI – EletroPrime

Projeto de Analise de dados e Business Intelligence (BI) desenvolvido para prática real de mercado, simulando uma loja de eletrônicos fictícia chamada **EletroPrime** ⚡📱💻.

O foco do projeto é trabalhar desde a criação do banco de dados até a construção de dashboards no Power BI, com métricas corretas e sem repetição de informação entre as páginas.

---

## 🎯 Objetivo

Construir um BI completo que responda:
- Como está o desempenho geral da empresa
- Quais produtos geram mais resultado
- Como está a eficiência das entregas (operação)

---

## 🛠 Tecnologias Utilizadas

- 🗄️ MySQL (banco de dados)
- 🐍 Python (extração dos dados)
- 📊 Power BI (DAX e dashboards)

---

## 🗂 Banco de Dados

O banco foi criado em MySQL, com tabelas relacionadas simulando um cenário real de vendas.

Principais tabelas:
- clientes  
- produtos (com preço de venda e custo unitário)  
- categorias  
- lojas  
- pedidos  
- itens_pedido  
- pagamentos  
- entregas  

Os dados são **fictícios**, mas coerentes.  
Os scripts de **INSERT foram gerados com auxílio de Inteligência Artificial**, garantindo volume e variedade para análise.

<img width="267" height="203" alt="image" src="https://github.com/user-attachments/assets/fe85b00b-c470-450b-9b4f-ef19b283d467" />

---

## 🔄 Transformação (Python)

O Python foi utilizado para:
- Conectar ao banco MySQL
- Ler as tabelas
- Exportar os dados para arquivos CSV 
- Disponibilizar os dados para consumo no Power BI

Não houve transformação nessa etapa, apenas extração de dados.

<img width="161" height="364" alt="image" src="https://github.com/user-attachments/assets/a5e68479-1182-4a73-a6ef-89b2ad3b653b" />

---

## 📊 Power BI

### 🔗 Modelagem
- Modelo relacional com relacionamentos corretos entre tabelas
- Estrutura preparada para análises de vendas, lucro e operação

### 🧮 Medidas Criadas (DAX)
- Receita  
- Quantidade Vendida  
- Pedidos  
- Custo Total  
- Lucro  
- Ticket Médio  
- Margem (%)  

As métricas foram validadas para evitar erros comuns, como soma incorreta de custos ou contagem errada de pedidos.

---

## 📑 Dashboards

O projeto possui **3 páginas**, cada uma com um papel claro.

### 1️⃣ Visão Geral
- KPIs: Receita, Pedidos, Lucro e Ticket Médio
- Receita ao longo do tempo
- Receita por categoria
- Filtros por loja, categoria e data

📷 
<img width="1281" height="717" alt="image" src="https://github.com/user-attachments/assets/19b6192a-aa81-48eb-b24c-92197fc92c41" />


---

### 2️⃣ Produtos
- KPIs de produtos (Receita, Lucro e Quantidade Vendida)
- Ranking de produtos por receita
- Lucro por produto
- Tabela de apoio com produtos e lucro
- Filtros por loja e data

📷 
<img width="1277" height="719" alt="image" src="https://github.com/user-attachments/assets/bfd6ae53-7250-44f5-9179-b06579834ddc" />

---

### 3️⃣ Entregas / Operação
- KPIs:
  - Pedidos Entregues
  - Entregues no Prazo
  - Entregues com Atraso
  - % Entregue no Prazo
- Gráfico por status de entrega
- Tendência mensal de entregas no prazo

As métricas de entrega foram corrigidas usando comparação de datas, evitando contagens incorretas por status.

📷 
<img width="1277" height="717" alt="image" src="https://github.com/user-attachments/assets/ffc6c9c0-c56c-4635-8622-57ace51a1b3c" />
---

## ✅ Status do Projeto

Projeto finalizado e pronto para portfólio.

---

## 👤 Autor

Projeto desenvolvido por **André Borges**.
